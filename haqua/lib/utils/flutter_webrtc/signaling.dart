import 'dart:convert';
import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:template/helper/izi_number.dart';

import '../../helper/izi_validate.dart';
import 'random_string.dart';

import 'package:template/utils/flutter_webrtc/device_info.dart' if (dart.library.js) '../utils/device_info_web.dart';
import 'package:template/utils/flutter_webrtc/websocket.dart' if (dart.library.js) '../utils/websocket_web.dart';
import 'package:template/utils/flutter_webrtc/turn.dart' if (dart.library.js) '../utils/turn_web.dart';

///
///SignalingState
///
enum SignalingState {
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}

///
///CallState
///
enum CallState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
}

///
///Session
///
class Session {
  Session({required this.sid, required this.pid});
  String pid;
  String sid;
  RTCPeerConnection? pc;
  RTCDataChannel? dc;
  List<RTCIceCandidate> remoteCandidates = [];
}

class Signaling {
  Signaling(this._host);

  final JsonEncoder _encoder = const JsonEncoder();
  final JsonDecoder _decoder = const JsonDecoder();
  final String _selfId = randomNumeric(6);
  SimpleWebSocket? _socket;
  final _host;
  final _port = 8086;
  var _turnCredential;
  final Map<String, Session> _sessions = {};
  MediaStream? _localStream;
  final List<MediaStream> _remoteStreams = <MediaStream>[];

  Function(SignalingState state)? onSignalingStateChange;
  Function(Session session, CallState state)? onCallStateChange;
  Function(MediaStream stream)? onLocalStream;
  Function(Session session, MediaStream stream)? onAddRemoteStream;
  Function(Session session, MediaStream stream)? onRemoveRemoteStream;
  Function(dynamic event)? onPeersUpdate;
  Function(Session session, RTCDataChannel dc, RTCDataChannelMessage data)? onDataChannelMessage;
  Function(Session session, RTCDataChannel dc)? onDataChannel;

  String get sdpSemantics => WebRTC.platformIsWindows ? 'plan-b' : 'unified-plan';

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
      */
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  ///
  ///close
  ///
  Future<void> close() async {
    await _cleanSessions();
    _socket?.close();
  }

  ///
  ///switchCamera
  ///
  void switchCamera() {
    if (_localStream != null) {
      Helper.switchCamera(_localStream!.getVideoTracks()[0]);
    }
  }

  ///
  ///muteMic
  ///
  void muteMic() {
    if (_localStream != null) {
      final bool enabled = _localStream!.getAudioTracks()[0].enabled;
      _localStream!.getAudioTracks()[0].enabled = !enabled;
    }
  }

  ///
  /// turnOnCamera
  ///
  void onChangedCamera({required bool enabled}) {
    _localStream!.getTracks().forEach((element) {
      element.enabled = enabled;
    });
  }

  ///
  /// changeTypeVolume
  ///
  void changeTypeVolume({required bool enabled}) {
    _localStream?.getAudioTracks().first.enableSpeakerphone(enabled);
  }

  ///
  ///invite
  ///
  Future<void> invite(String peerId, String media, bool useScreen) async {
    final sessionId = '$_selfId-$peerId';
    final Session session = await _createSession(null, peerId: peerId, sessionId: sessionId, media: media, screenSharing: useScreen);
    _sessions[sessionId] = session;
    if (media == 'data') {
      _createDataChannel(session);
    }
    _createOffer(session, media);
    onCallStateChange?.call(session, CallState.CallStateNew);
    onCallStateChange?.call(session, CallState.CallStateInvite);
  }

  ///
  ///bye
  ///
  void bye(String sessionId) {
    _send('bye', {
      'session_id': sessionId,
      'from': _selfId,
    });
    final sess = _sessions[sessionId];
    if (sess != null) {
      _closeSession(sess);
    }
  }

  ///
  ///accept
  ///
  void accept(String sessionId) {
    final session = _sessions[sessionId];
    if (session == null) {
      return;
    }
    _createAnswer(session, 'video');
  }

  ///
  ///reject
  ///
  void reject(String sessionId) {
    final session = _sessions[sessionId];
    if (session == null) {
      return;
    }
    bye(session.sid);
  }

  ///
  ///onMessage
  ///
  Future<void> onMessage(message) async {
    final Map<String, dynamic> mapData = message as Map<String, dynamic>;
    final data = mapData['data'];

    switch (mapData['type']) {
      case 'peers':
        {
          final List<dynamic> peers = data as List<dynamic>;
          if (onPeersUpdate != null) {
            final Map<String, dynamic> event = <String, dynamic>{};
            event['self'] = _selfId;
            event['peers'] = peers;
            onPeersUpdate?.call(event);
          }
        }
        break;
      case 'offer':
        {
          final peerId = data['from'];
          final description = data['description'];
          final media = data['media'];
          final sessionId = data['session_id'];
          final session = _sessions[sessionId];
          final newSession = await _createSession(session, peerId: peerId.toString(), sessionId: sessionId.toString(), media: media.toString(), screenSharing: false);
          _sessions[sessionId.toString()] = newSession;
          await newSession.pc?.setRemoteDescription(RTCSessionDescription(description['sdp'].toString(), description['type'].toString()));
          // await _createAnswer(newSession, media);

          if (newSession.remoteCandidates.isNotEmpty) {
            for (final candidate in newSession.remoteCandidates) {
              await newSession.pc?.addCandidate(candidate);
            }
            newSession.remoteCandidates.clear();
          }
          onCallStateChange?.call(newSession, CallState.CallStateNew);

          onCallStateChange?.call(newSession, CallState.CallStateRinging);
        }
        break;
      case 'answer':
        {
          final description = data['description'];
          final sessionId = data['session_id'];
          final session = _sessions[sessionId];
          session?.pc?.setRemoteDescription(RTCSessionDescription(description['sdp'].toString(), description['type'].toString()));
          onCallStateChange?.call(session!, CallState.CallStateConnected);
        }
        break;
      case 'candidate':
        {
          final peerId = data['from'];
          final candidateMap = data['candidate'];
          final sessionId = data['session_id'];
          final session = _sessions[sessionId];
          final RTCIceCandidate candidate = RTCIceCandidate(candidateMap['candidate'].toString(), candidateMap['sdpMid'].toString(), IZINumber.parseInt(candidateMap['sdpMLineIndex']));

          if (session != null) {
            if (session.pc != null) {
              await session.pc?.addCandidate(candidate);
            } else {
              session.remoteCandidates.add(candidate);
            }
          } else {
            _sessions[sessionId.toString()] = Session(pid: peerId.toString(), sid: sessionId.toString())..remoteCandidates.add(candidate);
          }
        }
        break;
      case 'leave':
        {
          final peerId = data as String;
          _closeSessionByPeerId(peerId);
        }
        break;
      case 'bye':
        {
          final sessionId = data['session_id'];
          final session = _sessions.remove(sessionId);
          if (session != null) {
            onCallStateChange?.call(session, CallState.CallStateBye);
            _closeSession(session);
          }
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      default:
        break;
    }
  }

  ///
  ///connect
  ///
  Future<void> connect() async {
    // final url = 'https://$_host:$_port/ws';
    final url = 'https://$_host/ws';
    _socket = SimpleWebSocket(url);

    print('connect to $url');

    if (_turnCredential == null) {
      try {
        _turnCredential = await getTurnCredential(_host.toString(), _port);
        /*{
            "username": "1584195784:mbzrxpgjys",
            "password": "isyl6FF6nqMTB9/ig5MrMRUXqZg",
            "ttl": 86400,
            "uris": ["turn:127.0.0.1:19302?transport=udp"]
          }
        */
        _iceServers = {
          'iceServers': [
            {'urls': _turnCredential['uris'][0], 'username': _turnCredential['username'], 'credential': _turnCredential['password']},
          ]
        };
      } catch (e) {}
    }

    _socket?.onOpen = () {
      print('onOpen');
      onSignalingStateChange?.call(SignalingState.ConnectionOpen);
      _send('new', {'name': DeviceInfo.label, 'id': _selfId, 'user_agent': DeviceInfo.userAgent});
    };

    _socket?.onMessage = (message) {
      onMessage(_decoder.convert(message.toString()));
    };

    _socket?.onClose = (int? code, String? reason) {
      print('Closed by server [$code => $reason]!');
      onSignalingStateChange?.call(SignalingState.ConnectionClosed);
    };

    await _socket?.connect();
  }

  ///
  ///createStream
  ///
  Future<MediaStream> createStream(String media, bool userScreen) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': userScreen ? false : true,
      'video': userScreen
          ? true
          : {
              'mandatory': {
                'minWidth': '640', // Provide your own width, height and frame rate here
                'minHeight': '480',
                'minFrameRate': '30',
              },
              'facingMode': 'user',
              'optional': [],
            }
    };

    final MediaStream stream = userScreen ? await navigator.mediaDevices.getDisplayMedia(mediaConstraints) : await navigator.mediaDevices.getUserMedia(mediaConstraints);
    onLocalStream?.call(stream);
    return stream;
  }

  ///
  ///createShareScreenStream
  ///
  Future<MediaStream> createShareScreenStream() async {
    final Map<String, dynamic> mediaConstraints = {'audio': true, 'video': true};

    final MediaStream stream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
    onLocalStream?.call(stream);
    return stream;
  }

  ///
  ///_createSession
  ///
  Future<Session> _createSession(Session? session, {required String peerId, required String sessionId, required String media, required bool screenSharing}) async {
    final newSession = session ?? Session(sid: sessionId, pid: peerId);
    if (media != 'data') {
      _localStream = await createStream(media, screenSharing);
    }
    print(_iceServers);
    final RTCPeerConnection pc = await createPeerConnection({
      ..._iceServers,
      ...{'sdpSemantics': sdpSemantics}
    }, _config);
    if (media != 'data') {
      switch (sdpSemantics) {
        case 'plan-b':
          pc.onAddStream = (MediaStream stream) {
            onAddRemoteStream?.call(newSession, stream);
            _remoteStreams.add(stream);
          };
          await pc.addStream(_localStream!);
          break;
        case 'unified-plan':
          // Unified-Plan
          pc.onTrack = (event) {
            if (event.track.kind == 'video') {
              onAddRemoteStream?.call(newSession, event.streams[0]);
            }
          };
          _localStream!.getTracks().forEach((track) {
            pc.addTrack(track, _localStream!);
          });
          break;
      }

      // Unified-Plan: Simuclast
      /*
      await pc.addTransceiver(
        track: _localStream.getAudioTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendOnly, streams: [_localStream]),
      );

      await pc.addTransceiver(
        track: _localStream.getVideoTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendOnly,
            streams: [
              _localStream
            ],
            sendEncodings: [
              RTCRtpEncoding(rid: 'f', active: true),
              RTCRtpEncoding(
                rid: 'h',
                active: true,
                scaleResolutionDownBy: 2.0,
                maxBitrate: 150000,
              ),
              RTCRtpEncoding(
                rid: 'q',
                active: true,
                scaleResolutionDownBy: 4.0,
                maxBitrate: 100000,
              ),
            ]),
      );*/
      /*
        var sender = pc.getSenders().find(s => s.track.kind == "video");
        var parameters = sender.getParameters();
        if(!parameters)
          parameters = {};
        parameters.encodings = [
          { rid: "h", active: true, maxBitrate: 900000 },
          { rid: "m", active: true, maxBitrate: 300000, scaleResolutionDownBy: 2 },
          { rid: "l", active: true, maxBitrate: 100000, scaleResolutionDownBy: 4 }
        ];
        sender.setParameters(parameters);
      */
    }
    pc.onIceCandidate = (candidate) async {
      if (candidate == null) {
        print('onIceCandidate: complete!');
        return;
      }
      // This delay is needed to allow enough time to try an ICE candidate
      // before skipping to the next one. 1 second is just an heuristic value
      // and should be thoroughly tested in your own environment.
      await Future.delayed(
          const Duration(seconds: 1),
          () => _send('candidate', {
                'to': peerId,
                'from': _selfId,
                'candidate': {
                  'sdpMLineIndex': candidate.sdpMLineIndex,
                  'sdpMid': candidate.sdpMid,
                  'candidate': candidate.candidate,
                },
                'session_id': sessionId,
              }));
    };

    pc.onIceConnectionState = (state) {};

    pc.onRemoveStream = (stream) {
      onRemoveRemoteStream?.call(newSession, stream);
      _remoteStreams.removeWhere((it) {
        return it.id == stream.id;
      });
    };

    pc.onDataChannel = (channel) {
      _addDataChannel(newSession, channel);
    };

    newSession.pc = pc;
    return newSession;
  }

  ///
  ///_addDataChannel
  ///
  void _addDataChannel(Session session, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};
    channel.onMessage = (RTCDataChannelMessage data) {
      onDataChannelMessage?.call(session, channel, data);
    };
    session.dc = channel;
    onDataChannel?.call(session, channel);
  }

  ///
  ///_createDataChannel
  ///
  Future<void> _createDataChannel(Session session, {label = 'fileTransfer'}) async {
    final RTCDataChannelInit dataChannelDict = RTCDataChannelInit()..maxRetransmits = 30;
    final RTCDataChannel channel = await session.pc!.createDataChannel(label.toString(), dataChannelDict);
    _addDataChannel(session, channel);
  }

  ///
  ///_createOffer
  ///
  Future<void> _createOffer(Session session, String media) async {
    try {
      final RTCSessionDescription s = await session.pc!.createOffer(media == 'data' ? _dcConstraints : {});
      await session.pc!.setLocalDescription(s);
      _send('offer', {
        'to': session.pid,
        'from': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
        'media': media,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///
  ///_createAnswer
  ///
  Future<void> _createAnswer(Session session, String media) async {
    try {
      final RTCSessionDescription s = await session.pc!.createAnswer(media == 'data' ? _dcConstraints : {});
      await session.pc!.setLocalDescription(s);
      _send('answer', {
        'to': session.pid,
        'from': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///
  ///_send
  ///
  void _send(event, data) {
    final request = {};
    request["type"] = event;
    request["data"] = data;
    _socket?.send(_encoder.convert(request));
  }

  ///
  ///_cleanSessions
  ///
  Future<void> _cleanSessions() async {
    if (_localStream != null) {
      _localStream!.getTracks().forEach((element) async {
        await element.stop();
      });

      _localStream!.getVideoTracks().forEach((track) async {
        await track.stop();
        // _localStream!.removeTrack(track);
      });

      await _localStream!.dispose();
      _localStream = null;
    }

    _sessions.forEach((key, sess) async {
      if (!IZIValidate.nullOrEmpty(sess.pc)) {
        await sess.pc?.close();
      }
      if (!IZIValidate.nullOrEmpty(sess.dc)) {
        await sess.dc?.close();
      }
    });
    _sessions.clear();
  }

  ///
  ///_closeSessionByPeerId
  ///
  void _closeSessionByPeerId(String peerId) {
    Session? session;
    _sessions.removeWhere((String key, Session sess) {
      final ids = key.split('-');
      session = sess;
      return peerId == ids[0] || peerId == ids[1];
    });

    if (!IZIValidate.nullOrEmpty(session)) {
      _closeSession(session!);
    }
    if (!IZIValidate.nullOrEmpty(session)) {
      onCallStateChange?.call(session!, CallState.CallStateBye);
    }
  }

  ///
  ///_closeSession
  ///
  Future<void> _closeSession(Session session) async {
    if (!IZIValidate.nullOrEmpty(_localStream)) {
      _localStream?.getTracks().forEach((element) async {
        await element.stop();
      });

      if (!IZIValidate.nullOrEmpty(_localStream!.getVideoTracks())) {
        _localStream!.getVideoTracks().forEach((track) async {
          await track.stop();
          // _localStream!.removeTrack(track);
        });
      }

      await _localStream?.dispose();
      _localStream = null;
    }

    if (!IZIValidate.nullOrEmpty(session.pc)) {
      await session.pc?.close();
    }
    if (!IZIValidate.nullOrEmpty(session.dc)) {
      await session.dc?.close();
    }
  }
}

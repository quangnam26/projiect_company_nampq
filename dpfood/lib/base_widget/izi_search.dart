import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:template/utils/color_resources.dart';

import '../helper/izi_dimensions.dart';

class IZISearch extends StatefulWidget {
  final Function(String val) onTap;
  final Function(String val) onChange;
  final String term;
  final Function? onShowDrawer;
  const IZISearch({
    required this.onTap,
    required this.onChange,
    this.onShowDrawer,
    required this.term,
  });
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<IZISearch> {
  FloatingSearchBarController? _controller;
  Box<String>? searchBox;

  final int _historyLength = 5;

  final List<String> _searchHistory = [];

  // ignore: use_late_for_private_fields_and_variables
  List<String>? _filterSearchHistory;

  String? selectedSearch;

  // Nhấn vào ô tìm kiếm
  List<String> _filterSearchTerm({String? filter}) {
    // Nếu người dùng nhâp vào từ khoá
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList(); // Trả về từ khoá trong lịch sử bắt đầu bằng từ khoá nhập vào
    } else {
      return _searchHistory.reversed.toList(); // Nếu chưa nhập thì trả về tất cả lịch sử ở tối đa 5
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // Nếu đã tim kiêm từ khóa này  or có trong lịch sử thì
      putSearchTermFirst(term); // Đẩy từ khóa lên đầu mảng
      return;
    } else {
      // Nếu chưa tìm kiêm lần nào or không có trong lịch sử thì thêm vào lịch sử
      // Thêm Term vào lịch sử
      _searchHistory.add(term);
      searchBox!.put(term, term);
      // Lịch sủ ghi nhơ tối đa là 5 phần tử nếu lơn hơn thì xóa lịch sủ cũ nhất
      if (_searchHistory.length > _historyLength) {
        // Nếu lịch sử đã lơn hơn 5
        searchBox!.deleteAt(0);
        _searchHistory.removeRange(0, _searchHistory.length - _historyLength); // Xoá vị trí đầu tiên (0,0)
      }
    }
    // Bộ lọc bằng null trả về danh sách lịch sử tìm kiếm. Đồng nghĩa từ khóa không có săn trong lịch sử
    _filterSearchHistory = _filterSearchTerm();
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((terms) => terms == term); // Xoá thăng ở vị trí bằng từ khoá
    _filterSearchHistory = _filterSearchTerm(filter: null); // làm mới lại cái lich sử
  }

  void putSearchTermFirst(String term) {
    // Trùng từ khoá trong lịch sử
    deleteSearchTerm(term); // Gọi hàm deleteSearchTerm
    addSearchTerm(term); // Goị hàm thêm từ khoá để từ khoá ấy lên đầu tiên
  }

  @override
  void initState() {
    super.initState();
    initHistory();
    _filterSearchHistory = _filterSearchTerm(filter: null);
    _controller = FloatingSearchBarController(); //useFloatingSearchBarController();
  }

  Future<void> initHistory() async {
    searchBox = await Hive.openBox<String>('history');
    if (searchBox != null) {
      _searchHistory.clear();
      _searchHistory.addAll(searchBox!.values.toList());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Theme(
      data: ThemeData.light().copyWith(),
      child: FloatingSearchBar(
        // padding: EdgeInsets.zero,
        onFocusChanged: (bool) {
          _controller!.query = widget.term;
        },
        title: Text(widget.term),
        margins: EdgeInsets.zero,
        backdropColor: ColorResources.NEUTRALS_7,
        controller: _controller,
        hint: 'Tìm kiếm ',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        clearQueryOnClose: false,
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: MediaQuery.of(context).size.width, //isPortrait ? 600 : 500,
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 100,
        ),
        automaticallyImplyDrawerHamburger: false,
        automaticallyImplyBackButton: false,
        leadingActions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorResources.NEUTRALS_4,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
        debounceDelay: const Duration(milliseconds: 500),
        transition: CircularFloatingSearchBarTransition(),
        onQueryChanged: (query) {
          widget.onChange(query);
          setState(() {
            _filterSearchHistory = _filterSearchTerm(filter: query); // Mỗi lần nhập thì ra về môt lịch sử mới
            selectedSearch = query;
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query); // Thêm từ vào khi nhấn submit
            selectedSearch = query; // Gắn là từ khoá đang dc chọn
          });
          _controller?.close(); // Đóng stream
        },
        actions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(
                Icons.filter_alt,
                color: ColorResources.NEUTRALS_4,
              ),
              onPressed: () {
                if (widget.onShowDrawer != null) {
                  widget.onShowDrawer!();
                }
              },
            ),
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Builder(
                builder: (context) {
                  // Nếu lịch sử rỗng và controller không có data
                  if (_filterSearchHistory!.isEmpty && _controller!.query.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      color: Colors.white,
                      child: const Text("Bắt đầu tìm kiếm..."),
                    );
                    // Nếu lịch sử rỗng
                  } else if (_filterSearchHistory!.isEmpty) {
                    return ListTile(
                      onTap: () {
                        // setState(() {
                        //   addSearchTerm(_controller.query);
                        //   selectedSearch = _controller.query;
                        // });
                        final termValue = _controller!.query;
                        addSearchTerm(termValue);
                        // on tap tìm kiếm từ khoá đang nhập
                        widget.onTap(termValue);
                        _controller?.close();
                      },
                      title: Text(_controller!.query),
                      trailing: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            final termValue = _controller!.query;
                            addSearchTerm(termValue);
                            // on tap nhấn vào icon
                            widget.onTap(termValue);
                            _controller?.close();
                          }),
                    );
                  } else {
                    // Danh sách lịch sử đã tìm kiếm
                    return Column(
                      children: _filterSearchHistory!
                          .map(
                            (term) => ListTile(
                              title: Text(term),
                              leading: const Icon(
                                Icons.access_time_outlined,
                                color: Colors.blue,
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      deleteSearchTerm(term);
                                    });
                                  }),
                              onTap: () {
                                if (_controller!.query.isEmpty) {
                                  addSearchTerm(term);
                                } else {
                                  addSearchTerm(_controller!.query);
                                }
                                selectedSearch = term;
                                // on tap vào lịch sử
                                widget.onTap(term);
                                _controller?.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:izi_izi_checkbox_grouped/src/controller/group_controller.dart';
import 'package:izi_izi_checkbox_grouped/src/widgets/simple_grouped_checkbox.dart';





/// display  groupedCheckbox inside dialog
/// [context] : BuildContext to pop the dialog
/// [dialogTitle] : Text Widget that describe Title of dialog
/// [itemsTitle] :  list of strings that describe each checkbox
/// [values] : list of values
/// [initialSelectedValues] : list of initial values that you want to be selected
/// [isDismissible] : determine whether this route can be dismissed by tapping the modal barrier
/// [cancelDialogText] : label for cancelButton
/// [submitDialogText] : label for submitButton
/// [isMultiSelection] : enable mutli selection groupedCheckbox
Future<dynamic> showDialogGroupedCheckbox({
  required BuildContext context,
  required Text dialogTitle,
  required List<String> itemsTitle,
  required List<dynamic> values,
  List<dynamic> initialSelectedValues = const [],
  bool isDismissible = true,
  String cancelDialogText = "Cancel",
  String submitDialogText = "Select",
  bool isMultiSelection = false,
}) async {
  assert(values.isNotEmpty);
  assert(itemsTitle.isNotEmpty);
  assert(values.length == itemsTitle.length);
  if (initialSelectedValues.isNotEmpty) {
    assert(initialSelectedValues.where((element) => !values.map((e) => e.runtimeType).contains(element.runtimeType)).isEmpty);
  }
  return showDialog(
      context: context,
      builder: (ctx) {
        return _CoreDialogGroupedCheckbox(
          dialogTitle: dialogTitle,
          values: values,
          itemsTitle: itemsTitle,
          initialSelectedValues: initialSelectedValues,
          cancelDialogText: cancelDialogText,
          submitDialogText: submitDialogText,
          isMultiSelection: isMultiSelection,
        );
      },
      barrierDismissible: isDismissible);
}

class _CoreDialogGroupedCheckbox extends StatefulWidget {
  final Text? dialogTitle;
  final List<String>? itemsTitle;
  final List<dynamic>? values;
  final List<dynamic>? initialSelectedValues;
  final String? cancelDialogText;
  final String? submitDialogText;
  final bool isMultiSelection;

  const _CoreDialogGroupedCheckbox({
    this.dialogTitle,
    this.itemsTitle,
    this.values,
    this.initialSelectedValues,
    this.cancelDialogText,
    this.submitDialogText,
    this.isMultiSelection = false,
  });

  @override
  State<StatefulWidget> createState() => _CoreDialogGroupedCheckboxState();
}

class _CoreDialogGroupedCheckboxState extends State<_CoreDialogGroupedCheckbox> {
  late GroupController controller;
  late ValueNotifier<bool> canSubmit;

  @override
  void initState() {
    super.initState();
    canSubmit = ValueNotifier<bool>(false);
    controller = GroupController(
      isMultipleSelection: widget.isMultiSelection,
      initSelectedItem: widget.initialSelectedValues!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            5.0,
          ),
        ),
      ),
      title: widget.dialogTitle,
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SimpleGroupedCheckbox(
              controller: controller,
              values: widget.values!,
              itemsTitle: widget.itemsTitle!,
              onItemSelected: (items) {
                if (widget.isMultiSelection) {
                  if ((items as List).isNotEmpty) {
                    canSubmit.value = true;
                  } else {
                    canSubmit.value = false;
                  }
                } else {
                  if (items == null) {
                    canSubmit.value = false;
                  } else {
                    canSubmit.value = true;
                  }
                }
              },
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(widget.cancelDialogText!),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: canSubmit,
          builder: (ctx, canSubmit, child) {
            return ElevatedButton(
              onPressed: canSubmit
                  ? () {
                      Navigator.pop(context, controller.selectedItem);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: child,
            );
          },
          child: Text(
            widget.submitDialogText!,
          ),
        )
      ],
    );
  }
}

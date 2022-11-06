import 'package:flutter/material.dart';

import '../common/custom_state_group.dart';
import '../common/item.dart';
import '../common/utilities.dart';
import '../controller/custom_group_controller.dart';

/// display  custom groupedCheckbox with your custom check behavior and custom child widget
///
/// [controller] : Text Widget that describe Title of group checkbox
///
/// [groupTitle] : Text Widget that describe Title of group checkbox
///
/// [itemBuilder] :  builder function  takes an index and checked state of widget
///
/// [values] : list of values
///
/// [itemExtent] : same as [itemExtent] of [ListView]
///
class CustomGroupedCheckbox<T> extends StatefulWidget {
  final CustomGroupController controller;
  final Widget? groupTitle;
  final CustomItemIndexedWidgetBuilder itemBuilder;
  final double? itemExtent;
  final List<T> values;
  final bool _isGrid;
  final bool isScroll;
  final SliverGridDelegate? gridDelegate;

  const CustomGroupedCheckbox({
    Key? key,
    required this.controller,
    this.groupTitle,
    required this.itemBuilder,
    required this.values,
    this.isScroll = false,
    this.itemExtent,
  })  : _isGrid = false,
        gridDelegate = null,
        super(key: key);

  const CustomGroupedCheckbox.grid({
    Key? key,
    required this.controller,
    this.groupTitle,
    SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    this.isScroll = false,
    required this.itemBuilder,
    required this.values,
  })  : _isGrid = true,
        gridDelegate = gridDelegate,
        itemExtent = 0.0,
        super(key: key);

  @override
  CustomGroupedCheckboxState createState() => CustomGroupedCheckboxState();

  static CustomGroupController of<T>(
    BuildContext context, {
    bool nullOk = false,
  }) {
    final CustomGroupedCheckboxState<T>? result =
        context.findAncestorStateOfType<CustomGroupedCheckboxState<T>>();
    if (nullOk || result != null) return result!.widget.controller;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          'CustomGroupedCheckbox.of() called with a context that does not contain an CustomGroupedCheckbox.'),
      ErrorDescription(
          'No CustomGroupedCheckbox ancestor could be found starting from the context that was passed to CustomGroupedCheckbox.of().'),
      context.describeElement('The context used was')
    ]);
  }
}

class CustomGroupedCheckboxState<T> extends CustomStateGroup<T?, CustomGroupedCheckbox> {
  SliverChildBuilderDelegate? childrenDelegate;

  @override
  void initState() {
    super.initState();
    itemsSelections = ValueNotifier([]);
    items = [];
    for (final v in widget.values) {
      items.add(
        ValueNotifier(
          CustomItem(
            data: v as T,
            checked: widget.controller.initSelectedItem.contains(v),
          ),
        ),
      );
    }
    widget.controller.init(this);
    if (!widget.controller.isMultipleSelection) {
      if (widget.controller.initSelectedItem.isNotEmpty &&
          widget.controller.initSelectedItem.first != null) {
        itemSelected.value = widget.controller.initSelectedItem.first as T;
      }
    } else {
      if (widget.controller.initSelectedItem.isNotEmpty) {
        itemsSelections.value = List.castFrom(widget.controller.initSelectedItem);
      }
    }
  }

  @override
  void didUpdateWidget(covariant CustomGroupedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      itemsSelections = ValueNotifier([]);
      items = [];
      for (final v in widget.values) {
        items.add(
          ValueNotifier(
            CustomItem(
              data: v as T,
              checked: widget.controller.initSelectedItem.contains(v),
            ),
          ),
        );
      }
      widget.controller.init(this);

      if (!widget.controller.isMultipleSelection) {
        itemSelected.value = widget.controller.initSelectedItem.first as T;
      } else {
        itemsSelections.value = List.castFrom(widget.controller.initSelectedItem);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ValueListenableBuilder<CustomItem<T?>> builder(ctx,int index) {
      return ValueListenableBuilder<CustomItem<T?>>(
        valueListenable: items[index],
        builder: (ctx, value, child) {
          return ItemWidget(
            value: items[index].value.checked,
            callback: (v) {
              if (!items[index].value.isDisabled) changeSelection(index, v);
            },
            child: widget.itemBuilder(
              context,
              index,
              items[index].value.checked!,
              items[index].value.isDisabled,
            ),
          );
        },
      );
    }
    Widget child = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: builder,
      itemCount: items.length,
      itemExtent: widget.itemExtent,
    );
    const Axis axisScroll = Axis.vertical;
    if (widget._isGrid) {
      child = GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: widget.gridDelegate!,
        itemBuilder: builder,
        itemCount: items.length,
        shrinkWrap: true,
      );
      //axisScroll = Axis.horizontal;
    }
    final customWidget = ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: child,
    );
    return widget.groupTitle != null
        ? SingleChildScrollView(
            physics:
                widget.isScroll ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                widget.groupTitle!,
                customWidget,
              ],
            ),
          )
        : customWidget;
  }

  @override
  void changeSelection(int index, bool value) {
    if (widget.controller.isMultipleSelection) {
      if (!itemsSelections.value.contains(widget.values[index])) {
        if (value) {
          itemsSelections.value = List.from(itemsSelections.value)..add(widget.values[index] as T);
        }
      } else {
        if (!value) {
          itemsSelections.value = List.from(itemsSelections.value)..remove(widget.values[index]);
        }
      }
      items[index].value = items[index].value.copy(checked: value);
      if (streamListValues.hasListener) streamListValues.add(itemsSelections.value);
    } else {
      if (value) {
        if (itemSelected.value != null) {
          if (itemSelected.value != items[index].value.data) {
            final int indexPrevious = widget.values.indexOf(itemSelected.value);
            items[indexPrevious].value = items[indexPrevious].value.copy(checked: false);
          }
        }
        itemSelected.value = widget.values[index] as T;
        items[index].value = items[index].value.copy(checked: value);
      }
      if (streamOneValue.hasListener) streamOneValue.add(itemSelected.value);
    }
  }

  @override
  dynamic selection() {
    if (widget.controller.isMultipleSelection) {
      return itemsSelections.value;
    }
    return itemSelected.value;
  }

  @override
  void reset() {
    for (final element in items) {
      final item = element;
      item.value = element.value.copy(checked: false);
    }
    if (widget.controller.isMultipleSelection) {
      itemsSelections.value.clear();

      if (streamOneValue.hasListener) streamListValues.add(itemsSelections.value);
    } else {
      itemSelected.value = null;
      if (streamOneValue.hasListener) streamOneValue.add(itemSelected.value);
    }
  }
}

@visibleForTesting
class ItemWidget extends StatelessWidget {
  final Widget? child;
  final Function(bool)? callback;
  final bool? value;

  const ItemWidget({
    this.child,
    this.callback,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback!(!value!),
      child: AbsorbPointer(
        child: child,
      ),
    );
  }
}

import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izi_izi_checkbox_grouped/src/controller/list_group_controller.dart';
import 'package:izi_izi_checkbox_grouped/src/widgets/list_grouped_checkbox.dart';

void main() async {
  testWidgets(" test list grouped ", (tester) async {
    final ListGroupController controller = ListGroupController(
      isMultipleSelectionPerGroup: [true, false, true],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListGroupedCheckbox(
            controller: controller,
            groupTitles: List.generate(3, (index) => "groupe $index"),
            values: List.generate(
              3,
              (i) => List.generate(5, (j) => "${(i + Random().nextInt(100)) * j}"),
            ),
            titles: List.generate(
              3,
              (i) => List.generate(5, (j) => "Title:$i-$j"),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 30));

    await tester.tap(find.byType(CheckboxListTile).at(1));

    await tester.pump(const Duration(seconds: 10));
    await tester.tap(find.text("Title:1-0"));
    await tester.pump(const Duration(seconds: 10));

    final list = await controller.allSelectedItems;

    expect(list.length, 2);
  });
  testWidgets("test disableAll and enableAll list grouped ", (tester) async {
    final ListGroupController controller = ListGroupController(
      isMultipleSelectionPerGroup: [true, false, true],
    );
    final values = List.generate(
      3,
      (i) => List.generate(5, (j) => "${(i + Random().nextInt(100)) * j}"),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListGroupedCheckbox(
            controller: controller,
            groupTitles: List.generate(3, (index) => "groupe $index"),
            values: values,
            titles: List.generate(
              3,
              (i) => List.generate(5, (j) => "Title:$i-$j"),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    controller.disableAll(0);
    await tester.pump();
    await tester.tap(find.byType(CheckboxListTile).at(1));
    final list = await controller.allSelectedItems;
    expect(list, []);
  });

  testWidgets("test enableByValues and disableByValues list grouped ", (tester) async {
    final ListGroupController controller = ListGroupController(
      isMultipleSelectionPerGroup: [true, false, true],
    );
    final values = List.generate(
      3,
      (i) => List.generate(5, (j) => "${(i + Random().nextInt(100)) * j}"),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListGroupedCheckbox(
            controller: controller,
            groupTitles: List.generate(3, (index) => "groupe $index"),
            values: values,
            titles: List.generate(
              3,
              (i) => List.generate(5, (j) => "Title:$i-$j"),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    controller.disabledItemsByValues(0, [values[0][1]]);
    await tester.pump();
    await tester.tap(find.byType(CheckboxListTile).at(1));
    var list = await controller.allSelectedItems;
    expect(list, []);
    controller.enabledItemsByValues(0, [values[0][1]]);
    await tester.pump();
    await tester.tap(find.byType(CheckboxListTile).at(1));
    list = await controller.allSelectedItems;
    expect(list, [values[0][1]]);
  });
}

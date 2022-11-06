
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izi_izi_checkbox_grouped/checkbox_grouped.dart';

void main() {
  testWidgets("test simple SimpleGroupedChip", (tester) async {
    final GroupController controller = GroupController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SimpleGroupedChips<int>(
          controller: controller,
          itemTitle: const ["1", "2", "4", "5"],
          values: const [1, 2, 4, 5],
          disabledItems: const ["2"],
          selectedColorItem: Colors.red,
          backgroundColorItem: Colors.white,
          disabledColor: Colors.grey[200],
        ),
      ),
    ));
//    await tester.tap(find.byType(ChoiceChip).first);
//    await tester.pump();
    final ChoiceChip cb = tester.widget(find.byType(ChoiceChip).at(2)) as ChoiceChip;
    // ChoiceChip cb2=tester.widget(find.byType(ChoiceChip).at(2)) as ChoiceChip;
    await tester.tap(find.byWidget(cb));
    final int? value = controller.selectedItem as int?;
    expect(value, 4);
  });

  testWidgets("test multiple selection SimpleGroupedChip", (tester) async {
    final GroupController controller = GroupController(initSelectedItem: [2, 4], isMultipleSelection: true);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SimpleGroupedChips<int>(
          controller: controller,
          itemTitle: const ["1", "2", "4", "5"],
          values: const [1, 2, 4, 5],
          selectedColorItem: Colors.red,
          backgroundColorItem: Colors.white,
          disabledColor: Colors.grey[200],
        ),
      ),
    ));
    await tester.pump();

    var values = controller.selectedItem;
    expect(values, [2, 4]);
    final ChoiceChip cb = tester.widget(find.byType(ChoiceChip).at(2)) as ChoiceChip;
    await tester.tap(find.byWidget(cb));
    await tester.pump(const Duration(seconds: 1));
    values = controller.selectedItem;
    expect(values, [2]);
  });
}

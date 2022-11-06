
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izi_izi_checkbox_grouped/src/controller/list_custom_group_controller.dart';
import 'package:izi_izi_checkbox_grouped/src/widgets/custom_grouped_checkbox.dart';
import 'package:izi_izi_checkbox_grouped/src/widgets/list_custom_grouped_checkbox.dart';

void main() async {
  testWidgets(" test list custom grouped ", (tester) async {
    final controller = ListCustomGroupController(isMultipleSelectionPerGroup: [true, false]);
    final datas = [
      List<int>.generate(
        3,
        (i) => i + 1,
      ),
      List<String>.generate(
        3,
        (i) => "name-${i + 1}",
      )
    ];
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListCustomGroupedCheckbox(
              controller: controller,
              groupTitles: const ["Users", "Names"],
              children: [
                CustomIndexedWidgetBuilder(
                  itemBuilder: (ctx, index, selected, isDisabled) {
                    return Card(
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: ListTile(
                        tileColor: selected ? Colors.green[300] : Colors.white,
                        title: Text(
                          "${datas[0][index]}",
                        ),
                        trailing: Opacity(
                          opacity: selected ? 1 : 0,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CustomGridIndexedWidgetBuilder(
                    itemBuilder: (ctx, index, selected, isDisabled) {
                      return Card(
                        color: selected ? Colors.green[300] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                datas[1][index] as String,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 8,
                              child: Opacity(
                                opacity: selected ? 1 : 0,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5.0)),
              ],
              listValuesByGroup: datas,
            ),
          ),
        ),
        const Duration(seconds: 30));

    await tester.pump();

    await tester.tap(find.byType(ItemWidget).first);

    await tester.pump(const Duration(seconds: 10));
    await tester.tap(find.byType(ItemWidget).at(3));
    await tester.pump(const Duration(seconds: 10));

    var result = await controller.allSelectedItemsGrouped;
    var actualResult = [
      [1],
      "name-1"
    ];
    expect(result.length, 2);
    expect(result, actualResult);
    await tester.tap(find.byType(ItemWidget).first);
    await tester.pump(const Duration(seconds: 10));
    result = await controller.allSelectedItemsGrouped;
    actualResult = [[], "name-1"];
    expect(result, actualResult);
  });
}

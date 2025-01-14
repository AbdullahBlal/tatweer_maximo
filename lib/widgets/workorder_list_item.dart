import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/workorder.dart';
import 'package:tatweer_approval/reusable%20functions/full_text_content.dart';

class WorkorderListItem extends StatelessWidget {
  const WorkorderListItem(this.workorder, {super.key});

  final Workorder workorder;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
             Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WO # ${workorder.wonum}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    SizedBox(width: 150, child: Text(workorder.description)),
                  ],
                ),
                OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    elevation: 5,
                    shadowColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: InkWell(
                    onTap: () {
                      showFullText(workorder.statusDescription, context);
                    },
                    child: Text(
                      workorder.status,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Work Type',
                        style:
                            TextStyle(color: Theme.of(context).colorScheme.outlineVariant)),
                    Text(workorder.worktype)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Report Date:',
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.outlineVariant)),
                    Text(workorder.toStringReportDate)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

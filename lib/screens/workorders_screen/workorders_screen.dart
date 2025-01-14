import 'package:animated_refresh/animated_refresh.dart';
import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/workorder.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorder_details_screen/workorder_details_screen.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';

class WorkordersScreen extends StatelessWidget {
  const WorkordersScreen({
    super.key,
    required this.workorders,
    required this.loading,
    required this.refreshWorkorders,
    required this.loadWorkorders,
    required this.apiKey,
  });

  final bool loading;
  final List<Workorder> workorders;
  final Function refreshWorkorders;
  final Function loadWorkorders;
  final String apiKey;

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedRefresh(
      backgroundColor: Colors.transparent,
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () {
        return refreshWorkorders();
      },
      swipeChild: Icon(
        Icons.refresh,
        color: Theme.of(context).colorScheme.secondary,
      ),
      refreshChild: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CustomProgreessIndicator(),
        ),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        itemCount: workorders.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => WorkorderDetailsScreen(
                              workorder: workorders[index])))
                  .then((onValue) => {loadWorkorders()});
            },
            child: ListTile(
                title: Row(
                  children: [
                    Text('${workorders[index].wonum} - '),
                    Text(workorders[index].worktype,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary, fontSize: 12)),
                  ],
                ),
                subtitle: Text(workorders[index].description),
                trailing: Text(
                  workorders[index].toStringReportDate,
                  style: const TextStyle(fontSize: 12),
                )),
          );
        },
      ),
    );

    if (loading) {
      content = const Center(child: CustomProgreessIndicator());
    }

    if (workorders.isEmpty && !loading) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No workorders Found'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try searching a different workorder',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
      );
    }
    return content;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/models/workorder.dart';
import 'package:tatweer_approval/providers/user_provider.dart';
import 'package:tatweer_approval/providers/workorders_provider.dart';
import 'package:tatweer_approval/widgets/custom_text_area_field.dart';

class WOMainDetailsCard extends ConsumerStatefulWidget {
  const WOMainDetailsCard({required this.workorder, super.key});

  final Workorder workorder;

  @override
  ConsumerState<WOMainDetailsCard> createState() => _WOMainDetailsCardState();
}

class _WOMainDetailsCardState extends ConsumerState<WOMainDetailsCard> {
  bool _pendingApproval = false;
  final _rejectionformKey = GlobalKey<FormState>();
  final _rejectionReasonController = TextEditingController();
  String apiKey = "";
  String currentSC = "";

  @override
  void initState() {
    setState(() {
      apiKey = ref.read(userProvider.notifier).getApiKey();
      currentSC = ref.read(userProvider.notifier).getCurrentSC();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showConfirmationMessage(String message) {
      showDialog(
        barrierDismissible: false, // user must tap button!
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Center(
            child: Icon(
              size: 50,
              Icons.message_rounded,
              color: Colors.grey,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(message)
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                  foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
              child: const Text('Ok'),
            ),
          ],
        ),
      ).then((onValue) => {Navigator.pop(context)});
    }

    void approveWO() async {
      setState(() {
        _pendingApproval = true;
      });
      final response = await ref
          .read(workordersProvider.notifier)
          .approveWorkorder(apiKey, widget.workorder.wonum, currentSC);
      if (response["Error"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(response["Error"]["message"]),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
        setState(() {
          _pendingApproval = false;
        });
      } else {
        await ref
            .read(workordersProvider.notifier)
            .getWorkorders(apiKey, currentSC);
        showConfirmationMessage(
            'WO: ${widget.workorder.wonum} has been approved.');
        setState(() {
          _pendingApproval = false;
        });
      }
    }

    Future<bool> rejectWO() async {
      final response = await ref
          .read(workordersProvider.notifier)
          .rejectWorkorder(
              apiKey, widget.workorder.wonum, _rejectionReasonController.text);
      if (response["Error"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 10),
            content: Text(response["Error"]["message"]),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
        return false;
      } else {
        await ref
            .read(workordersProvider.notifier)
            .getWorkorders(apiKey, currentSC);
        showConfirmationMessage(
            'WO: ${widget.workorder.wonum} has been rejected.');
        return true;
      }
    }

    void showRejectionDialog() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            var pendingRejection = false;
            return StatefulBuilder(builder: (stfContext, stfSetState) {
              return AlertDialog(
                title: const SizedBox.shrink(),
                content: Form(
                    key: _rejectionformKey,
                    child: CustomTextAreaField(
                        label: "Rejection Reason",
                        secured: false,
                        controller: _rejectionReasonController,
                        theme: 'light',
                        maxLines: 4,
                        required: true,
                        disabled: false)),
                actions: <Widget>[
                  TextButton(
                    onPressed: pendingRejection?null:() {
                      Navigator.of(ctx).pop("Cancel");
                    },
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.grey),
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  pendingRejection
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            if (_rejectionformKey.currentState!.validate()) {
                              stfSetState(() {
                                pendingRejection = true;
                              });
                              final bool rejected = await rejectWO();
                              if (!rejected) {
                                Navigator.of(ctx).pop("Cancel");
                              }
                              stfSetState(() {
                                pendingRejection = false;
                              });
                            }
                          },
                          child: const Text('Reject'),
                        ),
                ],
              );
            });
          }).then((onValue) {
        if (onValue != "Cancel") {
          Navigator.pop(context);
        }
      });
    }

    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(249, 249, 249, 1),
              Color.fromRGBO(249, 249, 249, 1),
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
                    Row(
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                              color: Color.fromRGBO(181, 183, 186, 1)),
                        ),
                        const SizedBox(width: 10,),
                        widget.workorder.locationIsUint
                            ? Text(
                                'Unit',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    SizedBox(
                        width: 150, child: Text(widget.workorder.location)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Work Type',
                      style: TextStyle(color: Color.fromRGBO(181, 183, 186, 1)),
                    ),
                    SizedBox(
                        width: 120, child: Text(widget.workorder.worktype)),
                  ],
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
                    const Text('EST Material Cost',
                        style:
                            TextStyle(color: Color.fromRGBO(181, 183, 186, 1))),
                    Text(widget.workorder.toStringEstimatedMaterialCost)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('EST Total Price:',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(181, 183, 186, 1))),
                    Text(widget.workorder.toStringEstimatedTotalPrice)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _pendingApproval
                    ? Expanded(
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(20, 181, 0, 1)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                            ),
                            child: const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(20, 181, 0, 1),
                                ))),
                      )
                    : Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            approveWO();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(20, 181, 0, 1)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                          ),
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromRGBO(20, 181, 0, 1),
                          ),
                          label: const Text(
                            'APPROVE',
                            style:
                                TextStyle(color: Color.fromRGBO(20, 181, 0, 1)),
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pendingApproval?null:() {
                      showRejectionDialog();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.0, color: Colors.red),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'REJECT',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

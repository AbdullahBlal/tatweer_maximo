import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_maximo/models/purchase_request.dart';
import 'package:tatweer_maximo/providers/purchase_request_provider.dart';
import 'package:tatweer_maximo/providers/user_provider.dart';
import 'package:tatweer_maximo/reusable%20functions/datetime_format.dart';
import 'package:tatweer_maximo/widgets/custom_text_area_field.dart';

class PRMainDetailsCard extends ConsumerStatefulWidget {
  const PRMainDetailsCard({required this.purchaseRequest, super.key});

  final PurchaseRequest purchaseRequest;

  @override
  ConsumerState<PRMainDetailsCard> createState() => _PRMainDetailsCardState();
}

class _PRMainDetailsCardState extends ConsumerState<PRMainDetailsCard> {
  var _pendingApproval = false;
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
  void dispose() {
    _rejectionReasonController.dispose();
    super.dispose();
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

    void approvePR() async {
      setState(() {
        _pendingApproval = true;
      });

      final response = await ref
          .read(purchaseRequestsProvider.notifier)
          .approvePurchaseRequest(
              apiKey, widget.purchaseRequest.prnum, currentSC);
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
            .read(purchaseRequestsProvider.notifier)
            .getPurchaseRequests(apiKey, currentSC);
        showConfirmationMessage(
            'PR: ${widget.purchaseRequest.prnum} has been approved.');
        setState(() {
          _pendingApproval = false;
        });
      }
    }

    Future<bool> rejectPR() async {
      final response = await ref
          .read(purchaseRequestsProvider.notifier)
          .rejectPurchaseRequest(apiKey, widget.purchaseRequest.prnum,
              _rejectionReasonController.text);
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
            .read(purchaseRequestsProvider.notifier)
            .getPurchaseRequests(apiKey, currentSC);
        showConfirmationMessage(
            'PR: ${widget.purchaseRequest.prnum} has been rejected.');
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
                              final bool rejected = await rejectPR();
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
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              spreadRadius: 0.1,
              blurRadius: 1,
              offset: const Offset(0, 0.1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status Date:',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(displayDateTimeFormatter
                        .format(widget.purchaseRequest.statusDate)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Request Date:',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(displayDateTimeFormatter
                        .format(widget.purchaseRequest.issueDate)),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Details:',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(widget.purchaseRequest.description)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.purchaseRequest.currencyCode, style: const TextStyle(fontSize: 15)),
                    Text(
                      widget.purchaseRequest.toStringTotalCost,
                      style: const TextStyle(fontSize: 25),
                    )
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
                            approvePR();
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

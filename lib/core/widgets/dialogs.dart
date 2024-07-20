import 'package:flutter/material.dart';
import 'package:flutter_practical_test/core/constants/constants.dart';

import 'texts/common_texts.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => false,
      child: const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const LoadingDialog(),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}

showDialogMsg(BuildContext context, String body, String title,
    {GlobalKey? key}) {
  showDialog(
    builder: (context) => AlertDialog(
      // key: _alertKey,
      insetPadding: const EdgeInsets.symmetric(horizontal: Constants.small),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Texts.subheading(title),
          const SizedBox(height: 10),
          Flexible(
            child: Texts.bodyText(body),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.large, vertical: Constants.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: Constants.large),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        width: 2, // the thickness
                        color: Colors.blue // the color of the border
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Constants.large),
                    child: Texts.subheading("OK"),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ),
    barrierDismissible: false,
    context: context,
  );
}

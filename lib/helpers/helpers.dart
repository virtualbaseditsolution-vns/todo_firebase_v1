import '../library.dart';

Future loading(String? label) async {
  return Get.dialog(AlertDialog(
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (label != null) ...[
          hSpace,
          Text(
            label,
            style: heading,
          )
        ]
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  ));
}

Future appConfirm(
    {required BuildContext? context, String? title, String? subTitle}) {
  return showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,

        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(title,
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.w600)),
            vSpace,
            if (subTitle != null)
              Text(subTitle, style: const TextStyle(fontSize: 13.0)),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text("No"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          SizedBox(
              width: 1.0, child: Container(height: 30.0, color: Colors.grey)),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.green,
            ),
            child: const Text("Yes"),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      );
    },
  );
}

Future bottomSheet(Widget child, {Color? backgroundColor, double? radius}) {
  return Get.bottomSheet(
    ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 3.5,
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        child
      ],
    ),
    isScrollControlled: true,
    enableDrag: true,
    backgroundColor: backgroundColor ?? Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(radius ?? 20))),
  );
}

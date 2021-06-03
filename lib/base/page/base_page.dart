import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {}

abstract class BasePageS<Page extends BasePage> extends State<Page>
    with WidgetsBindingObserver {
  Function dispatchCloseAction;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (dispatchCloseAction != null) dispatchCloseAction();
    super.dispose();
  }

  /// Function to navigate to error screen. You can pass [dto] predefined in [ErrorPageDto],
  /// or make your own.
  /// If [dto.listenPrimaryButton] is true, [showError] returns true as soon as user hits the button
  /// on error screen, if it's false, [showError] returns false immediately.
  // Future<ErrorResultDto> showError(
  //     BuildContext context, ErrorPageDto dto) async {
  //   if (dto.listenPrimaryButton || dto.listenBack) {
  //     final result =
  //         await Navigator.of(context).pushNamed(ERROR, arguments: dto);
  //     return result;
  //   } else {
  //     Navigator.of(context).pushNamed(ERROR, arguments: dto);
  //     return null;
  //   }
  // }

  /// Function to navigate to error screen, and perform some action when user hits the button
  /// on error screen. Action is performed, if [dto.listenPrimaryButton] is true, otherwise
  /// action is ignored.
  // showErrorWithAction(BuildContext context, ErrorPageDto dto,
  //     {Function() action}) async {
  //   if ((dto.listenPrimaryButton || dto.listenBack) && action != null) {
  //     var result = await showError(context, dto);
  //     if (result != null) {
  //       action();
  //     }
  //   } else {
  //     showError(context, dto);
  //   }
  // }

  // void showAlert(BuildContext context,
  //     {String title,
  //     String message,
  //     String yesButtonText,
  //     String noButtonText,
  //     Function yesAction,
  //     Function noAction,
  //     String imageAsset}) {
  //   List<Widget> buttons = List();
  //   if (noButtonText != null && noButtonText.isNotEmpty) {
  //     buttons.add(FlatButton(
  //       child: new Text(
  //         noButtonText,
  //         style: AppTextStyleDialogButton(),
  //       ),
  //       onPressed: () {
  //         noAction();
  //       },
  //     ));
  //   }
  //   if (yesButtonText != null && yesButtonText.isNotEmpty) {
  //     buttons.add(FlatButton(
  //       child: new Text(
  //         yesButtonText,
  //         style: AppTextStyleDialogButton(),
  //       ),
  //       onPressed: () {
  //         yesAction();
  //       },
  //     ));
  //   }
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //             title: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   imageAsset != null
  //                       ? Padding(
  //                           padding: EdgeInsets.only(bottom: 16),
  //                           child: SvgPicture.asset(imageAsset))
  //                       : Container(),
  //                   Text(
  //                     title,
  //                     style: AppTextStyleMedium(height: 1.2),
  //                   ),
  //                 ]),
  //             content: Text(
  //               message,
  //               style: AppTextStyleBodySmall(color: COL_GREY),
  //             ),
  //             actions: buttons,
  //           ));
  // }
}

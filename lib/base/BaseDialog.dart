import 'package:flutter/material.dart';
import 'package:flutter_search/manager/DialogManager.dart';

abstract class BaseDialog extends StatelessWidget {
  final _dialogKey = GlobalKey();

  BaseDialog({super.key});

  // 각 Page에서 호출
  Widget setBuild();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      key: _dialogKey,
      canPop: false,
      onPopInvoked: (didPop)  {
        if(didPop){
          DialogManager.instance.dismiss();
        }
      },
      child: Container(
        child: setBuild(),
      ),
    );
  }
}

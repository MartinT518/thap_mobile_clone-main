import 'package:flutter/material.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';

class TingsLoader {
  late BuildContext context;

  TingsLoader(this.context);

  void show() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Don't allow closing by back gesture
          child: SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: [
              Center(
                child: Transform.scale(
                  scale: 1.5,
                  child: const RefreshProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void hide() {
    locator<NavigationService>().pop();
  }
}

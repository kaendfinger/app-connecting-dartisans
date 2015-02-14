library connecting_dartisans.main;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';

import 'application.dart';
import 'pages/home.dart';

void main() {
  initPolymer().run(() {
    Polymer.onReady.then((_) {
      ConnectingDartisansApplication application = querySelector("#application") as ConnectingDartisansApplication;
      ApplicationEventBus applicationEventBus = new ApplicationEventBus();
      PageKeyUrlConverter pageKeyUrlConverter = new PageKeyUrlConverter();
      Router router = new Router(pageKeyUrlConverter);

      router.setApplicationEventBus(applicationEventBus);
      application.setApplicationEventBus(applicationEventBus);

      router.init();
    });
  });
}

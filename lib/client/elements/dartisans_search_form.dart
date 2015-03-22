// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_search_form;

import "dart:html";
import "dart:async";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:gex_webapp_kit_client/elements/ternary_options.dart';

@CustomTag('dartisans-search-form')
class DartisansSearchFormElement extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisansSearchForm');

  DartisansSearchFormElement.created() : super.created() {}

  DartisansSearchForm _lastSearchFormFired = new DartisansSearchForm();
  void _updateDartisansSearchForm() {
    if (_lastSearchFormFired != dartisansSearchForm) {
      _lastSearchFormFired = dartisansSearchForm.clone();
      fireApplicationEvent(new DartisansApplicationEvent.callSearch(this, _lastSearchFormFired));
    }
    new Timer(new Duration(seconds: 1), _updateDartisansSearchForm);
  }

  @override
  void ready() {
    optionsReadyForTraining.init(new TernaryOptionsModel("Ready for training"));
    optionsReadyToBeHired.init(new TernaryOptionsModel("Ready to be hired"));
    optionsReadyForTalks.init(new TernaryOptionsModel("Ready for talks"));
    _updateDartisansSearchForm();
  }

  DartisansSearchForm get dartisansSearchForm {
    DartisansSearchForm form = new DartisansSearchForm();
    form.fullTextSearch = fullTextSearch.value;
    form.readyForTraining = optionsReadyForTraining.optionAsBool;
    form.readyForTalks = optionsReadyForTalks.optionAsBool;
    form.readyToBeHired = optionsReadyToBeHired.optionAsBool;

    return form;
  }
  set dartisansSearchForm(DartisansSearchForm form) {
    fullTextSearch.value = form.fullTextSearch;
    optionsReadyForTraining.optionAsBool = form.readyForTraining;
    optionsReadyForTalks.optionAsBool = form.readyForTalks;
    optionsReadyToBeHired.optionAsBool = form.readyToBeHired;
  }

  TernaryOptions get optionsReadyForTraining => $["optionsReadyForTraining"];
  TernaryOptions get optionsReadyForTalks => $["optionsReadyForTalks"];
  TernaryOptions get optionsReadyToBeHired => $["optionsReadyToBeHired"];
  InputElement get fullTextSearch => $["fullTextSearch"];
}

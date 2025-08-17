// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/errors/validation_error.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:provider/provider.dart';

class FormViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _formData = {};

  List<ValidationError> _formErrors = [];

  bool _isSubmitting = false;

  FormViewModel({
    Map<String, dynamic>? initialValues,

    /// must return the validation errors to set the formErrors in the catch block of submit callback.
    Future<List<ValidationError>> Function(Object)? onError,
  }) {
    if (initialValues != null) {
      // json encode decode cloning can throw errors for DateTime kind of values. so create temp Map
      Map<String, dynamic> tempData = {};
      tempData.addAll(initialValues);
      _formData = tempData;
      notifyListeners();
    }
  }

  bool get isSubmitting => _isSubmitting;
  Map<String, dynamic> get formData => _formData;
  List<ValidationError> get formErrors => _formErrors;

  set formErrors(List<ValidationError> value) {
    _formErrors = value;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // list all the properties of your class here.
    // See the documentation of debugFillProperties for more information.
    properties.add(StringProperty('formData', formData.toString()));
    properties.add(StringProperty('formErrors', formErrors.toString()));
  }

  void setFormData(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  void clearFormData() {
    _formData.clear();
    notifyListeners();
  }

  void clearFormErrors() {
    _formErrors.clear();
    notifyListeners();
  }

  void validateForm() {
    _formErrors.clear();
    notifyListeners();
  }

  void setIsSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }
}

FormViewModel $formViewModel(BuildContext context, {bool listen = true}) =>
    Provider.of<FormViewModel>(context, listen: listen);

FormViewModel getFormViewModel(BuildContext context, {bool listen = false}) =>
    Provider.of<FormViewModel>(context, listen: false);

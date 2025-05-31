// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _formData = {};
  Map<String, String> _formErrors = {};
  Map<String, dynamic> get formData => _formData;
  Map<String, String> get formErrors => _formErrors;
  Future<void> Function(Map<String, dynamic>) _onSubmit;
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  FormViewModel({
    Map<String, dynamic>? initialValues,
    required Future<void> Function(Map<String, dynamic>) onSubmit,
  }) : _onSubmit = onSubmit {
    if (initialValues != null) {
      // json encode decode cloning can throw errors for DateTime kind of values. so create temp Map
      Map<String, dynamic> tempData = {};
      tempData.addAll(initialValues);
      _formData = tempData;
      notifyListeners();
    }
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
    print('notified');
  }

  void clearFormData() {
    _formData.clear();
    notifyListeners();
  }

  void setFormError(String key, String error) {
    _formErrors[key] = error;
    notifyListeners();
  }

  void clearFormErrors() {
    _formErrors.clear();
    notifyListeners();
  }

  void validateForm() {
    _formErrors.clear();
    print('set validation logic here');
    notifyListeners();
  }

  void setIsSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  Future<void> submitForm() async {
    _isSubmitting = true;
    notifyListeners();
    try {
      await _onSubmit(formData);
    } catch (error) {
      print('error: $error');
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}

FormViewModel $formViewModel(BuildContext context) =>
    Provider.of<FormViewModel>(context, listen: true);

FormViewModel getFormViewModel(BuildContext context) =>
    Provider.of<FormViewModel>(context, listen: false);

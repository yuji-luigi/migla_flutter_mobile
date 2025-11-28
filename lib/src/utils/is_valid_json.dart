import 'dart:convert';

bool isValidJson(String json) {
  try {
    jsonDecode(json);
    return true;
  } catch (e) {
    return false;
  }
}

String? validateField(String? value) {

  if (value == null || value.isEmpty) {
    return 'Enter a value';
  }
  return null;
}
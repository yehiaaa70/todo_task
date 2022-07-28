import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Picker {
  static showTimePicker(context, TextEditingController controller) {
    DatePicker.showTime12hPicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        controller.text = date
            .toString()
            .split(" ")[1]
            .trim()
            .split(".")
            .first
            .substring(0, 5);
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  static showDatePicker(context, TextEditingController controller) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        controller.text = date.toString().split(" ")[0].trim();
      },
      currentTime: DateTime.now(),
      minTime: DateTime(2022),
      locale: LocaleType.en,
    );
  }
}

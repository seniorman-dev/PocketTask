import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pockettask/view/utils/components/converters.dart';





Future<void> selectDate({
  required BuildContext context,
  required RxString selectedDate,
  }) async {
  //final ThemeData theme = Theme.of(context);
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1970, 1),
    lastDate: DateTime(2101),
    builder: (BuildContext? context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );
  if (picked != null) {
    String formattedDate = formatDate(picked);
    log(formattedDate);
    selectedDate.value = formattedDate;
  }
  return;
}
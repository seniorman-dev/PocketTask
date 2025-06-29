// Example function to extract the first name from the full name.
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';






String getFirstName({required String fullName}) {
  List<String> nameParts = fullName.split(' '); // Split by space
  String firstName = nameParts[0]; // Get the first part
  return firstName.trim(); // Remove leading and trailing spaces (if any)
}

// Example function to extract the last name from the full name.
String getLastName({required String fullName}) {
  List<String> nameParts = fullName.split(' '); // Split by space
  String firstName = nameParts[1]; // Get the first part
  return firstName.trim(); // Remove leading and trailing spaces (if any)
}


// 
String getJustNumber({required String phoneNumber}) {
  String num = phoneNumber.substring(0, 2);  //.split(''); // Split by space
  return num; // Remove leading and trailing spaces (if any)
}

//get the first letter of a user name
String getFirstLetter(String displayName) {
  // Split the display name into parts based on spaces
  List<String> nameParts = displayName.split(' ');

  // Check if there is at least one part (a first name)
  if (nameParts.isNotEmpty) {
    // Get the first part (first name)
    String firstName = nameParts.first;

    // Check if the first name is not empty
    if (firstName.isNotEmpty) {
      // Extract the first letter
      String firstLetter = firstName[0];

      // Return the first letter
      return firstLetter;
    }
  }
  // Return an empty string if no valid first letter is found
  return '';
}


String getUserUrlSlug(String textController) {
  // Extract the substring "jjj"
  String result = textController.substring(textController.lastIndexOf("/") + 1);

  print('Original string: $textController');
  print('Substring: $result');
  return result;
}


//FOR OTPCODE GENERATION
String generateRandom4DigitCode() {
  Random random = Random();
  String code = '';
  
  // Generate 4 random digits
  for (int i = 0; i < 4; i++) {
    code += random.nextInt(10).toString();
  }
  
  return code;
}



String generateRandomString() {
  final Random random = Random();

  // List of uppercase and lowercase letters
  List<String> uppercaseLetters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> lowercaseLetters = List.generate(26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));

  // Combine both lists into one
  List<String> allLetters = [...uppercaseLetters, ...lowercaseLetters];

  // Generate a random 9-character string
  String randomString = List.generate(9, (_) => allLetters[random.nextInt(allLetters.length)]).join('');
  debugPrint(randomString);
  return randomString;
}



String generateTrxRef({int length = 7}) {
  final random = Random.secure();
  final values = List<int>.generate(length, (i) => random.nextInt(36));
  return base64Url.encode(values).substring(0, length).toUpperCase();
}


String generateRandomIdWithNumbers({int minNumbers = 3}) {
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  final random = Random();
  final result = List.generate(15, (index) => letters[random.nextInt(letters.length)]);

  // Replace random positions with numbers
  for (var i = 0; i < minNumbers; i++) {
    result[random.nextInt(result.length)] = numbers[random.nextInt(numbers.length)];
  }

  return result.join();
}


Future<void> copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
}

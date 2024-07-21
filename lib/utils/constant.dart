// Function to navigate to a new page and push it onto the navigation stack
import 'dart:io';

import 'package:flutter/material.dart';

void navigateToNextPage(BuildContext context, Widget nextPage) {
  // Use Navigator.push to add the nextPage to the navigation stack
  // This allows users to navigate back to the previous page using the back button
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
}


Future<bool> showExitPop(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure you want to exit?',style: TextStyle(fontSize: 16),),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // User cancels
          child: const Text('No',style: TextStyle(fontSize: 12),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            exit(0);
          }, // User confirms
          child: const Text('Yes',style: TextStyle(fontSize: 12),),
        ),
      ],
    ),
  );
}
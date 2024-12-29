import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading; // New parameter to indicate loading state

  const CustomElevatedButton({
    Key? key,
    required this.primaryColor,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false, // Default value is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Dim the background color if loading
    final buttonColor = isLoading
        ? primaryColor.withOpacity(0.6) // Reduce opacity when loading
        : primaryColor;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable button if loading
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Use the dimmed color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          elevation: 5, // Add shadow effect
          shadowColor: Colors.black.withOpacity(0.2), // Shadow color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) // Show loading indicator if loading
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: 20, // Set width for the loading indicator
                  height: 20, // Set height for the loading indicator
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            Text(
              buttonText,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

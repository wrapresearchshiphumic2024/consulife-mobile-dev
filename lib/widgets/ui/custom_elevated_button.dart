import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback? onPressed; // Allow null to handle disabled state
  final String buttonText;
  final bool isLoading; // Indicate loading state
  final bool isEnabled; // Indicate enabled/disabled state

  const CustomElevatedButton({
    super.key,
    required this.primaryColor,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false, // Default value is false
    this.isEnabled = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Adjust button color based on loading and enabled state
    final buttonColor = !isEnabled
        ? Colors.grey // Disabled color
        : isLoading
            ? primaryColor.withOpacity(0.6) // Dimmed color when loading
            : primaryColor;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading)
            ? onPressed
            : null, // Disable button if not enabled or loading
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Use adjusted color
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

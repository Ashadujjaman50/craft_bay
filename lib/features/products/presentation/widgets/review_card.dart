import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String reviewText;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.person_outline, color: Colors.grey, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reviewText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
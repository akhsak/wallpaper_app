import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String photographer;
  final String photographerUrl;
  final int width;
  final int height;
  final String avgColor;
  final String alt;

  const ImageDetailScreen({
    required this.imageUrl,
    required this.photographer,
    required this.photographerUrl,
    required this.width,
    required this.height,
    required this.avgColor,
    required this.alt,
  });

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final directory = Directory.systemTemp; // Use temporary storage
      final filePath = '${directory.path}/image.jpg';
      await Dio().download(imageUrl, filePath);

      // Fluttertoast.showToast(
      //   msg: 'Image downloaded to: $filePath',
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Image Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Display
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image not available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Photographer:', photographer),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        'Photographer URL:',
                        photographerUrl,
                        isLink: true,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow('Resolution:', '$width x $height'),
                      const SizedBox(height: 8),
                      _buildDetailRow('Avg Color:', avgColor),
                      const SizedBox(height: 8),
                      _buildDetailRow('Description:',
                          alt.isNotEmpty ? alt : 'No description available'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _downloadImage(context),
        backgroundColor: Colors.red,
        label: const Text('Download Image'),
        icon: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLink = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: isLink
              ? GestureDetector(
                  onTap: () {
                    // Open photographer URL
                  },
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
        ),
      ],
    );
  }
}

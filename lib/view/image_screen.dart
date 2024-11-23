import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

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
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/downloaded_image.jpg';
      await Dio().download(imageUrl, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image downloaded to: $filePath'),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
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
                height: height * 0.40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image not available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
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
                      SizedBox(height: height * 0.018),
                      _buildDetailRow(
                        'Photographer URL:',
                        photographerUrl,
                        isLink: true,
                      ),
                      SizedBox(height: height * 0.018),
                      _buildDetailRow('Resolution:', '$width x $height'),
                      SizedBox(height: height * 0.018),
                      _buildDetailRow('Avg Color:', avgColor),
                      SizedBox(height: height * 0.020),
                      _buildDetailRow('Description:',
                          alt.isNotEmpty ? alt : 'No description available'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.08),
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
        SizedBox(width: width * 0.018),
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

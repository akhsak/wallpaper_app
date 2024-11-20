import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({required this.imageUrl});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final directory = Directory.systemTemp; // Use a temporary directory
      final filePath = '${directory.path}/image.jpg';
      await Dio().download(imageUrl, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Image downloaded to temporary storage: $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Detail')),
      body: Column(
        children: [
          Expanded(child: Image.network(imageUrl, fit: BoxFit.cover)),
          ElevatedButton(
            onPressed: () => _downloadImage(context),
            child: Text('Download Image'),
          ),
        ],
      ),
    );
  }
}

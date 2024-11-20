import 'package:flutter/material.dart';
import 'package:wallpaper_app/view/image_screen.dart';

Widget buildProductCard({
  required BuildContext context,
  required dynamic photo,
  required int index,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 3,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(
              imageUrl: photo.src.large,
              photographer: photo.photographer,
              photographerUrl: photo.photographerUrl,
              width: photo.width,
              height: photo.height,
              avgColor: photo.avgColor,
              alt: photo.alt,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  photo.src.large,
                  height: height * 0.22,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: height * 0.01,
                left: width * 0.03,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    "\$${(index + 1) * 10}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Wrap Text with Expanded to allow it to take available space
                Expanded(
                  child: Text(
                    photo.photographer,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Icon can stay on the right without causing overflow
                Icon(Icons.more_horiz)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

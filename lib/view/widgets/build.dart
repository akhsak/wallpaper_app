// import 'package:flutter/material.dart';
// import 'package:wallpaper_app/view/image_screen.dart';

// Widget buildTab(String title, bool isSelected, int tabIndex) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedTabIndex = tabIndex; // Update selected tab index
//         });
//       },
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isSelected ? Colors.white : Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               elevation: 0,
//             ),
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.white,
//                 fontSize: 16,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//           if (isSelected)
//             Container(
//               margin: const EdgeInsets.only(top: 4.0),
//               width: 60,
//               height: 2,
//               color: Colors.white,
//             ),
//         ],
//       ),
//     );
//   }
  
//   void setState(Null Function() param0) {
//   }

//   Widget buildProductCard({
//     required BuildContext context,
//     required dynamic photo,
//     required int index,
//   }) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 3,
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ImageDetailScreen(
//                 imageUrl: photo.src.large,
//                 photographer: photo.photographer,
//                 photographerUrl: photo.photographerUrl,
//                 width: photo.width,
//                 height: photo.height,
//                 avgColor: photo.avgColor,
//                 alt: photo.alt,
//               ),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(10),
//                   ),
//                   child: Image.network(
//                     photo.src.large,
//                     height: height * 0.45,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   top: height * 0.08,
//                   left: width * 0.08,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 4.0),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       "\$${(index + 1) * 10}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   // Wrap Text with Expanded to allow it to take available space
//                   Expanded(
//                     child: Text(
//                       photo.photographer,
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(Icons.more_horiz)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


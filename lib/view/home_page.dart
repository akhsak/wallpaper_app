import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/photo_provider.dart';
import 'package:wallpaper_app/view/image_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pinterest UI',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Follow'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab('Activity', true),
                _buildTab('Community', false),
                _buildTab('Shop', false),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: photoProvider.isLoading && photoProvider.photos.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            !photoProvider.isLoading) {
                          photoProvider.fetchPhotos();
                        }
                        return true;
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 7.0,
                          mainAxisSpacing: 7.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: photoProvider.photos.length,
                        itemBuilder: (context, index) {
                          final photo = photoProvider.photos[index];
                          return _buildProductCard(
                            imageUrl: photo.src.large,
                            name: photo.photographer,
                            // name: "Image ${index + 1}", // Example placeholder
                            price: "\$${(index + 1) * 10}", // Example price
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            width: 60,
            height: 2,
            color: Colors.white,
          ),
      ],
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String name,
    required String price,
  }) {
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
              builder: (context) => ImageDetailScreen(imageUrl: imageUrl),
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
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper_app/controller/photo_provider.dart';
// import 'package:wallpaper_app/model/model.dart';
// import 'package:wallpaper_app/view/image_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('Pinterest UI', style: TextStyle(color: Colors.white)),
//       ),
//       body: Consumer<PhotoProvider>(
//         builder: (context, photoProvider, child) {
//           return Column(
//             children: [
//               if (photoProvider.isLoading && photoProvider.photos.isEmpty)
//                 Center(child: CircularProgressIndicator())
//               else
//                 Expanded(
//                   child: NotificationListener<ScrollNotification>(
//                     onNotification: (scrollInfo) {
//                       if (scrollInfo.metrics.pixels ==
//                               scrollInfo.metrics.maxScrollExtent &&
//                           !photoProvider.isLoading) {
//                         photoProvider.fetchPhotos();
//                       }
//                       return true;
//                     },
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 8.0,
//                         mainAxisSpacing: 8.0,
//                         childAspectRatio: 0.75,
//                       ),
//                       itemCount: photoProvider.photos.length,
//                       itemBuilder: (context, index) {
//                         final photo = photoProvider.photos[index];
//                         return _buildPhotoCard(photo);
//                       },
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPhotoCard(Photo photo) {
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
//               builder: (context) =>
//                   ImageDetailScreen(imageUrl: photo.src.large),
//             ),
//           );
//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.network(
//             photo.src.large,
//             height: 150,
//             width: double.infinity,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) =>
//                 Center(child: Text('Image not available')),
//           ),
//         ),
//       ),
//     );
//   }
// }

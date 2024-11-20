import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/photo_provider.dart';
import 'package:wallpaper_app/view/image_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Current selected tab index
  int selectedTabIndex = 2; // "Shop" is the default selected tab

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);

    // Fetch photos when the widget is first built
    photoProvider.fetchPhotos();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width * 0.4),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTSKbCFe_QYSVH-4FpaszXvakr2Eti9eAJpQ&s"),
              radius: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Follow',
                style: TextStyle(color: Colors.white),
              ),
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
                _buildTab('Activity', selectedTabIndex == 0, 0),
                _buildTab('Community', selectedTabIndex == 1, 1),
                _buildTab('Shop', selectedTabIndex == 2, 2),
              ],
            ),
          ),
          // Main content

          Expanded(
            child: Consumer<PhotoProvider>(
              builder: (context, provider, child) {
                return provider.isLoading && provider.photos.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                !provider.isLoading) {
                              provider.fetchPhotos();
                            }
                            return true;
                          },
                          child: ClipRRect(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      'All Products',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Grid view
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 0.75,
                                      ),
                                      itemCount: provider.photos.length,
                                      itemBuilder: (context, index) {
                                        final photo = provider.photos[index];
                                        return _buildProductCard(
                                          context: context,
                                          photo: photo,
                                          index: index,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected, int tabIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = tabIndex; // Update selected tab index
        });
      },
      child: Column(
        children: [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.white : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
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
      ),
    );
  }

  Widget _buildProductCard({
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
}

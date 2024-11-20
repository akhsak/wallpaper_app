import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/photo_provider.dart';
import 'package:wallpaper_app/view/widgets/build.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);

    // Fetch photos when the widget is first built
    photoProvider.fetchPhotos();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width * 0.4),
            const CircleAvatar(
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
              child: const Text(
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
                _buildTab('Activity', photoProvider.selectedTabIndex == 0, 0,
                    context),
                _buildTab('Community', photoProvider.selectedTabIndex == 1, 1,
                    context),
                _buildTab(
                    'Shop', photoProvider.selectedTabIndex == 2, 2, context),
              ],
            ),
          ),
          // Main content

          Expanded(
            child: Consumer<PhotoProvider>(
              builder: (context, provider, child) {
                return provider.isLoading && provider.photos.isEmpty
                    ? const Center(child: CircularProgressIndicator())
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
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 0.75,
                                      ),
                                      itemCount: provider.photos.length,
                                      itemBuilder: (context, index) {
                                        final photo = provider.photos[index];
                                        return buildProductCard(
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

  Widget _buildTab(
      String title, bool isSelected, int tabIndex, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the changeTab method when the tab is tapped
        Provider.of<PhotoProvider>(context, listen: false).changeTab(tabIndex);
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
}

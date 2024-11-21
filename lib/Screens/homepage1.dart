import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = colors[currentPage].computeLuminance() < 0.5
        ? Colors.black
        : Colors.white;
    final Color unselectedColorReverse =
        colors[currentPage].computeLuminance() < 0.5
            ? Colors.white
            : Colors.black;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: BottomBar(
          clip: Clip.none,
          fit: StackFit.expand,
          icon: (width, height) => Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: unselectedColor,
                size: width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(500),
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: colors[currentPage].computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 30,
          iconWidth: 30,
          reverse: false,
          hideOnScroll: true,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: colors
                .map(
                  (e) => InfiniteListPage(
                    key: ValueKey('infinite_list_key#${e.toString()}'),
                    controller: controller,
                    color: e,
                  ),
                )
                .toList(),
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              TabBar(
                indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                controller: tabController,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: currentPage <= 4
                          ? colors[currentPage]
                          : unselectedColor,
                      width: 4,
                    ),
                    insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
                tabs: [
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                        child: Icon(
                      Icons.home,
                      color: currentPage == 0 ? colors[0] : unselectedColor,
                    )),
                  ),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: currentPage == 1 ? colors[1] : unselectedColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: currentPage == 2
                            ? colors[2]
                            : unselectedColorReverse,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: currentPage == 3 ? colors[3] : unselectedColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.settings,
                        color: currentPage == 4 ? colors[4] : unselectedColor,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -25,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfiniteListPage extends StatelessWidget {
  final ScrollController controller;
  final Color color;

  const InfiniteListPage({
    super.key,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ListView.builder(
        controller: controller,
        itemCount: 50, // Contoh jumlah item
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Item $index',
              style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({super.key});

//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }

// class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   final List<Color> _colors = [
//     Colors.red,
//     Colors.green,
//     Colors.blue,
//     Colors.yellow,
//     Colors.orange,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _colors.length, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         _selectedIndex = _tabController.index;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _tabController.index = index; // Update TabController
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           // Top Bar Widget
//           const TopBarWidget(
//             greeting: "Hello,",
//             userName: "User 123",
//             profileImagePath: 'assets/images/plants1.png',
//           ),
//           const SizedBox(height: 20),

//           // Carousel Banner menggunakan ArticleCarousel
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Text(
//                   'Article',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ArticleCarousel(),
//             ],
//           ),
//           const SizedBox(height: 30),

//           // Carousel Banner menggunakan ArticleCarousel
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Text(
//                   'New Added Plants',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               NewAddedPlantItem(
//                 plantName: "Pohon Pepaya",
//                 plantImage: "assets/images/plants1.png",
//                 plantDescription: "Tanaman pepaya dengan rasa manis segar.",
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),

//           // Floating Navigation Bar
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: FloatingNavigationBar(
//                 tabController: _tabController,
//                 colors: _colors,
//                 currentPage: _selectedIndex,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _selectedIndex = index;
//                     _tabController.index = index; // Update TabController
//                   });
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Widget untuk ArticleCarousel
// class ArticleCarousel extends StatelessWidget {
//   ArticleCarousel({super.key});

//   final List<String> bannerImages = [
//     'assets/images/artikel1.png',
//     'assets/images/artikel1.png',
//     'assets/images/artikel1.png',
//   ];

//   final List<String> bannerTitles = [
//     'Cara Mudah Menanam Jeruk di Rumah!',
//     'Cara Mudah Menanam Jeruk di Rumah!',
//     'Cara Mudah Menanam Jeruk di Rumah!',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 230,
//       width: double.maxFinite,
//       child: CarouselSlider(
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: true,
//           enableInfiniteScroll: false,
//           initialPage: 0,
//           autoPlay: false,
//           viewportFraction: 0.8, // Mengatur ukuran item carousel
//         ),
//         items: List.generate(bannerImages.length, (index) {
//           return Stack(
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   image: DecorationImage(
//                     image: AssetImage(bannerImages[index]),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 20,
//                 child: SizedBox(
//                   width: 375, // Batas lebar teks agar dapat membungkus
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       bannerTitles[index],
//                       style: const TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                       ),
//                       softWrap: true, // Memungkinkan teks untuk pindah baris
//                       overflow: TextOverflow.visible, // Teks tidak dipotong
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

// class TopBarWidget extends StatelessWidget {
//   final String greeting;
//   final String userName;
//   final String profileImagePath;

//   const TopBarWidget({
//     super.key,
//     required this.greeting,
//     required this.userName,
//     required this.profileImagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Kata sambutan
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 greeting,
//                 style: const TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     userName,
//                     style: const TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 5), // Jarak antara teks dan gambar
//                   Image.asset(
//                     'assets/images/waving_hands.png',
//                     height: 20,
//                     width: 20,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           // Gambar profil bulat kecil
//           CircleAvatar(
//             radius: 24,
//             backgroundImage: AssetImage(profileImagePath),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NewAddedPlantItem extends StatelessWidget {
//   final String plantName;
//   final String plantImage;
//   final String plantDescription;

//   const NewAddedPlantItem({
//     super.key,
//     required this.plantName,
//     required this.plantImage,
//     required this.plantDescription,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.grey,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Foto tanaman di sebelah kiri
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               plantImage,
//               height: 70,
//               width: 70,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 12), // Jarak antara foto dan teks
//           // Nama tanaman dan deskripsi singkat
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   plantName,
//                   style: const TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   plantDescription,
//                   style: const TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis, // Jika deskripsi terlalu panjang
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FloatingNavigationBar extends StatefulWidget {
//   final TabController tabController;
//   final List<Color> colors;
//   final int currentPage;
//   final Function(int) onPageChanged;

//   const FloatingNavigationBar({
//     super.key,
//     required this.tabController,
//     required this.colors,
//     required this.currentPage,
//     required this.onPageChanged,
//   });

//   @override
//   State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
// }

// class _FloatingNavigationBarState extends State<FloatingNavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     return FloatingNavBar(
//       colors: widget.colors,
//       selectedIndex: widget.currentPage,
//       onTap: widget.onPageChanged,
//     );
//   }
// }


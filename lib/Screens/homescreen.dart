import 'package:flutter/material.dart';
import 'package:leafyfun/component/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _currentPage = (_currentPage + 1) % 5; // Lima gambar iklan
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/background_homepage.jpg',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(height: tinggiLayar * 0.33),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuickActionItem(
                            Icons.account_balance_wallet_outlined, 'TopUp'),
                        _buildQuickActionItem(Icons.wallet, 'CashOut'),
                        _buildQuickActionItem(
                            Icons.send_to_mobile_outlined, 'Send Money'),
                        _buildQuickActionItem(Icons.menu, 'See All'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Grid Layanan
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    children: const [
                      MenuItem(
                          icon: Icons.phone_iphone_sharp, label: 'Pulsa/Data'),
                      MenuItem(icon: Icons.electric_bolt, label: 'Electricity'),
                      MenuItem(
                          icon: Icons.tv_rounded, label: 'Cable TV & Internet'),
                      MenuItem(
                          icon: Icons.money, label: 'Kartu Uang Elektronik'),
                      MenuItem(icon: Icons.church_outlined, label: 'Gereja'),
                      MenuItem(icon: Icons.wallet_giftcard, label: 'Infaq'),
                      MenuItem(
                          icon: Icons.health_and_safety_sharp,
                          label: 'Other Donations'),
                      MenuItem(icon: Icons.more_horiz, label: 'More'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Banner Otomatis
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 5, // Lima gambar iklan
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return BannerItem(
                        imageUrl:
                            'assets/iklan${index + 1}.jpg', // Gambar iklan
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Indikator Manual
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentPage == index ? 10.0 : 8.0,
                      height: _currentPage == index ? 10.0 : 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Colors.red : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            ),
            // Top Section
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/logo.png', width: 50),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: 410,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi, Diantoro Kadarman',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _balanceInfo('Your Balance', 'Rp 0', Colors.red),
                              const SizedBox(width: 12),
                              _balanceInfo(
                                  'Bonus Balance', 'Rp 0', Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(IconData iconData, String label) {
    return Column(
      children: [
        Icon(iconData, color: Colors.black87, size: 30.0),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: Colors.black87, fontSize: 12)),
      ],
    );
  }

  Widget _balanceInfo(String label, String amount, Color iconColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(amount,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(width: 4),
                Icon(Icons.add_circle_outline, color: iconColor, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final String imageUrl;

  const BannerItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

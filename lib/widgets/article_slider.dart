import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:leafyfun/Screens/article_widget.dart';

class ArticleSlider extends StatelessWidget {
  ArticleSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/apple_article.jpg',
    'assets/images/cherry_article.jpg',
    'assets/images/tomato_article.jpeg',
    'assets/images/grape_article.jpeg',
    'assets/images/strawberry_article.jpeg',
  ];

  final List<String> bannerTitles = [
    'Discovering the World of Apples',
    'The Sweet and Tart World of Cherries',
    'The Versatile Tomato: A Gardener’s Delight',
    'Unveiling the Secrets of Grapes',
    'Strawberries: Sweetness from the Heart',
  ];

  final List<Widget> targetPages = [
    ArticleWidget(
      title: 'Discovering the World of Apples',
      imagePath: 'assets/images/apple_article.jpg',
      sections: [
        Section(
          subtitle: 'A Symbol of Knowledge',
          content:
              'Apples have been cultivated for thousands of years and are often associated with knowledge and wisdom, as symbolized in myths like the story of Isaac Newton and the apple.',
        ),
        Section(
          subtitle: 'How to Grow Apples at Home',
          content:
              'Apple trees require well-drained soil and plenty of sunlight. Prune them regularly to ensure healthy growth, and be patient as they can take several years to produce fruit.',
        ),
        Section(
          subtitle: 'Fun Fact',
          content:
              'Did you know that there are over 7,500 varieties of apples grown worldwide? Each variety has its own unique flavor and use, from sweet desserts to tangy ciders.',
        ),
      ],
    ),
    ArticleWidget(
      title: 'The Sweet and Tart World of Cherries',
      imagePath: 'assets/images/cherry_article.jpg',
      sections: [
        Section(
          subtitle: 'The Dual Nature of Cherries',
          content:
              'Cherries are categorized into sweet and sour varieties. Sweet cherries are perfect for fresh snacking, while sour cherries are often used in pies and preserves.',
        ),
        Section(
          subtitle: 'Growing Your Cherry Tree',
          content:
              'Cherries thrive in temperate climates and need well-drained soil. Ensure proper pollination by planting compatible varieties nearby, and protect the fruits from birds as they ripen.',
        ),
        Section(
          subtitle: 'A Historical Delicacy',
          content:
              'Cherries were prized by the Romans and have been cultivated for centuries. They are rich in antioxidants and are a symbol of good fortune in Japanese culture.',
        ),
      ],
    ),
    ArticleWidget(
      title: 'The Versatile Tomato: A Gardener’s Delight',
      imagePath: 'assets/images/tomato_article.jpeg',
      sections: [
        Section(
          subtitle: 'A Fruit or a Vegetable?',
          content:
              'While botanically a fruit, tomatoes are commonly used as a vegetable in cooking. Their versatility makes them a staple in cuisines worldwide.',
        ),
        Section(
          subtitle: 'Growing Tomatoes in Your Garden',
          content:
              'Tomatoes need warm temperatures, plenty of sunlight, and nutrient-rich soil. Regular watering and staking the plants ensure healthy growth and bountiful harvests.',
        ),
        Section(
          subtitle: 'Tomato Fun Fact',
          content:
              'Tomatoes come in a variety of colors, including red, yellow, green, and even purple. The largest tomato ever grown weighed over 7 pounds!',
        ),
      ],
    ),
    ArticleWidget(
      title: 'Unveiling the Secrets of Grapes',
      imagePath: 'assets/images/grape_article.jpeg',
      sections: [
        Section(
          subtitle: 'From Vine to Glass',
          content:
              'Grapes have been used for winemaking for over 8,000 years. Today, they are also enjoyed fresh, dried as raisins, or juiced into a refreshing drink.',
        ),
        Section(
          subtitle: 'Caring for Grape Vines',
          content:
              'Grape vines require support structures like trellises. They grow best in sunny locations with well-drained soil. Pruning is essential to maintain their shape and encourage fruit production.',
        ),
        Section(
          subtitle: 'Health Benefits',
          content:
              'Grapes are packed with antioxidants and vitamins, making them a heart-healthy snack. They are also believed to improve brain function and slow down aging.',
        ),
      ],
    ),
    ArticleWidget(
      title: 'Strawberries: Nature’s Sweet Treat',
      imagePath: 'assets/images/strawberry_article.jpeg',
      sections: [
        Section(
          subtitle: 'A Perfect Balance of Sweet and Tangy',
          content:
              'Strawberries are loved for their unique flavor and vibrant color. They are used in desserts, smoothies, and as a topping for various dishes.',
        ),
        Section(
          subtitle: 'Tips for Growing Strawberries',
          content:
              'Strawberries are easy to grow in containers or garden beds. Ensure they get full sunlight, keep the soil moist, and protect them from pests with a net or organic sprays.',
        ),
        Section(
          subtitle: 'Fun Fact',
          content:
              'Strawberries are the only fruit with seeds on the outside. Each strawberry has about 200 seeds, and they are technically not a true berry!',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.maxFinite,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 0.8, // Mengatur ukuran item carousel
        ),
        items: List.generate(bannerImages.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => targetPages[index],
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(bannerImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: SizedBox(
                    width: 300, // Batas lebar teks agar dapat membungkus
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bannerTitles[index],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        softWrap: true, // Memungkinkan teks untuk pindah baris
                        overflow: TextOverflow.visible, // Teks tidak dipotong
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:leafyfun/widgets/add_leafyGarden_button.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';
import 'package:leafyfun/widgets/plantDescription.dart';

class ScanDetailPage extends StatefulWidget {
  // final File capturedImage;

  const ScanDetailPage({
    super.key,
    // required this.capturedImage,
  });

  @override
  State<ScanDetailPage> createState() => _ScanDetailPageState();
}

class _ScanDetailPageState extends State<ScanDetailPage> {
  late String commonName;
  late String latinName;
  late String description;
  late String fruitContent;
  late String fruitSeason;
  late String region;
  late String priceRange;

  @override
  void initState() {
    super.initState();
    fetchPlantData(); // Fetch plant data when the page is loaded
  }

  Future<void> fetchPlantData() async {
    final response = await http
        .get(Uri.parse('${dotenv.env['ENDPOINT_URL']}/plants/plants/'));

    if (response.statusCode == 200) {
      List<dynamic> plantList = json.decode(response.body);
      // You can pick one plant or loop over the list if you have more than one plant
      var plant = plantList[0]; // Assuming you want the first plant
      setState(() {
        commonName = plant['common_name'];
        latinName = plant['latin_name'];
        description = plant['description'];
        fruitContent = plant['fruit_content'];
        fruitSeason = plant['fruit_season'];
        region = plant['region'];
        priceRange = plant['price_range'];
      });
    } else {
      throw Exception('Failed to load plant data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Gambar hasil scan
                  Center(
                    // child: Image.file(
                    //   widget.capturedImage,
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  const SizedBox(height: 20),
                  // Menampilkan detail tanaman
                  PlantDescription(
                    commonName: commonName,
                    latinName: latinName,
                    description: description,
                    fruitContent: fruitContent,
                    fruitSeason: fruitSeason,
                    region: region,
                    priceRange: priceRange,
                  ),
                  const SizedBox(height: 50),
                  // Tombol untuk menambah ke LeafyGarden
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AddLeafygardenButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

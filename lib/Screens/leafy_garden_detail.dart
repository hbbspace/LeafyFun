import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';
import 'package:leafyfun/widgets/plantDescription_widget.dart';
import 'package:provider/provider.dart';

class LeafyGardenDetail extends StatefulWidget {
  final int plantId; // plant_id dari halaman sebelumnya

  int get getPlantId => plantId;

  const LeafyGardenDetail({
    super.key,
    required this.plantId,
  });

  @override
  State<LeafyGardenDetail> createState() => _LeafyGardenDetailState();
}

class _LeafyGardenDetailState extends State<LeafyGardenDetail> {
  String commonName = "";
  String latinName = "";
  String description = "";
  String fruitContent = "";
  String fruitSeason = "";
  String region = "";
  String priceRange = "";
  bool _isDataInitialized = false;

  String getImagePath(int plantId) {
    // Default image paths based on plantId
    switch (plantId) {
      case 1: //apple
        return 'assets/images/garden_apple.jpg';
      case 2: // cherry
        return 'assets/images/garden_cherry.jpg';
      case 3: // grape
        return 'assets/images/garden_grape.webp';
      case 4: // strawberry
        return 'assets/images/garden_strawberry.jpg';
      case 5: // tomato
        return 'assets/images/garden_tomato.jpg';
      default:
        return 'assets/images/apple_plants.png'; // Fallback image
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlantData(); // Fetch plant data when the page is loaded
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pastikan data selalu diperbarui ketika halaman diaktifkan kembali
    if (!_isDataInitialized) {
      _initializeData();
    }
  }

  Future<void> _initializeData() async {
    if (_isDataInitialized) return;
    _isDataInitialized = true;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();

    await fetchPlantData();
  }

  Future<void> fetchPlantData() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/plants/'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
        },
      );

      if (response.statusCode == 200) {
        // Menampilkan respons body untuk debug
        debugPrint('Response body: ${response.body}');

        // Cek apakah server mengembalikan JSON
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          List<dynamic> plantList = json.decode(response.body);

          // Ambil data tanaman berdasarkan nilai prediction
          var plant = plantList.isNotEmpty
              ? plantList[widget.plantId - 1]
              : null; // Menggunakan widget.prediction sebagai indeks

          if (plant != null) {
            // Pastikan widget masih terpasang sebelum memanggil setState
            if (mounted) {
              setState(() {
                commonName = plant['common_name'];
                latinName = plant['latin_name'];
                description = plant['description'];
                fruitContent = plant['fruit_content'];
                fruitSeason = plant['fruit_season'];
                region = plant['region'];
                priceRange = plant['price_range'];
              });
            }
          } else {
            throw Exception('No plant data available');
          }
        } else {
          throw Exception(
              'Server did not return JSON, Content-Type is not application/json');
        }
      } else {
        throw Exception(
            'Failed to load plant data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      // Tampilkan dialog error jika terjadi kesalahan
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Error'),
              content: Text('Failed to load plant data: $e'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Menampilkan gambar berdasarkan plantId
                  Center(
                    child: Image.asset(
                      getImagePath(widget.plantId),
                      height: 340,
                      fit: BoxFit.cover,
                    ),
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
                ],
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}

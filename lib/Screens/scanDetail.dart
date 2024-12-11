import 'dart:convert';
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
  String commonName = "";
  String latinName = "";
  String description = "";
  String fruitContent = "";
  String fruitSeason = "";
  String region = "";
  String priceRange = "";

  @override
  void initState() {
    super.initState();
    fetchPlantData(); // Fetch plant data when the page is loaded
  }

  Future<void> fetchPlantData() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/plants/plants/'),
        headers: {
          'ngrok-skip-browser-warning': 'true',  // Menambahkan header ini untuk menghindari halaman warning
        },
      );

      if (response.statusCode == 200) {
        // Menampilkan respons body untuk debug
        print('Response body: ${response.body}');  // Menampilkan respons untuk memeriksa masalah

        // Cek header Content-Type untuk memastikan JSON
        if (response.headers['content-type']?.contains('application/json') ?? false) {
          List<dynamic> plantList = json.decode(response.body);
          
          // Ambil data tanaman pertama jika ada
          var plant = plantList.isNotEmpty ? plantList[0] : null; // Mengambil tanaman pertama
          
          if (plant != null) {
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
            throw Exception('No plant data available');
          }
        } else {
          throw Exception('Server did not return JSON, Content-Type is not application/json');
        }
      } else {
        throw Exception('Failed to load plant data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani kesalahan lainnya seperti jaringan atau parsing
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load plant data: $e'),
            actions: [
              TextButton(
                child: Text('OK'),
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:leafyfun/Screens/leafy_garden.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/add_leafyGarden_button.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';
import 'package:leafyfun/widgets/plantDescription_widget.dart';
import 'package:provider/provider.dart';

class ScanDetailPage extends StatefulWidget {
  final File capturedImage;
  final int prediction;
  // final Float confidence;

  int get getprediction => prediction;

  const ScanDetailPage({
    super.key,
    required this.capturedImage,
    required this.prediction,
    // required this.confidence,
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
  bool _isDataInitialized = false;

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
          'ngrok-skip-browser-warning':
              'true', // Menambahkan header ini untuk menghindari halaman warning
        },
      );

      if (response.statusCode == 200) {
        // Menampilkan respons body untuk debug
        debugPrint(
            'Response body: ${response.body}'); // Menampilkan respons untuk memeriksa masalah

        // Cek header Content-Type untuk memastikan JSON
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          List<dynamic> plantList = json.decode(response.body);

          // Ambil data tanaman berdasarkan nilai prediction
          var plant = plantList.isNotEmpty
              ? plantList[widget.prediction - 1]
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
      // Tangani kesalahan lainnya seperti jaringan atau parsing
      debugPrint('Error: $e');
      // Pastikan widget masih terpasang sebelum menampilkan dialog error
      if (mounted) {
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
  }

  Future<void> addUserPlant() async {
  try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;

    // Ambil plantId dari prediksi
    var plantId = widget.prediction - 1; // Prediction sebagai indeks untuk plantId

    // Periksa apakah user sudah memiliki plant yang sama
    final checkResponse = await http.get(
      Uri.parse('${dotenv.env['ENDPOINT_URL']}/user_plants/$userId/$plantId'),
      headers: {
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (checkResponse.statusCode == 200) {
      // User sudah memiliki plant, arahkan ke LeafyGarden
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LeafyGarden()),
      );
    } else {
      plantId = widget.prediction + 1;
      // Tambahkan plant baru untuk user
      final response = await http.post(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/add_user_plant'),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode({
          'user_id': userId,
          'plant_id': plantId,
          'date_saved': DateTime.now().toIso8601String(),
          'quiz_score': 0, // Atur quiz_score jika diperlukan
        }),
      );

      if (response.statusCode == 201) {
        // Plant berhasil ditambahkan untuk user, arahkan ke LeafyGarden
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeafyGarden()),
        );
      } else {
        throw Exception('Failed to add user plant');
      }
    }
  } catch (e) {
    debugPrint('Error: $e');
    // Tangani kesalahan, tampilkan pesan ke pengguna jika diperlukan
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add user plant: $e'),
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
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Gambar hasil scan
                  Center(
                    child: Image.file(
                      widget.capturedImage,
                      height: 200,
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
                  const SizedBox(height: 50),
                  // Tombol untuk menambah ke LeafyGarden
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AddLeafygardenButton(
                      onPressed: addUserPlant,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/popup_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'scan_detail.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  File? _capturedImage;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController?.initialize();
      setState(() {});
    } else {
      debugPrint("No camera found");
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();

        final directory = await getApplicationDocumentsDirectory();
        final imagePath = path.join(directory.path, '${DateTime.now()}.jpg');
        final savedImage = await File(image.path).copy(imagePath);

        setState(() {
          _capturedImage = savedImage;
        });

        await _sendToPredict(savedImage);
      } catch (e) {
        debugPrint("Error capturing image: $e");
      }
    }
  }

  Future<void> _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final pickedFile = File(result.files.single.path!);

      setState(() {
        _capturedImage = pickedFile;
      });

      await _sendToPredict(pickedFile);
    }
  }

  Future<void> _sendToPredict(File image) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;

    String predictUrl = "${dotenv.env['ENDPOINT_URL']}/predict/";
    String addScanUrl = "${dotenv.env['ENDPOINT_URL']}/add_leaf_scan";

    try {
      // Buat request multipart
      final request = http.MultipartRequest('POST', Uri.parse(predictUrl))
        ..headers.addAll({
          'ngrok-skip-browser-warning': 'true',
        })
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      // Kirim request dan tunggu respon
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("${data}");

        if (data["plant_id"] != 0) {
          // Kirim hasil ke endpoint add_leaf_scan
          final addResponse = await http.post(
            Uri.parse(addScanUrl),
            headers: {
              'ngrok-skip-browser-warning': 'true',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "user_id": userId,
              "scan_image": data["file_name"],
              "plant_id": data["plant_id"],
              "confidence_score": data["confidence"],
            }),
          );

          if (addResponse.statusCode == 201) {
            // Navigasi ke halaman detail
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanDetailPage(
                    capturedImage: image,
                    prediction: data["plant_id"],
                    // confidence: data["confidence"],
                  ),
                ),
              );
            }
          } else {
            debugPrint("Gagal menyimpan hasil scan.");
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => PopupWidget(
              title: 'Confidence is too low',
              desc: '',
              buttonText: 'OK',
              imagePath: 'assets/images/cancel.png', // Path gambar yang sesuai
              onTap: () {
                Navigator.of(context)
                    .pop(); // Menutup dialog saat tombol ditekan
              },
            ),
          );
          debugPrint("Confidence terlalu rendah untuk prediksi.");
        }
      } else {
        debugPrint(
            "Gagal memproses gambar. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error sending to predict: $e");
      debugPrint("Terjadi kesalahan saat memproses gambar.");
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        _isFlashOn = !_isFlashOn;
        await _cameraController!.setFlashMode(
          _isFlashOn ? FlashMode.torch : FlashMode.off,
        );
        setState(() {});
      } catch (e) {
        debugPrint("Error toggling flash: $e");
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _cameraController == null || !_cameraController!.value.isInitialized
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_cameraController!),
                ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Image.asset(
                    'assets/images/flash_button.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: _captureImage,
                  child: Image.asset(
                    'assets/images/scan_button.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: _uploadImage,
                  child: Image.asset(
                    'assets/images/upload_button.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Center(
              child: Image.asset(
                'assets/images/scan_border.png',
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 30,
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconPath: 'assets/images/arrow-left.png',
              borderColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

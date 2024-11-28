import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0], // Pilih kamera pertama
        ResolutionPreset.high, // Resolusi kamera
      );
      await _cameraController?.initialize();
      setState(() {});
    } else {
      print("No camera found");
    }
  }

  // Capture an image and save it locally
  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();

        // Save the image to a local directory
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = join(directory.path, '${DateTime.now()}.jpg');
        final savedImage = await File(image.path).copy(imagePath);

        setState(() {
          _capturedImage = savedImage;
        });
      } catch (e) {
        print("Error capturing image: $e");
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
      body: Stack(
        children: [
          _cameraController == null || !_cameraController!.value.isInitialized
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_cameraController!),
                ),
          // Positioned(
          //   bottom: 60, // Jarak tombol dari bagian bawah layar
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: GestureDetector(
          //       onTap: _captureImage,
          //       child: Image.asset(
          //         'assets/images/scan_button.png',
          //         width: 150,
          //         height: 150,
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
            bottom: 60, // Jarak dari bagian bawah layar
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flash Button
                GestureDetector(
                  onTap: () {
                    print("Upload button pressed");
                  },
                  child: Center(
                    child: GestureDetector(
                      onTap: _captureImage,
                      child: Image.asset(
                        'assets/images/flash_button.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Jarak antara tombol

                // Scan Button
                GestureDetector(
                  onTap: () {
                    print("Scan button pressed");
                  },
                  child: Center(
                    child: GestureDetector(
                      onTap: _captureImage,
                      child: Image.asset(
                        'assets/images/scan_button.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Jarak antara tombol

                // Upload Button
                GestureDetector(
                  onTap: () {
                    print("Flash button pressed");
                  },
                  child: Center(
                    child: GestureDetector(
                      onTap: _captureImage,
                      child: Image.asset(
                        'assets/images/upload_button.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
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
          )),
          Positioned(
            top: 60,
            left: 30,
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context); // Navigasi ke halaman sebelumnya
              },
              iconPath: 'assets/images/ArrowLeftBlack.png',
              borderColor: Colors.transparent,
            ),
          ),
          if (_capturedImage != null)
            Positioned(
              bottom: 120, // Jarak tombol submit dari tombol scan
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Tambahkan logika untuk mengirim gambar ke backend
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image sent to backend!')),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed; // Fungsi fleksibel untuk navigasi atau aksi
  final String iconPath; // Path ke gambar icon
  final Color borderColor; // Warna border stroke

  const ArrowBackButton({
    super.key,
    required this.onPressed,
    this.iconPath = 'assets/images/ArrowLeftBack.png', // Path default
    this.borderColor = Colors.black, // Warna default
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Container luar sebagai "stroke"
          Container(
            width:
                35, // Lebar dan tinggi lebih besar dari gambar untuk "stroke"
            height: 35,
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 202, 202, 202), // Warna latar belakang stroke
              borderRadius: BorderRadius.circular(10), // Border rounded
              border: Border.all(
                color: borderColor, // Warna "stroke"
                width: 1, // Ketebalan "stroke"
              ),
            ),
          ),
          // Container dalam berisi gambar icon
          Container(
            width: 20, // Lebar dan tinggi sesuai dengan ukuran gambar
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Border rounded gambar
            ),
            child: Image.asset(
              iconPath, // Path gambar icon custom
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

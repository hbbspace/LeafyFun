import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart'; // Import untuk file picker
import '../widgets/backButton.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  File? _capturedImage;
  bool _isFlashOn = false; // Status flash

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

  // Toggle flash on or off
  Future<void> _toggleFlash() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        _isFlashOn = !_isFlashOn;
        await _cameraController!.setFlashMode(
          _isFlashOn ? FlashMode.torch : FlashMode.off,
        );
        setState(() {});
      } catch (e) {
        print("Error toggling flash: $e");
      }
    }
  }

  // Open file picker to upload image
  Future<void> _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final pickedFile = File(result.files.single.path!);

      setState(() {
        _capturedImage = pickedFile;
      });

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Image selected: ${pickedFile.path}')),
      );
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
          Positioned(
            bottom: 60, // Jarak dari bagian bawah layar
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flash Button
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Image.asset(
                    'assets/images/flash_button.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(width: 20), // Jarak antara tombol

                // Scan Button
                GestureDetector(
                  onTap: _captureImage,
                  child: Image.asset(
                    'assets/images/scan_button.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(width: 20), // Jarak antara tombol

                // Upload Button
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
                Navigator.pop(context); // Navigasi ke halaman sebelumnya
              },
              iconPath: 'assets/images/arrow-left.png',
              borderColor: Colors.grey,
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
                    
                    ScaffoldMessenger.of(context).showSnackBar( // error?
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

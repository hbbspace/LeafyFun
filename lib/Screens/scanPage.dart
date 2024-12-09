import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path; // Berikan alias pada 'path'
import 'package:file_picker/file_picker.dart';
import '../widgets/arrowBack_button.dart';
import 'scanDetail.dart'; // Import halaman detail

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

  // Initialize the camera
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
      print("No camera found");
    }
  }

  // Capture an image and navigate to the detail page
  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();

        // Save the image to a local directory
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = path.join(
            directory.path, '${DateTime.now()}.jpg'); // Gunakan alias path
        final savedImage = await File(image.path).copy(imagePath);

        setState(() {
          _capturedImage = savedImage;
        });

        // Navigate to the detail page with the captured image
        if (mounted) {
          // Gunakan 'mounted' tanpa 'context'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanDetailPage(
                capturedImage: savedImage,
              ),
            ),
          );
        }
      } catch (e) {
        print("Error capturing image: $e");
      }
    }
  }

  // Toggle flash
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

  // Upload image using file picker
  Future<void> _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final pickedFile = File(result.files.single.path!);

      setState(() {
        _capturedImage = pickedFile;
      });

      // Navigate to the detail page with the uploaded image
      if (mounted) {
        // Gunakan 'mounted' tanpa 'context'
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanDetailPage(
              capturedImage: pickedFile,
            ),
          ),
        );
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

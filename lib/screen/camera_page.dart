import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isImageAvailable = false;
  bool _isDetecting = false;
  final uri = 'https://4lfj8j92-5000.asse.devtunnels.ms/predict'; // Ganti sesuai endpoint kamu

  // Ambil gambar dari kamera
  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _isImageAvailable = true;
      });
    }
  }

  // Ambil gambar dari galeri dan langsung prediksi
  Future<void> _pickFromGalleryAndPredict() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _isImageAvailable = true;
      });
      await _detectImage();
    }
  }

  // Kirim gambar ke server Flask dan tampilkan hasil
  Future<void> _detectImage() async {
    if (_image == null) return;

    setState(() {
      _isDetecting = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(uri),
      );

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Hasil Prediksi"),
            content: Text("Prediction: ${jsonResponse['data']}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Terjadi kesalahan: ${jsonResponse['error']}"),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exception"),
          content: Text("Terjadi error: $e"),
        ),
      );
    } finally {
      setState(() {
        _isDetecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffAFFAC4), Color(0xff00543B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.file(_image!),
            )
                : const Text('Belum ada gambar.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openCamera,
              child: const Text('📷 Buka Kamera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickFromGalleryAndPredict,
              child: const Text('🖼️ Upload dari Galeri & Prediksi'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:
              _isImageAvailable && !_isDetecting ? _detectImage : null,
              child: const Text("🔍 Deteksi Gambar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}

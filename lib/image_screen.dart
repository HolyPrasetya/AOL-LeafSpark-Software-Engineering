import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<String?> sendImageToServer() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return null;

  final uri = Uri.parse('http://192.168.10.8:5000/predict'); // Ganti IP sesuai Flask-mu
  final request = http.MultipartRequest('POST', uri);

  request.files.add(await http.MultipartFile.fromPath('image', pickedFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(respStr);
    return jsonResponse['data'];
  } else {
    return "Upload failed: ${response.statusCode}";
  }
}

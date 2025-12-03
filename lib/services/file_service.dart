// lib/services/file_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  final String fileName;

  FileService({this.fileName = 'last_order.txt'});

  Future<String> _localPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> _localFile() async {
    final path = await _localPath();
    return File('$path/$fileName');
  }

  Future<void> writeOrder(String contents) async {
    final file = await _localFile();
    await file.writeAsString(contents);
  }

  Future<String?> readOrder() async {
    try {
      final file = await _localFile();
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// helper to expose path for debugging
  Future<String> filePath() async {
    return (await _localFile()).path;
  }
}

// lib/services/file_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Service for handling file operations
class FileService {
  /// Write order details to a file
  Future<void> writeOrder(String orderDetails) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/last_order.txt');
      await file.writeAsString(orderDetails);
    } catch (e) {
      throw Exception('Failed to write order: $e');
    }
  }

  /// Read the last order from file
  Future<String?> readOrder() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/last_order.txt');
      
      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

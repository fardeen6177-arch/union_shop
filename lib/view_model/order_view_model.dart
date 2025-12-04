// lib/view_models/order_view_model.dart
import '../services/file_service.dart';

class OrderViewModel {
  final FileService fileService;

  OrderViewModel({FileService? fileService})
      : fileService = fileService ?? FileService();

  Future<void> saveOrderToFile({
    required int quantity,
    required bool isFootlong,
    required String bread,
    bool isToasted = false,
  }) async {
    final sandwichType = isFootlong ? 'footlong' : 'six-inch';
    final toastedText = isToasted ? 'toasted' : 'untoasted';
    final orderDetails =
        '$quantity x $sandwichType ($bread, $toastedText) sandwich(es)';
    await fileService.writeOrder(orderDetails);
  }

  Future<String?> readLastOrder() async {
    return await fileService.readOrder();
  }
}

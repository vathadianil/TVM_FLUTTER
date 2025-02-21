import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/metro_card/active_payment_gateway_repository.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class ActivePaymentGatewayController extends GetxController {
  final selectedPaymentGateWay = 0.obs;
  final isLoading = false.obs;
  final paymentGatewayRepository = Get.put(ActivePaymentGatewayRepository());

  // @override
  // onInit() {
  //   super.onInit();
  //   // getActivePaymentGateway();
  // }

  Future<void> getActivePaymentGateway() async {
    try {
      isLoading.value = true;
      final response = await paymentGatewayRepository.getActivePaymentGateway();
      selectedPaymentGateWay.value = response.pgId ?? 0;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to fetch Active payment gateway');
    } finally {
      isLoading.value = false;
    }
  }
}

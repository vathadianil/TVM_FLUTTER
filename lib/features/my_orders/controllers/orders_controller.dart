import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/my_orders/my_orders_repository.dart';
import 'package:tsavaari/features/qr/display_qr/models/payment_failed_ticket_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();
  OrdersController({this.tabIndex = 0});
  //Variables
  final int tabIndex;
  final isLoading = true.obs;
  final deviceStorage = GetStorage();
  final activeTickets = <ActiveTicketModel>{}.obs;
  final paymentFailedData = <PaymentFailedData>[].obs;
  final _myOrdersRepository = Get.put(MyOrdersRepository());
  final fliterText = TTexts.paymentFailed.obs;

  @override
  void onInit() {
    super.onInit();
    if (tabIndex == 0) {
      getActiveTickets();
    } else if (tabIndex == 1) {
      getPastTickets();
    } else {
      getPaymentFailedAndRefundedTickets();
    }
  }

  Future<void> getActiveTickets() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      activeTickets.clear();
      final token = await deviceStorage.read('token');

      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';

      final payload = {
        "patornPhoneNumber": phoneNumber,
        "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
        "selectedMonthYear": "",
        "token": token
      };
      if (token != null) {
        final activeTicketData =
            await _myOrdersRepository.fetchActiveTickets(payload);

        formatTicketData(activeTicketData);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> getPastTickets() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      activeTickets.clear();
      final token = await deviceStorage.read('token');

      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';

      final payload = {
        "patornPhoneNumber": phoneNumber,
        "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
        "selectedMonthYear": "",
        "token": token
      };
      if (token != null) {
        final activeTicketData =
            await _myOrdersRepository.fetchPastTickets(payload);

        formatTicketData(activeTicketData);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  void formatTicketData(ActiveTicketModel activeTicketData) {
    if (activeTicketData.ticketHistory != null) {
      mergeTicketHistory(activeTicketData);
      activeTickets.add(activeTicketData);
    }
  }

  void mergeTicketHistory(ActiveTicketModel activeTicketData) {
    var history = activeTicketData.ticketHistory!;
    int i = 0;
    while (i < history.length - 1) {
      if (history[i].tickets![0].orderID ==
          history[i + 1].tickets![0].orderID) {
        mergeTickets(history, i);
      } else {
        i++;
      }
    }
  }

  void mergeTickets(List<TicketHistory> history, int index) {
    var firstTickets = history[index].tickets!;
    var secondTickets = history[index + 1].tickets!;

    if (firstTickets[0].entryExitCode == 'RJT_OUTWARD') {
      firstTickets.addAll(secondTickets);
      history[index].tickets = firstTickets.cast<TicketsListModel>();
      history.removeAt(index + 1);
    } else {
      secondTickets.addAll(firstTickets);
      history[index + 1].tickets = secondTickets.cast<TicketsListModel>();
      history.removeAt(index);
    }
  }

  Future<void> getPaymentFailedAndRefundedTickets() async {
    try {
      isLoading.value = true;
      paymentFailedData.clear();
      final token = await deviceStorage.read('token');
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';

      final payload = {
        "patronPhoneNumber": phoneNumber,
        "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
        "selectedMonthYear": "",
        "token": token
      };
      if (token != null) {
        final response = await _myOrdersRepository
            .fetchPaymentFailedAndRefundedTickets(payload);

        if (response.paymentFailed != null &&
            response.paymentFailed!.isNotEmpty) {
          paymentFailedData.assignAll(response.paymentFailed!);
          paymentFailedData.sort((a, b) {
            final dateTimeA = a.updateDateTime!;
            final dateTimeB = b.updateDateTime!;
            return DateTime.parse(dateTimeB)
                .compareTo(DateTime.parse(dateTimeA));
          });
        }
      }
    } catch (e) {
      // TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}

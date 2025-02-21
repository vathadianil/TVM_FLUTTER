import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/controllers/active_payment_gateway_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/amounts_scroll_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/paytm_payment_gateway_controller.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/card_reacharge/models/last_recharge_status_model.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/payment_processing_screen.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
// import 'package:tsavaari/utils/constants/payment_gateway.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/card_recharge_utils.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class MetroCardController extends GetxController {
  static MetroCardController get instance => Get.find();

  //variables
  final isCardDetailsLoading = false.obs;
  final isTravelHistoryLoading = false.obs;
  final isLastRcgStatusLoading = false.obs;
  final isCardPaymentDataLoading = false.obs;
  final isCardTravelHistoryLoading = false.obs;
  final isNebulaCardValidating = false.obs;
  final cardTravelHistoryList = <CardTravelHistoryModel>[].obs;
  final storeNebulaCardValidationDetails = <NebulaCardValidationModel>[].obs;
  final cardDetailsByUser = <CardDetailsByUserModel>{}.obs;
  final lastRcgStatusList = <LastRechargeStatusModel>[].obs;
  final cardPaymentListData = <CardTrxDetailsModel>[].obs;
  final _cardRepository = Get.put(MetroCardRepository());
  final carouselCurrentIndex = 0.obs;
  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final selectedTopupAmount = '0'.obs;
  final paytmController = Get.put(PaytmPaymentController());
  final activepaymentGateWayController =
      Get.put(ActivePaymentGatewayController());
  final cardRechargeAmounts = [].obs;

  GlobalKey<FormState> cardAddOrUpdateFormKey = GlobalKey<FormState>();

  // Variable to track redemption status
  final _loyaltyPointsRepository = Get.put(LoyaltyPointsRepository());
  final isRedemptionEligibilityLoading = false.obs;
  final loyaltyProgramKey = 0.obs;
  final isRedeemed = false.obs;
  final isRedemptionEligibile = 0.obs;
  final pointsToRedeem = 0.obs;
  final maxRedemptionAmount = 0.obs;
  final quoteId = ''.obs;
  final finalRechargeAmount = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMetroCardDetailsByUser();
    fetchCardRechargeAmounts();
  }

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
    if (!storeNebulaCardValidationDetails.asMap().containsKey(index)) {
      validateNebulaCard(cardDetailsByUser.first.cardDetails![index].cardNo!);
      fetchCardTravelHistory(
          cardDetailsByUser.first.cardDetails![index].cardNo!);
      fetchCardTransactionDetails(
          cardDetailsByUser.first.cardDetails![index].cardNo!);
      fetchCardLastTrasactionStatus(
          cardDetailsByUser.first.cardDetails![index].cardNo!);
    }
  }

  Future<void> fetchCardRechargeAmounts() async {
    try {
      final response = await _cardRepository.getCardRechargeAmounts();
      cardRechargeAmounts.assignAll(response.amounts!);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!', message: 'Failed to fetch card recharge amounts');
    }
  }

  Future<void> checkCardRedemptionEligibility() async {
    try {
      //Loading
      isRedemptionEligibilityLoading.value = true;

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TLoaders.customToast(message: 'No Internet Connection');
        isRedemptionEligibilityLoading.value = false;
        return;
      }

      final userId = await TLocalStorage().readData('uid') ?? '';

      final payload = {
        "user_id": userId.toString(),
        "ticket_amount": selectedTopupAmount.value.toString()
      };

      final eligibilityData =
          await _loyaltyPointsRepository.checkRedemptionEligibility(payload);

      if (eligibilityData.eligible == 1) {
        loyaltyProgramKey.value = eligibilityData.loyaltyProgramKey!;
        isRedeemed.value = true;
        isRedemptionEligibile.value = eligibilityData.eligible!;
        pointsToRedeem.value = eligibilityData.pointsToRedeem!;
        maxRedemptionAmount.value = eligibilityData.maxRedemptionAmount!;
        quoteId.value = eligibilityData.quoteId ?? '';

        updateFinalRechargeAmount();

        //Available Points after Redemption
        RewardPointsController.instance.activePoints.value =
            eligibilityData.availablePoints! - eligibilityData.pointsToRedeem!;

        TLoaders.successSnackBar(
            title: 'Success!', message: eligibilityData.message);
      } else {
        throw eligibilityData.message.toString();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isRedemptionEligibilityLoading.value = false;
    }
  }

  // Update the method to be a computed property
  void updateFinalRechargeAmount() {
    final int baseFare = int.tryParse(selectedTopupAmount.value) ?? 0;
    final finalFare = isRedeemed.value &&
            loyaltyProgramKey.value == 1 &&
            baseFare >= maxRedemptionAmount.value
        ? baseFare - maxRedemptionAmount.value
        : baseFare;
    finalRechargeAmount.value = finalFare.toString();
  }

  // Method to reset redemption state
  void resetRedemptionState() {
    isRedeemed.value = false;
    isRedemptionEligibile.value = 0;
    pointsToRedeem.value = 0;
    maxRedemptionAmount.value = 0;
    quoteId.value = '';
    selectedTopupAmount.value = '0';
    finalRechargeAmount.value = '0';
  }

  Future<void> proceedToRecharge() async {
    try {
      // Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request. Please Wait....', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      if (finalRechargeAmount.value == '0') {
        addCardBalanceWithZeroAmount(
            isRedemptinEligibile: isRedemptionEligibile.value,
            pointToRedeem: pointsToRedeem.value,
            quoteID: quoteId.value,
            finalRechargeAmount: finalRechargeAmount.value,
            isRedeemed: isRedeemed.value);
      } else {
        // await activepaymentGateWayController.getActivePaymentGateway();
        // if (activepaymentGateWayController.selectedPaymentGateWay.value ==
        //     PaymentGatewayIds.paytmId) {
        await paytmController.startPayment(
            amount: selectedTopupAmount.value,
            finalRechargeAmount: finalRechargeAmount.value,
            cardNum: cardDetailsByUser
                .first.cardDetails![carouselCurrentIndex.value].cardNo!,
            isRedemptionEligibile: isRedemptionEligibile.value,
            pointsToRedeem: pointsToRedeem.value,
            quoteId: quoteId.value,
            isRedeemed: isRedeemed.value);
        // }

        // else {
        //   TFullScreenLoader.stopLoading();
        //   TLoaders.errorSnackBar(
        //       title: 'Oh Snap!',
        //       message:
        //           'Payment Gateway selection error. Please try again later.');
        // }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //Fetch Card Details
  Future<void> fetchMetroCardDetailsByUser({callingfrom = 'fetch'}) async {
    try {
      isCardDetailsLoading.value = true;
      cardDetailsByUser.clear();
      final userId = await TLocalStorage().readData('uid') ?? '';
      final cardDetails =
          await _cardRepository.getMetroCardDetailsByUser(userId);
      if (cardDetails.returnCode == '0') {
        cardDetailsByUser.add(cardDetails);

        if (callingfrom == 'fetch' || callingfrom == 'delete') {
          validateNebulaCard(cardDetails.cardDetails![0].cardNo!,
              callingfrom: callingfrom);
          fetchCardTravelHistory(cardDetails.cardDetails![0].cardNo!);
          fetchCardTransactionDetails(cardDetails.cardDetails![0].cardNo!);
          fetchCardLastTrasactionStatus(cardDetails.cardDetails![0].cardNo!);
        } else if (callingfrom == 'add') {
          fetchCardTravelHistory(cardDetails.cardDetails![0].cardNo!,
              callingfrom: callingfrom);
          fetchCardTransactionDetails(cardDetails.cardDetails![0].cardNo!,
              callingfrom: callingfrom);
          fetchCardLastTrasactionStatus(cardDetails.cardDetails![0].cardNo!);
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isCardDetailsLoading.value = false;
    }
  }

  //Add or update card
  Future<void> addOrUpdateCardDetailsByUser(String type) async {
    try {
      final cardId = type == 'add'
          ? 0
          : cardDetailsByUser.first.cardDetails![carouselCurrentIndex.value].id;
      final cardNo = type == 'add'
          ? cardNumber.text
          : cardDetailsByUser
              .first.cardDetails![carouselCurrentIndex.value].cardNo;
      final cardDesc = cardHolderName.text;

      //Form Validation
      if (!cardAddOrUpdateFormKey.currentState!.validate()) {
        return;
      }

      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Validating. Please Wait....', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      if (type == 'add') {
        final cardValidationData =
            await validateNebulaCard(cardNo!, callingfrom: 'add');
        if (cardValidationData!.nebulaCardValidationStatus != '00') {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
              title: 'Error',
              message: cardValidationData.nebulaCardValidationMessage);
          return;
        } else {
          storeNebulaCardValidationDetails.insert(0, cardValidationData);
        }
      }

      final payload = {
        "id": cardId,
        "userID": await TLocalStorage().readData('uid') ?? '',
        "cardNo": cardNo,
        "cardDesc": cardDesc
      };
      final response =
          await _cardRepository.addOrUpdateCardDetailsByUser(payload);
      if (response.returnCode == '0') {
        TFullScreenLoader.stopLoading();
        //Removing Dialog
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success!',
          message: type == 'add'
              ? 'Card Details added succesfully'
              : 'Card Details updated succesfully',
        );

        //Fetching cards from server
        fetchMetroCardDetailsByUser(callingfrom: 'add');
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: type == 'add'
              ? 'Unable to add card Details.Please try again later!'
              : 'Unable to add card Details.Please try again later!',
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: type == 'add'
            ? 'Unable to add card Details.Please try again later!'
            : 'Unable to add card Details.Please try again later!',
      );
    }
  }

  //Add or update card
  Future<void> deleteCardDetailsByUser() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Validating. Please Wait....', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      final cardNo = cardDetailsByUser
          .first.cardDetails![carouselCurrentIndex.value].cardNo;

      final response = await _cardRepository.deleteCardDetailsByUser(
          await TLocalStorage().readData('uid') ?? '', cardNo);

      if (response.returnCode == '0') {
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success!',
          message: 'Card Details Deleted succesfully',
        );
        carouselCurrentIndex.value = 0;
        storeNebulaCardValidationDetails.clear();
        cardTravelHistoryList.clear();
        cardPaymentListData.clear();
        fetchMetroCardDetailsByUser(callingfrom: 'delete');
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Unable to Delete card details.Please try again later!',
        );
      }
      //Stop Loading
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<NebulaCardValidationModel?> validateNebulaCard(String cardNumber,
      {callingfrom = 'fetch'}) async {
    try {
      isNebulaCardValidating.value = true;

      // Generate required data
      String bankRequestDateTime =
          CardRechargeUtils.getBankRequestDateTimeForValidation();
      String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
          cardNumber, bankRequestDateTime);

      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNumber,
        "bankCode": CardRechargeUtils.bankCode,
        "bankReferenceNumber": bankRefNumber,
        'bankRequestDateTime': bankRequestDateTime,
        "topUpChannel": CardRechargeUtils.topUpChannel,
      };
      // Make the POST request

      final response = await _cardRepository.validateNebulaCard(payload);
      if (response.nebulaCardValidationStatus != '00') {
        throw response.nebulaCardValidationMessage!;
      }
      if (callingfrom == 'fetch') {
        storeNebulaCardValidationDetails.insert(
            carouselCurrentIndex.value, response);
      } else if (callingfrom == 'delete') {
        storeNebulaCardValidationDetails.insert(0, response);
      }
      return response;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to fetch Card validation details');
    } finally {
      isNebulaCardValidating.value = false;
    }
    return null;
  }

  Future<void> fetchCardLastTrasactionStatus(String cardNumber,
      {callingfrom = 'fetch'}) async {
    try {
      // Create the plain credentials
      isLastRcgStatusLoading.value = true;
      // Generate required data
      String bankRequestDateTime = CardRechargeUtils.getBankRequestDateTime();
      String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
          cardNumber, bankRequestDateTime);
      String bankCode = CardRechargeUtils.bankCode;

      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNumber,
        "bankCode": bankCode,
        "bankReferenceNumber": bankRefNumber,
      };

      // Make the POST request
      final response =
          await _cardRepository.getLastTransactionDetailsByCard(payload);

      if (callingfrom == 'fetch') {
        lastRcgStatusList.insert(carouselCurrentIndex.value, response);
      } else if (callingfrom == 'delete' || callingfrom == 'add') {
        lastRcgStatusList.insert(0, response);
      }
    } catch (e) {
      lastRcgStatusList.insert(carouselCurrentIndex.value,
          LastRechargeStatusModel(transactionCode: null));
      // TLoaders.errorSnackBar(
      //     title: 'Error', message: 'Failed to fetch last recharge status');
    } finally {
      isLastRcgStatusLoading.value = false;
    }
  }

  Future<void> fetchCardTransactionDetails(String cardNumber,
      {callingfrom = 'fetch'}) async {
    try {
      // Create the plain credentials
      isCardPaymentDataLoading.value = true;

      // Generate required data
      String bankCode = CardRechargeUtils.bankCode;

      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNumber,
        "bankCode": bankCode,
      };

      // Make the POST request
      final response = await _cardRepository.getCardTrxDetails(payload);

      if (callingfrom == 'fetch') {
        cardPaymentListData.insert(carouselCurrentIndex.value, response);
      } else if (callingfrom == 'delete' || callingfrom == 'add') {
        cardPaymentListData.insert(0, response);
      }
    } catch (e) {
      cardPaymentListData.insert(
          carouselCurrentIndex.value, CardTrxDetailsModel(response: []));
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isCardPaymentDataLoading.value = false;
    }
  }

  Future<void> fetchCardTravelHistory(String cardNumber,
      {callingfrom = 'fetch'}) async {
    try {
      isCardTravelHistoryLoading.value = true;
      // Generate required data
      String bankCode = CardRechargeUtils.bankCode;

      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNumber,
        "bankCode": bankCode,
      };

      final response = await _cardRepository.getCardTravelHistory(payload);

      if (callingfrom == 'fetch') {
        cardTravelHistoryList.insert(carouselCurrentIndex.value, response);
      } else if (callingfrom == 'delete' || callingfrom == 'add') {
        cardTravelHistoryList.insert(0, response);
      }
    } catch (e) {
      cardTravelHistoryList.insert(
          carouselCurrentIndex.value, CardTravelHistoryModel(response: []));
    } finally {
      isCardTravelHistoryLoading.value = false;
    }
  }

  Future<void> addCardBalanceWithZeroAmount(
      {int isRedemptinEligibile = 0,
      int pointToRedeem = 0,
      String quoteID = "",
      String finalRechargeAmount = "0",
      bool isRedeemed = false}) async {
    try {
      // Generate required data
      final cardNo = cardDetailsByUser
          .first.cardDetails![carouselCurrentIndex.value].cardNo!;
      String platformCode = TDeviceUtils.getPlatfromString();
      String bankCode = CardRechargeUtils.bankCode;
      String bankRequestDateTime = CardRechargeUtils.getBankRequestDateTime();
      String bankRefNumber =
          CardRechargeUtils.getBankReferenceNumber(cardNo, bankRequestDateTime);
      final userId = await TLocalStorage().readData('uid') ?? '';
      final firstName = await TLocalStorage().readData('firstName') ?? '';
      final lastName = await TLocalStorage().readData('lastName') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      final email = await TLocalStorage().readData('emailAddress') ?? '';

      final orderId =
          "RC$platformCode${phoneNumber.substring(6, 10)}${DateTime.now().millisecondsSinceEpoch}";
      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNo,
        "bankCode": bankCode,
        "bankReferenceNumber": bankRefNumber,
        "bankTransactionDateTime": bankRequestDateTime,
        "addValueAmount": selectedTopupAmount.value,
        "topUpChannel": CardRechargeUtils.topUpChannel,
        "metroOrderId": orderId,
        "userId": userId.toString(),
        "userName": '$firstName $lastName',
        "email": email,
        'phoneNumber': phoneNumber,
        "pgOrderId": "",
        "pgPaymentStatus": "",
        "pgPaymentMode": "",
        "trxResponseCode": "",
        "trxResponseMessage": "",
        "pgTxnDate": "",
      };
      //Posting data to Metro Server
      final response = await _cardRepository.addCardBalance(payload);

      if (response.bankReferenceNumber != null &&
          response.merchantTransactionID != null) {
        try {
          //--Redeem Points after payment success only.
          if (isRedemptinEligibile == 1) {
            final payload = {
              "points_to_redeem": pointToRedeem,
              "user_id": userId.toString(),
              "quote_id": quoteID,
            };

            final redeemPointsData =
                await _loyaltyPointsRepository.redeemPoints(payload);

            if (redeemPointsData.success == true) {
              TLoaders.successSnackBar(
                  title: 'Success!', message: redeemPointsData.message);
            } else {
              TLoaders.errorSnackBar(
                  title: 'Oh Snap!', message: redeemPointsData.message);
            }
          }
          //=============================================================================================

          final inquiryAfcresponse = await _cardRepository.inquiryAfc({
            "bankCode": CardRechargeUtils.bankCode,
            "bankReferenceNumber": response.bankReferenceNumber,
            "webAPIName": 'OPC_VALIDATE_TRX',
          });

          gotoPaymentProcessingScreen(
              isRechargeSuccess: true,
              orderID: orderId,
              addValueAmount: selectedTopupAmount.value,
              cardNO: cardNo,
              finalRedeemedAmount: finalRechargeAmount,
              isRedemptinEligibile: isRedemptinEligibile,
              isReedeemed: isRedeemed,
              pointToRedeem: pointToRedeem,
              quoteID: quoteID,
              date: THelperFunctions.getFormattedDateTimeString1(
                  inquiryAfcresponse.bankTransactionDateTime ??
                      THelperFunctions.getFormattedDateTime1(DateTime.now())));
        } catch (e) {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(title: 'Error', message: e.toString());
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Error',
            message: "bankReferenceNumber or merchantTransactionID not found");
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  gotoPaymentProcessingScreen(
      {isRechargeSuccess = true,
      message =
          'If any amount deducted will be refuned to your source account in 2-3 business days',
      date,
      orderID,
      addValueAmount,
      cardNO,
      isReedeemed,
      finalRedeemedAmount,
      isRedemptinEligibile,
      pointToRedeem,
      quoteID,
      retryRecharge = false}) {
    Get.delete<AmountsScrollController>();
    Get.delete<BottomSheetPageViewController>();
    Get.delete<CheckBoxController>();
    TFullScreenLoader.stopLoading();
    Get.offAll(
      () => PaymentProcessingScreen(
        isRechargeSuccess: isRechargeSuccess,
        orderId: orderID,
        amount: addValueAmount,
        cardNumber: cardNO,
        message: message,
        date: date ?? THelperFunctions.getFormattedDateTime1(DateTime.now()),
        retryRecharge: retryRecharge,
        pgOrderId: '',
        pgPaymentMode: '',
        pgPaymentStatus: '',
        isReedeemed: isReedeemed,
        finalRedeemedAmount: finalRedeemedAmount, //Total amount after reedem,
        isRedemptionEligibile: isRedemptinEligibile,
        pointsToRedeem: pointToRedeem,
        quoteId: quoteID,
      ),
    );
  }
}

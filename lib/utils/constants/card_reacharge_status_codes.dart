import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/models/recharge_status_codes_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class CardRechargeStatusCodes {
  static String requestSent = '82';
  static String requestSentFailed = '84';
  static String responseReceived = '83';
  static String rechargeInProgress1 = '71';
  static String rechargeInProgress2 = '72';
  static String rechargeInProgress3 = '73';
  static String pendingAtStation = '31';
  static String failureAtStation = '32';
  static String balanceAdded = '33';
  static String markedForRefund = '34';
  static String refundSuccess = '35';
  static String refundFailed = '36';

  static final watingForPaymentConfirmationStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Waiting\n For Payment Confirmation',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nIn Prgoress',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Pending Tap at\nEntry AG/TVM',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
  ];

  static final paymentFailedStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nSuspened',
      icon: Iconsax.close_circle,
      color: TColors.error,
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nIn Prgoress',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Pending Tap at\nEntry AG/TVM',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
  ];
  static final paymentSuccessStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nIn Prgoress',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Pending Tap at\nEntry AG/TVM',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
  ];

  static final rechageInProgressStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nIn Prgoress',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Pending Tap at\nEntry AG/TVM',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
  ];

  static final pendingAtStationStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Pending Tap at\nEntry AG/TVM',
      icon: Iconsax.info_circle,
      color: TColors.darkGrey,
    ),
  ];

  static final fialedAtStationStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Failed to\nAdd Balance',
      icon: Iconsax.close_circle,
      color: TColors.error,
    ),
  ];

  static final balanceAddedStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Recharge\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Balance\nAdded',
    ),
  ];

  static final markedForRefundStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Rechage\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Marked\nFor Refund',
    ),
  ];

  static final refundSuccessStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Rechage\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Refund\nSuccess',
    ),
  ];

  static final refundFailedStatus = [
    RechargeStatusCodesModel(
      statusInfo: 'Payment\nSucees',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Rechage\nSuccess',
    ),
    RechargeStatusCodesModel(
      statusInfo: 'Refund\nFailed',
      color: TColors.error,
      icon: Iconsax.close_circle,
    ),
  ];

  static getDescirption(String statusCode) {
    switch (statusCode) {
      case '71':
        return 'We have received your payment. Recharge is in progress.';
      case '72':
        return 'We have received your payment. Recharge is in progress.';
      case '73':
        return 'We have received your payment. Recharge is in progress.';
      case '33':
        return 'The balance is added on your smart card';
      case '31':
        return 'Please tap your card after 20 minutes to ensure the top-up amount reflects in your account.';
      //return 'We recommend you to travel after 20 mins from the time of recharge.';
      case '32':
        return 'Failed to add balance on your smart card. Please try again or contact customer care.';
      case '34':
        return 'You did not tap your card within 15 days from the date of recharge. It is now marked for refund.';
      default:
        return '';
    }
  }
}

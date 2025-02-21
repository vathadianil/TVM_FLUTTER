class ApiEndPoint {
  //Splash Image
  static String splashImageUrl =
      'https://s3.ap-south-1.amazonaws.com/files.tsavaari.com/splash/splash.png';

  ///Authentication
  static String getToken = "qr/getToken";
  static String login = "user/api/login/generateotp";
  static String registerUser = "user/userregister";
  static String verifyOTP = "user/api/verifyotp/";
  static String resendOTP = "user/api/resendotp";
  static String requestOtpProfileUpdate = "user/user/requestupdate/";
  static String updateUserInfo = "user/updateuserinfo/";
  static String getUserInfo = "user/getuser/";
  static String logout = "user/logout/";

  //Feedback
  static String postFeedback = "feedback";

  //App Rating
  static String appRating = "app/createapprating/";

  //Fetch Bannners
  static String getBannners = "tapp_banners/tapp/banners/";

  //Fetch Notifications
  static String getNotifications = "tapp/notifications/";

  //Book Qr
  static String getStations = "qr/getStations";
  static String getBusinessHours = 'qr/getBusinessOperationDateHour';
  static String getFare = 'qr/getTicketFare';
  static String createQrPaymentOrder = 'cfpg/cashfree/createOrder';
  static String verifyPayment = 'cfpg/cashfree/getOrder';
  static String generateTicket = 'qr/generateTicket';
  static String qrTicketPaymentFailed = 'qr/qrTicketPaymentFailed';
  static String changeDestTicketPaymentFailed =
      'qr/qrChangeDestTicketPaymentFailed';
  static String verifyGenerateTicket = 'qr/getOrderStatusByMerchantOrderId';
  static String refundPaymentIntimation = 'qr/RefundInitiatedByMerchant';
  static String getFareCalculation = 'db/fare_calculator?fromStation=';
  static String cashfreeWebhookUrl =
      'https://www.stage.tsavaari.com/cfpg/cashfree/webhook';

  ///Travel History
  static String getActiveTickets = 'qr/getActiveTickets';
  static String getPastTickets = 'qr/getExpiredTickets';
  static String getPaymentFailedAndRefundedTickets =
      'cfpg/getPaymentFailed_RefundDetailsByMobile';

  static String refundPreview = "qr/refunPreview";
  static String createRefundOrder = "cfpg/cashfree/refundOrder";
  static String refundOrderStatus = "cfpg/cashfree/getRefund";
  static String refundConfirm = "qr/refunConfirmed";

  static String changeDestinationPreview = "qr/changeDestinationPreview";
  static String changeDestinationConfirm = "qr/changeDestination";

  //Card Recharge
  static String activePaymentGateway = 'getActivePg';
  static String getCardDetailsByUser = 'db/get_card_details?userID=';
  static String addOrUpdateCardDetails = 'db/add_update_card';
  static String deleteCard = 'db/delete_card?USERID=';
  static String getLastRechargeStatus = 'card/NEBULACARD_TXN_STATUS';
  static String validateNebulaCardUrl = 'card/VALIDATE_NEBULACARD';
  static String getCardTrxDetails = 'card/NEBULACARD_TXN_DETAIL';
  static String getCardTravelHistory = 'card/NEBULACARD_TRAVEL_HISTORY';
  static String addCardBalance = 'card/OPC_VALIDATE_TRX';
  static String inquiryAfc = 'card/Inquiry_AFC';
  static String generatePayUHash = "payupg/initiate-payment";
  static String cardRechargeAmounts = "card/card_rch_amounts";

  //Paytm
  static String initiatePaytmPayment = 'psplpg/ppsl/initiateTransaction';
  static String getPaytmPaymentStatus = 'psplpg/ppsl/order/status';
  static String refundPaytmPayment = 'psplpg/ppsl/refund';
  static String paytmPaymentFailedData = 'psplpg/insertPpslPgPaymentTxns';

  ///Station Facilities
  static String getStationsWithCoords = 'db/get_station_lang_lat';
  static String getStationFacilitiesServices =
      'db/get_station_facilities?stationID=';

  ///Loyalty Points
  static String getUserPointsSummary = 'lp/getUserPointsSummary?userID=';
  static String checkRedemptionEligibility = 'lp/checkRedemptionEligibility';
  static String redeemPoints = 'lp/redeemPoints';
  static String getLoyaltyPointsHistory = 'lp/loyaltyPointsHistory';

  //Hyd Metro Website Url
  static String hydMetroWebsiteUrl = 'https://www.ltmetro.com/penalty-charter/';
  static String linkedInUrl =
      'https://www.linkedin.com/company-beta/2220162/?pathWildcard=2220162';
  static String facebookUrl = 'https://www.facebook.com/ltmhyd/';
  static String twitterUrl = 'https://twitter.com/ltmhyd';
  //static String blogUrl = 'http://lnthydmetrorail.blogspot.com/';
  static String youtubeUrl = 'https://www.youtube.com/user/ltmetrorailhyd';
  // static String googlePlusUrl =
  //     'https://plus.google.com/+LTMetroRailHyderabadLimited';
  static String instagramUrl = 'https://www.instagram.com/lthydmetrorail/';
}

class PaymentModes {
  static const String cc = 'CC';
  static const String dc = 'DC';
  static const String nb = 'NB';
  static const String upi = 'UPI';
  static const String wallet = 'WALLET';
  static const String emi = 'EMI';

  static String getPaymentMode(String paymentMode) {
    switch (paymentMode) {
      case cc:
        return 'Credit Card';
      case dc:
        return 'Debit Card';
      case nb:
        return 'Net Banking';
      case upi:
        return 'UPI';
      case wallet:
        return 'Wallet';
      case emi:
        return 'EMI';
      default:
        return paymentMode;
    }
  }
}

class PayUSuccessResponseModel {
  String? id;
  String? mode;
  String? status;
  String? unmappedstatus;
  String? key;
  String? txnid;
  String? transactionFee;
  String? amount;
  String? discount;
  String? addedon;
  String? productinfo;
  String? firstname;
  String? email;
  String? phone;
  String? hash;
  String? field9;
  String? paymentSource;
  String? pGTYPE;
  String? bankRefNo;
  String? ibiboCode;
  String? errorCode;
  String? errorMessage;
  String? isSeamless;
  String? surl;
  String? furl;

  PayUSuccessResponseModel(
      {this.id,
      this.mode,
      this.status,
      this.unmappedstatus,
      this.key,
      this.txnid,
      this.transactionFee,
      this.amount,
      this.discount,
      this.addedon,
      this.productinfo,
      this.firstname,
      this.email,
      this.phone,
      this.hash,
      this.field9,
      this.paymentSource,
      this.pGTYPE,
      this.bankRefNo,
      this.ibiboCode,
      this.errorCode,
      this.errorMessage,
      this.isSeamless,
      this.surl,
      this.furl});

  static PayUSuccessResponseModel empty() => PayUSuccessResponseModel(
        id: '',
        mode: '',
        status: '',
        unmappedstatus: '',
        key: '',
        txnid: '',
        transactionFee: '',
        amount: '',
        discount: '',
        addedon: '',
        productinfo: '',
        firstname: '',
        email: '',
        phone: '',
        hash: '',
        field9: '',
        paymentSource: '',
        pGTYPE: '',
        bankRefNo: '',
        ibiboCode: '',
        errorCode: '',
        errorMessage: '',
        isSeamless: '',
        surl: '',
        furl: '',
      );

  PayUSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    mode = json['mode'];
    status = json['status'];
    unmappedstatus = json['unmappedstatus'];
    key = json['key'];
    txnid = json['txnid'];
    transactionFee = json['transaction_fee'];
    amount = json['amount'];
    discount = json['discount'];
    addedon = json['addedon'];
    productinfo = json['productinfo'];
    firstname = json['firstname'];
    email = json['email'];
    phone = json['phone'];
    hash = json['hash'];
    field9 = json['field9'];
    paymentSource = json['payment_source'];
    pGTYPE = json['PG_TYPE'];
    bankRefNo = json['bank_ref_no'];
    ibiboCode = json['ibibo_code'];
    errorCode = json['error_code'];
    errorMessage = json['Error_Message'];
    isSeamless = json['is_seamless'].toString();
    surl = json['surl'];
    furl = json['furl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mode'] = mode;
    data['status'] = status;
    data['unmappedstatus'] = unmappedstatus;
    data['key'] = key;
    data['txnid'] = txnid;
    data['transaction_fee'] = transactionFee;
    data['amount'] = amount;
    data['discount'] = discount;
    data['addedon'] = addedon;
    data['productinfo'] = productinfo;
    data['firstname'] = firstname;
    data['email'] = email;
    data['phone'] = phone;
    data['hash'] = hash;
    data['field9'] = field9;
    data['payment_source'] = paymentSource;
    data['PG_TYPE'] = pGTYPE;
    data['bank_ref_no'] = bankRefNo;
    data['ibibo_code'] = ibiboCode;
    data['error_code'] = errorCode;
    data['Error_Message'] = errorMessage;
    data['is_seamless'] = isSeamless;
    data['surl'] = surl;
    data['furl'] = furl;
    return data;
  }
}

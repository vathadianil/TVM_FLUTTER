class CardRechargeAmountsModel {
  List<int>? amounts;

  CardRechargeAmountsModel({this.amounts});

  CardRechargeAmountsModel.fromJson(Map<String, dynamic> json) {
    amounts = json['amounts'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amounts'] = amounts;
    return data;
  }
}

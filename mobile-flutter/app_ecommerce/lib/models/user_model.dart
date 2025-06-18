class UserInfo {
  String phoneNumber;
  String identification;
  String deliveryAddress;
  String? addressComplement;
  String? deliveryInstructions;
  String paymentMethod;

  UserInfo({
    required this.phoneNumber,
    required this.identification,
    required this.deliveryAddress,
    this.addressComplement,
    this.deliveryInstructions,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'identification': identification,
    'deliveryAddress': deliveryAddress,
    'addressComplement': addressComplement,
    'deliveryInstructions': deliveryInstructions,
    'paymentMethod': paymentMethod,
  };

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    phoneNumber: json['phoneNumber'],
    identification: json['identification'],
    deliveryAddress: json['deliveryAddress'],
    addressComplement: json['addressComplement'],
    deliveryInstructions: json['deliveryInstructions'],
    paymentMethod: json['paymentMethod'],
  );
}

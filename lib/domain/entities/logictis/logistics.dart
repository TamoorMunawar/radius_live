import 'dart:convert';

class BuyAssetHistory {
  final int id;
  final int quantity;
  final String price;
  final String totalAmount;
  final int userId;
  final String userName;
  final int assetId;
  final String assetName;
  final String? assetType;
  final String serialNumber;
  final String assetDescription;
  final String createdAt;

  BuyAssetHistory({
    required this.id,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    required this.userId,
    required this.userName,
    required this.assetId,
    required this.assetName,
    this.assetType,
    required this.serialNumber,
    required this.assetDescription,
    required this.createdAt,
  });

  factory BuyAssetHistory.fromJson(Map<String, dynamic> json) {
    return BuyAssetHistory(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'],
      totalAmount: json['total_amount'],
      userId: json['user_id'],
      userName: json['user_name'],
      assetId: json['asset_id'],
      assetName: json['asset_name'],
      assetType: json['asset_type'],
      serialNumber: json['serial_number'],
      assetDescription: json['asset_description'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'total_amount': totalAmount,
      'user_id': userId,
      'user_name': userName,
      'asset_id': assetId,
      'asset_name': assetName,
      'asset_type': assetType,
      'serial_number': serialNumber,
      'asset_description': assetDescription,
      'created_at': createdAt,
    };
  }
}

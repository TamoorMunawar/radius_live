class BuyAssetHistory {
  bool? success;
  List<Data>? data;

  BuyAssetHistory({this.success, this.data});

  BuyAssetHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var id;
  var eventModelId;
  var assetId;
  var price;
  var totalPrice;
  Null? expectedReturnDate;
  var quantity;
  var returnQty;
  Null? returnDate;
  var extraCharges;
  Null? condition;
  var createdAt;
  var updatedAt;
  var userId;
  Asset? asset;

  Data(
      {this.id,
        this.eventModelId,
        this.assetId,
        this.price,
        this.totalPrice,
        this.expectedReturnDate,
        this.quantity,
        this.returnQty,
        this.returnDate,
        this.extraCharges,
        this.condition,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.asset});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    assetId = json['asset_id'];
    price = json['price'];
    totalPrice = json['total_price'];
    expectedReturnDate = json['expected_return_date'];
    quantity = json['quantity'];
    returnQty = json['return_qty'];
    returnDate = json['return_date'];
    extraCharges = json['extra_charges'];
    condition = json['condition'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    asset = json['asset'] != null ? new Asset.fromJson(json['asset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_model_id'] = this.eventModelId;
    data['asset_id'] = this.assetId;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['expected_return_date'] = this.expectedReturnDate;
    data['quantity'] = this.quantity;
    data['return_qty'] = this.returnQty;
    data['return_date'] = this.returnDate;
    data['extra_charges'] = this.extraCharges;
    data['condition'] = this.condition;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.asset != null) {
      data['asset'] = this.asset!.toJson();
    }
    return data;
  }
}

class Asset {
  var id;
  var name;
  var assetTypeId;
  var serialNumber;
  Null? image;
  var description;
  var status;
  var value;
  Null? location;
  var addedBy;
  var lastUpdatedBy;
  var imageUrl;

  Asset(
      {this.id,
        this.name,
        this.assetTypeId,
        this.serialNumber,
        this.image,
        this.description,
        this.status,
        this.value,
        this.location,
        this.addedBy,
        this.lastUpdatedBy,
        this.imageUrl});

  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    assetTypeId = json['asset_type_id'];
    serialNumber = json['serial_number'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    value = json['value'];
    location = json['location'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['asset_type_id'] = this.assetTypeId;
    data['serial_number'] = this.serialNumber;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['value'] = this.value;
    data['location'] = this.location;
    data['added_by'] = this.addedBy;
    data['last_updated_by'] = this.lastUpdatedBy;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

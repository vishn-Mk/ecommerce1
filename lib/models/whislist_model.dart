import 'package:ecommerce/models/product_model.dart';

class WishModel {
  String? sId; // ID of the wishlist item
  ProductModel? productId; // Associated product
  String? userId; // ID of the user who created the wishlist item
  int? iV; // Internal versioning field, if used

  // Constructor
  WishModel({this.sId, this.productId, this.userId, this.iV});

  // Create a WishModel instance from a JSON map
  WishModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? ProductModel.fromJson(json['productId'])
        : null;
    userId = json['userId'];
    iV = json['__v'];
  }

  // Convert a WishModel instance to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    return data;
  }
}

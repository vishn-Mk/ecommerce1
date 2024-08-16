class ProductModel {
  String title="";
  String? description;
  int price=0;
  String? image;
  String? review;
  String? category;
  String? rate;
  String? seller;
  int quantity=0;
  String? sId;
  int? iV;

  ProductModel(
      {required this.title,
        this.description,
        required this.price,
        this.image,
        this.review,
        this.category,
        this.rate,
        this.seller,
        required this.quantity,
        this.sId,
        this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    review = json['review'];
    category = json['category'];
     rate = json['rate'].toString();
    quantity = int.parse(json['quantity']);
    sId = json['_id'];
     iV = json['__v'];
  }







  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['review'] = this.review;
    data['category'] = this.category;
    data['rate'] = this.rate;
    data['quantity'] = this.quantity;
    // data['_id'] = this.sId;
    // data['__v'] = this.iV;
    return data;
  }
}
class OrderModel {
  String username;
  String address;
  String phone;
  String productname;
  String image;
  String count;
  String price;
  String dateorder;

  OrderModel(
      {this.username,
        this.address,
        this.phone,
        this.productname,
        this.image,
        this.count,
        this.price,
        this.dateorder
        });

  OrderModel.fromJson(Map json)
      : username = json['user_name'],
        address = json['address'],
        phone = json['phone'],
        productname = json['product_name'],
        image = json['image'],
        count = json['count'],
        price = json['price'],
        dateorder = json['date_order'];

  Map toJson() {
    return {
      'username': username,
      'address': address,
      'phone': phone,
      'productname': productname,
      'image': image,
      'count': count,
      'price': price,
      'dateorder':dateorder
    };
  }
}
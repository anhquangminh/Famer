class Product {
  String idproduct;
  String iduser;
  String productname;
  String idgroup;
  String price;
  String sum;
  String sale;
  String discription;
  String image;
  String dateadd;

  Product(
      {this.idproduct,
        this.iduser,
        this.productname,
        this.idgroup,
        this.price,
        this.sum,
        this.sale,
        this.discription,
        this.image,
        this.dateadd});

  Product.fromJson(Map json)
      : idproduct = json['id_product'],
        iduser = json['id_user'],
        productname = json['product_name'],
        idgroup = json['id_group'],
        price = json['price'],
        sum = json['sum'],
        sale = json['sale'],
        discription = json['description'],
        image = json['image'],
        dateadd = json['date_add'];

  Map toJson() {
    return {
      'idproduct': idproduct,
      'iduser': iduser,
      'productname': productname,
      'idgroup': idgroup,
      'price': price,
      'sum': sum,
      'sale': sale,
      'discription': discription,
      'image': image,
      'dateadd': dateadd,
    };
  }
}

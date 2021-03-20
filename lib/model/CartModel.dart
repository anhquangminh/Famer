class CartModel {
  String idcart;
  String iduser;
  String idproduct;
  String count;
  String datesale;
  String productname;
  String idgroup;
  String price;
  String sum;
  String discription;
  String image;
  String dateadd;

  CartModel(
      {this.idcart,
        this.iduser,
        this.idproduct,
        this.count,
        this.datesale,
        this.productname,
        this.idgroup,
        this.price,
        this.sum,
        this.discription,
        this.image,
        this.dateadd});

  CartModel.fromJson(Map json)
      : idcart=json['id_cart'],
        iduser = json['id_user'],
        idproduct = json['id_product'],
        count = json['count'],
        datesale = json['date_sale'],
        productname = json['product_name'],
        idgroup = json['id_group'],
        price = json['price'],
        sum = json['sum'],
        discription = json['description'],
        image = json['image'],
        dateadd = json['date_add'];

  Map toJson() {
    return {
      'idcart':idcart,
      'iduser': iduser,
      'idproduct': idproduct,
      'count':count,
      'datesale':datesale,
      'productname': productname,
      'idgroup': idgroup,
      'price': price,
      'sum': sum,
      'discription': discription,
      'image': image,
      'dateadd': dateadd,
    };
  }
}
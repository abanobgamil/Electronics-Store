class CartModel
{

  List<ProductModel>  cartProducts = [];
  dynamic sumOfCart = 0 ;

  CartModel.fromJson(List<dynamic> json)
  {
    json.forEach((element)
    {
      if(element["inCart"])
        {
          cartProducts.add(ProductModel.fromJson(element));
          sumOfCart += ProductModel.fromJson(element).sumOfProduct;
        }
    });
  }

}



class ProductModel
{
  late int id;
  String ? name;
  String ? category;
  String ? subCategory;
  String ? processor;
  String ? videoCard;
  String ? ram;
  String ? hardDisk;
  String ? display;
  String ? image;
  dynamic  price;
  dynamic oldPrice;
  dynamic discount;
  bool ? inFavourite ;
  late dynamic numOfOrder;
  late dynamic sumOfProduct;

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    category=json['category'];
    subCategory=json['subCategory'];
    processor=json['processor'];
    videoCard=json['videoCard'];
    ram=json['ram'];
    hardDisk=json['hardDisk'];
    display=json['display'];
    image=json['image'];
    price=json['price'];
    oldPrice=json['oldPrice'];
    discount=json['discount'];
    inFavourite=json['inFavourite'];
    numOfOrder=json['numOfOrder'];
    sumOfProduct = price * numOfOrder ;
  }

}
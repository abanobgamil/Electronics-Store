class FavoritesModel
{

  List<ProductModel>  favouriteProducts = [];

  FavoritesModel.fromJson(List<dynamic> json)
  {
    json.forEach((element)
    {
      if(element["inFavourite"])
        {
          favouriteProducts.add(ProductModel.fromJson(element));
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
  bool ? inCart;


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
    inCart=json['inCart'];

  }

}
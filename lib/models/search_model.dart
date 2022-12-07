class SearchModel
{

  List<ProductModel>  foundProducts = [];


  SearchModel.fromJson(List<dynamic> json)
  {

    json.forEach((element)
    {

      foundProducts.add(ProductModel.fromJson(element));

    });


  }

}


class ProductModel
{
  late int id;
  String ? name;
  String ? category;
  String ? subCategory;
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
    image=json['image'];
    price=json['price'];
    oldPrice=json['oldPrice'];
    discount=json['discount'];
    inFavourite=json['inFavourite'];
    inCart=json['inCart'];

  }

}
class DecreaseAmountOfProduct
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
  bool inCart = true;
  int ? numOfOrder;

  DecreaseAmountOfProduct.fromJson(Map<String,dynamic> json)
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
    numOfOrder=json['numOfOrder'];
  }


  Map<String,dynamic> toMap()
  {
    return {
      'id' : id,
      'name' : name,
      'category' : category,
      'subCategory' : subCategory,
      'image' : image,
      'price' : price,
      'oldPrice' : oldPrice,
      'discount' : discount,
      'inFavourite' : inFavourite,
      'inCart' : inCart,
      'numOfOrder' : numOfOrder! - 1 ,

    };

  }


}
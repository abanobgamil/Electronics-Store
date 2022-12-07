class ChangeFavoriteModel
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
  int ? numOfOrder;


  ChangeFavoriteModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    category=json['category'];
    subCategory=json['subCategory'];
    image=json['image'];
    price=json['price'];
    oldPrice=json['oldPrice'];
    discount=json['discount'];
    inFavourite=(json['inFavourite'])? false : true;
    inCart=json['inCart'];

    if(inCart!)
      {
        numOfOrder = json['numOfOrder'];
      }

  }


  Map<String,dynamic> toMap()
  {
    if(inCart!)
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
        'numOfOrder' : numOfOrder,
      };
    }else
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
        };
      }



  }


}
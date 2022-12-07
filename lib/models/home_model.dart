class HomeModel
{

  List<BannerModel>  banners = [];
  List<ProductModel>  phoneProducts = [];
  List<ProductModel>  laptopProducts = [];
  List<ProductModel>  keyboardProducts = [];
  List<ProductModel>  mouseProducts = [];


  HomeModel.fromJson(Map<String,dynamic> json)
  {

    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });


     json['products'].forEach((element)
     {
       if(element["oldPrice"]!=element["price"]&&element["category"]=="Laptops")
         {
           laptopProducts.add(ProductModel.fromJson(element));
         }

       if(element["oldPrice"]!=element["price"]&&element["category"]=="Phones")
         {
           phoneProducts.add(ProductModel.fromJson(element));
         }

       if(element["oldPrice"]!=element["price"]&&element["subCategory"]=="Keyboard")
         {
           keyboardProducts.add(ProductModel.fromJson(element));
         }

       if(element["oldPrice"]!=element["price"]&&element["subCategory"]=="Mouse")
         {
           mouseProducts.add(ProductModel.fromJson(element));
         }

     });

  }

}


class BannerModel
{
  late int id;
  String ? image;

  BannerModel.fromJson(Map<String,dynamic> json)
  {
      id=json['id'];
      image=json['image'];
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
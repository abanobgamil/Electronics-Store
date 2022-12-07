
class CategoriesModel
{
  List<DataModel> category = [];

  CategoriesModel.fromJson(List<dynamic> json)
  {
    json.forEach((element) {

      category.add(DataModel.fromJson(element));
    });
  }

}


class DataModel
{

  late int id;
  late String categoryName;
  List<SubCatModel> subCats = [];

  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    categoryName = json['name'];

    json['subCategories'].forEach((element){
      subCats.add(SubCatModel.fromJson(element));
    });
  }

}


class SubCatModel
{
  String ? subCategoryName ;
  String ? img;

  SubCatModel.fromJson(Map<String,dynamic> json)
  {
    subCategoryName = json['name'];
    img = json['img'];
  }


}
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/models/add_to_cart_model.dart';
import 'package:electronics_store/models/cart_model.dart';
import 'package:electronics_store/models/category_model.dart';
import 'package:electronics_store/models/change_favorites_model.dart';
import 'package:electronics_store/models/decrease_amount_of_product.dart';
import 'package:electronics_store/models/delete_cart.dart';
import 'package:electronics_store/models/favourite_model.dart';
import 'package:electronics_store/models/home_model.dart';
import 'package:electronics_store/models/category_product_model.dart';
import 'package:electronics_store/models/increase_amount_of_product.dart';
import 'package:electronics_store/models/search_model.dart';
import 'package:electronics_store/modules/category/category_screen.dart';
import 'package:electronics_store/modules/favorites/favorites_screen.dart';
import 'package:electronics_store/modules/home/home_screen.dart';
import 'package:electronics_store/modules/products/products_screen.dart';
import 'package:electronics_store/modules/settings/settings_screen.dart';
import 'package:electronics_store/shared/component/widgets.dart';
import 'package:electronics_store/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }



  HomeModel? homeModel;
  Map<int, bool> homeFavourites = {};
  ChangeFavoriteModel? changeFavouriteModel;

  void getHomeModel() {
     emit(AppLoadingHomeDataState());

    DioHelper.getData(
      url: "db",
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.phoneProducts.forEach((element) {
        homeFavourites.addAll({element.id: element.inFavourite!});
      });

      homeModel!.laptopProducts.forEach((element) {
        homeFavourites.addAll({element.id: element.inFavourite!});
      });

      homeModel!.keyboardProducts.forEach((element) {
        homeFavourites.addAll({element.id: element.inFavourite!});
      });

      homeModel!.mouseProducts.forEach((element) {
        homeFavourites.addAll({element.id: element.inFavourite!});
      });

      emit(AppSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorHomeDataState());
    });
  }

  void changeHomeFavorites(int productId) {
    homeFavourites[productId] = !homeFavourites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId", data: changeFavouriteModel!.toMap())
          .catchError((onError) {
        print(onError.toString());
      });
      emit(AppSuccessChangeFavoritesState());
    }).then((value) {
      getFavoritesModel();
      getCart();
    });
  }


  CategoriesModel? categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(
      url: "category",
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppGetCategoryState());
    });
  }



  bool visible = false;
  int? categoryIndex;

  void chooseCategory(int index) {
    visible = true;
    categoryIndex = index;
    emit(AppGetCategoryState());
  }

  void chooseSubCategory(
      {required String cat, required String subCat, required context}) {
    getCategoryProducts(cat, subCat);
    navigateTo(context,ProductsScreen(subCat));
  }



  CategoryProductModel? categoryProductModel;
  Map<int, bool> categoryFavourites = {};

  void getCategoryProducts(String category, String subcategory) {

    DioHelper.getData(
            url: "products",
            query: {"category": category, "subCategory": subcategory})
        .then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      categoryProductModel!.products.forEach((element) {
        categoryFavourites.addAll({element.id: element.inFavourite!});
      });
      emit(AppSuccessCategoriesDataState());
    });
  }

  void changeCategoryFavorites(int productId) {
    categoryFavourites[productId] = !categoryFavourites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId", data: changeFavouriteModel!.toMap())
          .catchError((onError) {
        print(onError.toString());
      });
      emit(AppSuccessChangeFavoritesState());
    }).then((value){
      getHomeModel();
      getFavoritesModel();
      getCart();
    });
  }



  FavoritesModel? favoritesModel;
  Map<int, bool> favourites = {};

  void getFavoritesModel() {
    emit(AppLoadingGetFavoritesDataState());

    DioHelper.getData(
      url: "products",
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesModel!.favouriteProducts.forEach((element) {
        favourites.addAll({element.id: element.inFavourite!});
      });
      emit(AppSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetFavoritesDataState());
    });
  }

  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId", data: changeFavouriteModel!.toMap())
          .catchError((onError) {
        print(onError.toString());
      }).then((value) {
        getFavoritesModel();
        getHomeModel();
        getCart();
      });
      emit(AppSuccessChangeFavoritesState());
    });
  }



  AddToCartModel ? addToCartModel;

  void addToCart(int productId) {
    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      addToCartModel = AddToCartModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId",
          data: addToCartModel!.toMap(),
      ).catchError((onError){
        print(onError.toString());
      });
    }).then((value) {
      Fluttertoast.showToast(
        msg: "Added To Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      getCart();
    });

  }

  IncreaseAmountOfProduct ? increaseAmountOfProduct;

  void increaseOfProduct(int productId) {
    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      increaseAmountOfProduct = IncreaseAmountOfProduct.fromJson(value.data);
      DioHelper.putData(
        url: "products/$productId",
        data: increaseAmountOfProduct!.toMap(),
      ).catchError((onError){
        print(onError.toString());
      }).then((value) {
        getCart();
      });
    });

  }

  DecreaseAmountOfProduct ? decreaseAmountOfProduct;

  void decreaseOfProduct(int productId) {
    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      decreaseAmountOfProduct = DecreaseAmountOfProduct.fromJson(value.data);
      DioHelper.putData(
        url: "products/$productId",
        data: decreaseAmountOfProduct!.toMap(),
      ).catchError((onError){
        print(onError.toString());
      }).then((value) {
        getCart();
      });
    });

  }

  DeleteCart ? deleteCart;

  void deleteFromCart(int productId) {
    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      deleteCart = DeleteCart.fromJson(value.data);
      DioHelper.putData(
        url: "products/$productId",
        data: deleteCart!.toMap(),
      ).catchError((onError){
        print(onError.toString());
      }).then((value) {
        getCart();
      });
    });

  }

  CartModel ? cartModel;
  Map<int, bool> cartFavourites = {};

  void getCart()
  {
    DioHelper.getData(
      url: "products",
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      cartModel!.cartProducts.forEach((element) {
        cartFavourites.addAll({element.id: element.inFavourite!});
      });
      emit(AppGetCartProductsState());
    });
  }

  void changeCartFavorites(int productId) {
    cartFavourites[productId] = !cartFavourites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId",
          data: changeFavouriteModel!.toMap())
          .catchError((onError) {
        print(onError.toString());
      }).then((value) {
        getFavoritesModel();
        getHomeModel();
      });
      emit(AppSuccessChangeFavoritesState());
    });
  }



  SearchModel ? searchModel;
  Map<int, bool> searchFavourites = {};

  void search (String text)
  {
    emit(SearchLoadingState());
    DioHelper.getData(
        url: 'products',
        query: {
          'name_like':text,
        }
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      searchModel!.foundProducts.forEach((element) {
        searchFavourites.addAll({element.id: element.inFavourite!});
      });
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });

  }

  void changeSearchFavorites(int productId) {
    searchFavourites[productId] = !searchFavourites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.getData(
      url: "products/$productId",
    ).then((value) {
      changeFavouriteModel = ChangeFavoriteModel.fromJson(value.data);
      DioHelper.putData(
          url: "products/$productId",
          data: changeFavouriteModel!.toMap())
          .catchError((onError) {
        print(onError.toString());
      }).then((value) {
        getFavoritesModel();
        getHomeModel();
        getCart();
      });
      emit(AppSuccessChangeFavoritesState());
    });
  }

}


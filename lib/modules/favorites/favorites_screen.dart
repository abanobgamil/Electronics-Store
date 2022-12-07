import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: AppCubit.get(context).favoritesModel != null,
          builder: (context)=> productBuilder(AppCubit.get(context).favoritesModel!,context),
          fallback: (context)=>  Center(child: CircularProgressIndicator(
            color: HexColor("2B4F60"),
          )),
        );
      },

    );
  }

  Widget productBuilder(FavoritesModel  model, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1 / 1.65,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    model.favouriteProducts.length,
                        (index) =>
                        buildGridProduct(model.favouriteProducts[index], context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
    width: 145,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:  Container(
                width: double.infinity,
                height: 150.0,
                child: CachedNetworkImage(
                  imageUrl: model.image!,
                ),
              ),
            ),
            if (model.oldPrice != model.price)
              Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'Sale',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 37,
                  child: Text(model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    const Text("EGP", style: TextStyle(fontSize: 11)),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .changeFavorites(model.id);
                      },
                      icon: AppCubit.get(context)
                          .favourites[model.id]!
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : const Icon(
                        Icons.favorite_border_outlined,
                      ),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                Row(
                  children: [
                    model.oldPrice != model.price
                        ? Text(
                      '${model.oldPrice!.round()}',
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : const SizedBox(
                      height: 13,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context).addToCart(model.id);

                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor("2B4F60"),
                      ),
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: HexColor("E5E3D7"),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );



}

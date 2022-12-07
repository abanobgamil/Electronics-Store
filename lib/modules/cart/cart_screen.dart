import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/models/cart_model.dart';
import 'package:electronics_store/shared/component/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Cart",
        ),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: AppCubit.get(context).cartModel != null,
            builder: (context) => productBuilder(AppCubit.get(context).cartModel!,context),
            fallback: (context) =>
                Center(child: CircularProgressIndicator(
                  color: HexColor("2B4F60"),
                )),
          );
        },
      ),
    );
  }


  Widget productBuilder(CartModel model, context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=> buildListProduct(model.cartProducts[index],context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount: AppCubit.get(context).cartModel!.cartProducts.length,
              shrinkWrap: true,
            ),
          const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      MaterialButton(
        onPressed:(){},
        color: HexColor("2B4F60"),
        minWidth: 275,
        height: 40,
        child: Text(
            "CHECKOUT  ( ${model.sumOfCart} EGP )",
          style: TextStyle(
            color: HexColor(
                "E5E3D7"
            )
          ),
        ),
      )
    ],
  );

  Widget buildListProduct(ProductModel model, context, {bool isOldPrice = true}) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                child: CachedNetworkImage(
                  imageUrl: model.image!,
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
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeCartFavorites(model.id);
                      },
                      icon: AppCubit.get(context).cartFavourites[model.id]!
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : const Icon(
                        Icons.favorite_border_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    if (model.oldPrice != model.price)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "SubTotal:",
                      style:  TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.sumOfProduct}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          AppCubit.get(context).deleteFromCart(model.id);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: IconButton(
                              onPressed:(){
                                if(model.numOfOrder!=1)
                                  {
                                    AppCubit.get(context).decreaseOfProduct(model.id);
                                  }
                              },
                              icon: const Icon(
                                Icons.remove
                              ),
                              constraints: const BoxConstraints(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${model.numOfOrder}',
                          style:const TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: IconButton(
                            onPressed:(){
                              AppCubit.get(context).increaseOfProduct(model.id);
                            },
                            icon: const Icon(
                                Icons.add
                            ),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );



}

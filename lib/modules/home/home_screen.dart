import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel!= null,
          builder: (context) => productBuilder(
              AppCubit.get(context).homeModel!,
              context),
          fallback: (context) =>  Center(child: CircularProgressIndicator(
            color: HexColor("2B4F60"),
          )),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.banners
                  .map((e) => Image(
                image:CachedNetworkImageProvider(
                    '${e.image}'
                ),
                width: double.infinity,
                fit: BoxFit.fill,
              ))
                  .toList(),
              options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    'Phone Deals',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0,)
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 300.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildGridProduct(model.phoneProducts[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount:model.phoneProducts.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Laptop Deals',
                    style:  TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0)
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 300,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildGridProduct(model.laptopProducts[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount:model.laptopProducts.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Keyboard Deals',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 300,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildGridProduct(model.keyboardProducts[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount:model.keyboardProducts.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Mouse Deals',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 300,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildGridProduct(model.mouseProducts[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount:model.mouseProducts.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
    width: 145,
    decoration: BoxDecoration(
      border: Border.all(
          color: Colors.grey
      ),
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
              child: Container(
                width: double.infinity,
                height: 150.0,
                child: CachedNetworkImage(
                    imageUrl: model.image!,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Image(
            //     image: NetworkImage(
            //       model.image!,
            //     ),
            //     width: double.infinity,
            //     height: 150.0,
            //   ),
            // ),
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
                  child: Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                    )
                  ),
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
                    const Text(
                        "EGP",
                        style: TextStyle(
                            fontSize: 11
                        )),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeHomeFavorites(model.id);
                      },
                      icon:AppCubit.get(context).homeFavourites[model.id]!
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
                  children:  [
                      Text(
                        '${model.oldPrice!.round()}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                        ),
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
                    onTap: (){
                      AppCubit.get(context).addToCart(model.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor("2B4F60"),
                      ),
                      child:  Text(
                        "Add To Cart",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: HexColor(
                                "E5E3D7"
                            ),
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

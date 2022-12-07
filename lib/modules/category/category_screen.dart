import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Row(
          children: [
            Container(
              width: 130,
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => categoryItem(
                        model: cubit.categoriesModel!.category[index],
                        index: index,
                        context: context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 3,
                    ),
                    itemCount: cubit.categoriesModel!.category.length,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ConditionalBuilder(
              condition: cubit.visible,
              builder: (context) => Expanded(
                child: Column(
                  children: [
                    Visibility(
                      visible: cubit.visible,
                      child: Container(
                        color: Colors.white,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: 1 / 1.6,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            cubit.categoriesModel!
                                .category[cubit.categoryIndex!].subCats.length,
                            (index) => subCategoryItem(
                                cat: cubit
                                    .categoriesModel!
                                    .category[cubit.categoryIndex!]
                                    .categoryName,
                                subCat: cubit
                                    .categoriesModel!
                                    .category[cubit.categoryIndex!]
                                    .subCats[index].subCategoryName!,
                                image:  cubit
                                    .categoriesModel!
                                    .category[cubit.categoryIndex!]
                                    .subCats[index].img!,
                                context: context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Column(),
            )
          ],
        );
      },
    );
  }

  Widget categoryItem(
      {required DataModel model, required int index, required context}) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).chooseCategory(index);
      },
      child: Container(
        height: 40,
        color: AppCubit.get(context).categoryIndex == index
            ? Colors.white
            : Colors.grey[200],
        child: Center(
          child: Text(
            model.categoryName,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget subCategoryItem({required String cat, required String subCat,required String image , required context}) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).chooseSubCategory(cat: cat, subCat: subCat, context: context);
      },
      child: Container(
        height: 40,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150.0,
              child: CachedNetworkImage(
                imageUrl: image,
              ),
            ),
            Text(
              subCat,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

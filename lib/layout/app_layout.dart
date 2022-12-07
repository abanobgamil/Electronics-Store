import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:electronics_store/modules/cart/cart_screen.dart';
import 'package:electronics_store/modules/search/search_screen.dart';
import 'package:electronics_store/shared/component/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


class AppLayout extends StatelessWidget {

   const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =AppCubit.get(context);

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Electronics Store',
            ),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon:  const Icon(
                    Icons.search,
                  ),
              ),
              IconButton(
                  onPressed: ()
                  {
                      navigateTo(context, const CartScreen());
                  },
                  icon:  const Icon(
                    Icons.shopping_cart,
                  ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex:cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: HexColor("2B4F60"),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            items:
            const [
               BottomNavigationBarItem(
                icon: Icon(
                Icons.home,
              ),
                label: 'Home'
              ),
               BottomNavigationBarItem(
                icon: Icon(
                Icons.list_alt,
              ),
                label: 'Categories '
              ),
               BottomNavigationBarItem(
                icon: Icon(
                Icons.favorite,
              ),
                label: 'Favourite '
              ),
               BottomNavigationBarItem(
                icon: Icon(
                Icons.settings,
              ),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}

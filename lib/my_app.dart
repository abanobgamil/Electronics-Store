import 'package:electronics_store/layout/app_layout.dart';
import 'package:electronics_store/layout/cubit/cubit.dart';
import 'package:electronics_store/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getHomeModel()..getCategoriesModel()..getFavoritesModel()..getCart()
              ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: HexColor("2B4F60"),
                titleTextStyle: TextStyle(
                  color: HexColor(
                      "E5E3D7"
                  ),
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
                iconTheme: IconThemeData(
                  color: HexColor(
                      "E5E3D7"
                  )
                )
              )
            ),
            home:  const AppLayout(),
          );
        },
      ),
    );
  }
}
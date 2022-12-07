import 'package:bloc/bloc.dart';
import 'package:electronics_store/bloc_observer.dart';
import 'package:electronics_store/my_app.dart';
import 'package:electronics_store/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

void main() {

  DioHelper.init();
  BlocOverrides.runZoned(() {
    runApp(
        const MyApp()
    );
  },
    blocObserver: MyBlocObserver(),
  );

}





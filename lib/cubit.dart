import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_screen.dart';
import 'package:news_app/science_screen.dart';
import 'package:news_app/sports_screen.dart';
import 'package:news_app/states.dart';
import 'cash_helper.dart';
import 'dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() :super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem>bottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(
            Icons.business
        ),
        label: "business"
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports_football
        ),
        label: "sports"
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science_outlined
        ),
        label: "science"
    ),

  ];

  List<Widget>screens =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index) {

    currentIndex = index;
    if (index == 0)
      getBusiness();
    if (index == 1)
      getSports();
    if (index == 2)
      getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q':'business',
        'from': '2022-09-17',
        'sortBy':'popularity',
        'apiKey': 'e4d12fcb2ac84fc59b08857884bdd3ca'},).then((value) {
        //print(value.data.toString());
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }


  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q':'sports',
        'from': '2022-09-17',
        'sortBy':'popularity',
        'apiKey': 'e4d12fcb2ac84fc59b08857884bdd3ca'},).then((value) {
        //print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q':'science',
        'from': '2022-09-17',
        'sortBy':'popularity',
        'apiKey': 'e4d12fcb2ac84fc59b08857884bdd3ca'},).then((value) {
        //print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).
      then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q':'$value',
      'from': '2022-09-17',
      'apiKey': 'e4d12fcb2ac84fc59b08857884bdd3ca'},).then((value) {
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
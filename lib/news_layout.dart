import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit.dart';
import 'package:news_app/search_screen.dart';
import 'package:news_app/states.dart';
import 'package:news_app/tester.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state)
      {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "New App"),
            actions: [
              IconButton(
                  icon:Icon(
                    Icons.search_rounded,
                  ),
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  }),
              IconButton(
                  icon:Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed:(){
                    NewsCubit.get(context).changeAppMode();
                  }),
            ],

          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            currentIndex : cubit.currentIndex,
            items:cubit.bottomItems,
          ),
        );
      },
    );
  }
}
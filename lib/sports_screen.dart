import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/states.dart';
import 'package:news_app/tester.dart';
import 'cubit.dart';

class SportScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        var list=NewsCubit.get(context).sports;
        return articleBuilder(list,context);
      } ,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit.dart';
import 'package:news_app/states.dart';
import 'package:news_app/tester.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget
{
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state){
          var list=NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller:searchController ,
                    keyboardType:TextInputType.text,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    onChanged: (String value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    decoration:InputDecoration(
                      labelText:"search",
                      prefixIcon: Icon(
                          Icons.search
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value.isEmpty){
                        return "search address must not be empty ";
                      }
                      return null;

                    },
                  ),
                ),
                Expanded(child: articleBuilder(list,context,isSearch: true)),

              ],
            ),
          );
        } );

  }
}


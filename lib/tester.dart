import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/webviewscreen.dart';

Widget buildArticleItem( articles,context)=>InkWell(
    onTap: ()
    {
      navigateTo(context, WebViewScreen(articles['url']));
    },
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        Container(

          width:120 ,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage("${articles['urlToImage']}"),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(child:

                Text("${articles['title']}",

                  style:Theme.of(context).textTheme.bodyText1,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,),),

                //ta3del

                Text('${articles['publishedAt']}',

                  style:TextStyle(

                    color: Colors.grey,

                  ),),



              ],

            ),

          ),

        )

      ],



    ),

  ),
);


Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 5,
    color:Colors.grey[300] ,
  ),
);


Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder:(context,index)=>myDivider(),
      itemCount: list.length,),
  fallback:(context)=>isSearch?Container():Center(child: CircularProgressIndicator()),);


void navigateTo(context,widget){
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context)=>widget
      )
  );
}
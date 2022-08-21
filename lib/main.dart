import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/dio_helper.dart';
import 'package:news_app/news_layout.dart';
import 'package:news_app/states.dart';
import 'bloc_observer.dart';
import 'cash_helper.dart';
import 'cubit.dart';
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized() بتخلي الحاجات اللي بعديها تتنفذ
  // وبعد كدة يعمل run
  DioHelper.init();
  await CacheHelper.init();

  bool isDark=CacheHelper.getData(key:"isDark");

  BlocOverrides.runZoned(
        () {
      // Use blocs...
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getScience()..getSports(),),
        BlocProvider(create: (context)=>NewsCubit()..changeAppMode(fromShared:isDark)),
      ],
      child: BlocConsumer<NewsCubit ,NewsStates>(
          listener: (context ,state){},
          builder: (context ,state){
            return  MaterialApp(

              theme: ThemeData( scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  iconTheme:IconThemeData(
                    color: Colors.black,
                    size: 30,
                  ),
                  elevation: 0,

                  color: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness:  Brightness.dark,
                  ),
                ),
                bottomNavigationBarTheme:BottomNavigationBarThemeData (
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
                primarySwatch: Colors.deepOrange,
              ),
              darkTheme:  ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),

                appBarTheme: AppBarTheme(
                  elevation: 0,
                  titleSpacing: 20,
                  iconTheme:IconThemeData(
                    color:Colors.white,
                    size: 30,
                  ),

                  color: HexColor('333739'),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),

                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness:  Brightness.light,
                  ),
                ),

                bottomNavigationBarTheme:BottomNavigationBarThemeData (
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
                primarySwatch: Colors.deepOrange,
              ),
              themeMode:NewsCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home:NewsLayout(),
            );
          }
      ),
    );
  }
}










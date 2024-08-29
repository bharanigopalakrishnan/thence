import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/bloc/all_plants/plants_bloc.dart';
import 'package:thence/bloc/all_plants/plants_event.dart';
import 'package:thence/bloc/wishlist/wishlist_bloc.dart';
import 'package:thence/bloc/wishlist/wishlist_event.dart';
import 'package:thence/view/home_screen/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<PlantsBloc>(
                create: (context) => PlantsBloc()..add(FetchPlants())),
            BlocProvider<WishlistBloc>(
                create: (context) => WishlistBloc()..add(WishListInitialize())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Plantify',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          ),
        );
      },
      child: const HomePage(),
    );
  }
}

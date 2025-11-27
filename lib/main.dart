import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/ChatApp/fetchUserCubit.dart';
import 'package:netflix_clone/ProfileSection/ProfileSectionBloc.dart';
import 'package:netflix_clone/RecomendationsCubit/RecommendationCubit.dart';
import 'package:netflix_clone/SearchCubit/SearchQuerryMainBloc.dart';
import 'package:netflix_clone/SearchCubit/TopRatedCubit.dart';
import 'package:netflix_clone/apiservice/UpCommingMovies/UpCommingCubit.dart';
import 'package:netflix_clone/auth_block_screens/AuthenticationMainBloc.dart';
import 'package:netflix_clone/auth_block_screens/SignUpButtonCubit.dart';


import 'BlocCubit/BottomNavigationIndex.dart';
import 'PopularMovieCubit/PoularMovieCubit.dart';
import 'Screeens/SplashScreen.dart';
import 'apiservice/Api Cubit.dart';
import 'firebase_options.dart';

import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zimkit/zego_zimkit.dart';


String userImage = "";
String userName = '';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ZIMKit().init(
    appID: 216291175, // your appid
    appSign: "eb1d17f419bda7d2a79697070ffe77fdb594cdf0728f9acac57836f7d366d078", // your appSign
  );
 await ZIM.create(
   ZIMAppConfig(
     appID:216291175,
     appSign: "eb1d17f419bda7d2a79697070ffe77fdb594cdf0728f9acac57836f7d366d078"

   )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ScreenUtilInit(
          designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_,child){
           return MultiBlocProvider(
             providers: [
               BlocProvider(create: (context)=>BottomNavigationIndex()),
               BlocProvider(create: (context)=>FetchNowPlaying()),
               BlocProvider(create: (context)=>FetchUpComing()),
               BlocProvider(create: (context)=>PoularMovieCubit()),
               BlocProvider(create: (context)=>TopRatedCubit()),
               BlocProvider(create: (context)=>SearchQuerryMainBlock()),
               BlocProvider(create: (context)=>RecommendationCubit()),
               BlocProvider(create: (context)=>AuthenticationMainBloc()),
               BlocProvider(create: (context)=>SignUpButtonCubit()),
               BlocProvider(create: (context)=>FetchUsersCubit()),
               BlocProvider(create: (context)=>ProfileSectionCubit())
             ],
             child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData.dark(),
                home:  SplashScreen(),
              ),
           );

          },


        );
      }
    );
  }
}

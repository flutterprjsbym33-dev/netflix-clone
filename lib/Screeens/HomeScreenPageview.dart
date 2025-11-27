import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/MovieMapper.dart';
import 'package:netflix_clone/Screeens/DetailsScreen.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';
import 'package:netflix_clone/apiservice/FetchDataMainStaets.dart';

import '../RecomendationsCubit/RecommendationCubit.dart';
import '../apiservice/Api Cubit.dart';

class HomeScreenPageView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenPageView();
  }
 
  
}

class _HomeScreenPageView extends State<HomeScreenPageView>{
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<FetchNowPlaying,FetchDataMainStats>(builder: (context,state){
      if(state is FetchNowPlayingErrorState)
        {
          return Center(child: Text(state.error),);
        }

      if(state is FetchNowPlayingLoadingState)
        {
          return  Center(child: Lottie.asset("assets/dots.json",));
        }
      if(state is FetchNowPlayingSuccessState)
        {
          return Column(
            children: [
              SizedBox(
                height: height*0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AnotherCarousel(images: state.movie.results!.map((i){
                    return GestureDetector(

                        onTap: (){
                          context.read<RecommendationCubit>().fetchRecomendations(i.id.toString());
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                              title: i.title.toString(),
                              picUrl: i.backdropPath.toString(),
                              date: i.releaseDate.toString(),
                              quality: "HD",
                              description: i.overview.toString(),
                              time: i.releaseDate.toString(), orginalTitle: i.originalTitle.toString(),)));

                        },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                orginalTitle: i.originalTitle.toString(),
                                  title: i.title.toString(),
                                  picUrl: i.posterPath.toString(),
                                  date: i.releaseDate.toString(),
                                  quality: "HD",
                                  description: i.overview.toString(),
                                  time: i.releaseDate.toString())));

                            },
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.png', // your placeholder
                              image: "$imagePath${i.posterPath}",
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 300),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.grey);
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black54,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                              left: 0,
                              right: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height*0.05,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.play_arrow,color: Colors.black,),
                                          Text("Play",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),

                                  Container(
                                    height: height*0.05,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,color: Colors.white,),
                                          Text("My List",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ))

                        ],
                      ),
                    );
                  }).toList(),
                  showIndicator: false,
                    autoplayDuration: const Duration(seconds: 6),
                    animationDuration: const Duration(seconds: 2),
                  ),
                ),
              ),
              SizedBox(height: 5.h,),

            ],
          );
        }
      else{
        return SizedBox();
      }
    });
  }
  
}
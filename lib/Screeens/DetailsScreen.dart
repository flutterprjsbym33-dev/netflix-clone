import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Mappers/Popular.dart';
import 'package:netflix_clone/RecomendationsCubit/RecommendationCubit.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';

import '../MovieMapper.dart';
import '../RecomendationsCubit/RecommendationsState.dart';
import '../SearchCubit/SearchResult.dart';
import '../SearchCubit/TopReatedMovies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget
{
  String title;
  String picUrl;
  String date;
  String time;
  String quality;
  String description;
  String orginalTitle;


   DetailScreen({super.key,
     required this.title,
     required this.picUrl,
     required this.date,
     required this.quality,
     required this.description,
     required this.time,
     required this.orginalTitle

   });

  @override
  State<StatefulWidget> createState() {
    return _DetailScreen(
    );
  }

}

class _DetailScreen extends State<DetailScreen>{

  List<IconData> iconsDetails = [
    Icons.add,
    Icons.thumb_up,
    Icons.share
  ];

  List<String> iconsTitle = [
    "My List",
    "Rate",
    "Share"
  ];

  late String title ;
 late String orginalTitle;
  late String picUrl;
 late String date;
   late String time;
   late String quality;
   late String description;


  dynamic movie;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    orginalTitle = widget.orginalTitle;
    title = widget.title;
    picUrl = widget.picUrl;
    date = widget.date;
    time = widget.time;
    quality = widget.quality;
    description = widget.description;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height*0.4,width: double.infinity,
                    child: Image.network("$imagePath$picUrl",fit: BoxFit.fill,)),
                Positioned(
                  top: 20,
                    right: 10,
                    child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black87,
                        child:
                             IconButton(onPressed: (){},
                                 padding: EdgeInsets.zero,
                                 icon: Icon(Icons.cancel_outlined,size: 30,))),
                    SizedBox(width: 6.w,),
                    CircleAvatar(
                      backgroundColor: Colors.black87,
                        child:
                             IconButton(onPressed: (){},
                                 padding: EdgeInsets.zero,
                                 icon: Icon(Icons.cast,size: 30,)))
                  ],

                )),
                Positioned(
                  top: 50,
                    bottom: 50,
                    left: 50,
                    right: 50,
                    child: Icon(Icons.play_circle_outline,size: 45,)),
                SizedBox(height: height*0.01,),


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                    Row(
                      children: [
                        Text(date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),),
                        SizedBox(width: 14.w,),
                        Text("2h 47m",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,color: Colors.white),),
                        SizedBox(width: 8.w,),
                        Text("HD",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: Colors.grey),),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Container(
                      height: height*0.06,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow,color: Colors.black,),
                          SizedBox(width: 5.w,),
                          Text("Play",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: Colors.black))
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height: height*0.06,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download,color: Colors.white,),
                          SizedBox(width: 5.w,),
                          Text("Download",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Text(orginalTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: Colors.grey.shade800)),
                    SizedBox(height: 8.h,),
                    Text(description,style: TextStyle(fontSize: 16,color: Colors.grey)),
                    SizedBox(height: 8.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(iconsDetails.length, (index){
                        return Column(
                          children: [
                            Icon(iconsDetails[index],size: 40,),
                            Text(iconsTitle[index],style: TextStyle(fontSize:14.sp),)
                          ],

                        );
                      }),
                    ),
                    SizedBox(height: 8.h,),
                    Text("Related Movies",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 10.h,),
            SizedBox(
            height:height*0.25,
            child: BlocBuilder<RecommendationCubit,RecommendationsMovieMainState>(builder: (context,state)
            {
            if(state is RecommendationsInitialState)
            {
            return Center(child: CircularProgressIndicator());
            }
            if(state is RecommendationsSuccessState)
            {
            return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.recomendationsMovies.results!.length,


            itemBuilder: (context,index){
            final item = state.recomendationsMovies.results![index].posterPath;
            final title = state.recomendationsMovies.results![index].title;
            return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: "$imagePath$item",
                  height: height*0.15,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Center(child: Lottie.asset("assets/dots.json",height: height*0.15))
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.broken_image,color: Colors.white,),
                ),
                SizedBox(height: 8.h,),
                Text("${title!.split(' ').first}...",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,),),
              ],
            ),
            ),
            );
            });
            }
            else{
            return SizedBox();
            }
            })
            )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}

//$imagePath$item}
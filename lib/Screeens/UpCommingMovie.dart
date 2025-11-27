import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';
import 'package:netflix_clone/apiservice/UpCommingMovies/UpCommingCubit.dart';

import '../apiservice/UpcomingMainState.dart';

class UpCommingMovie extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _UpCommingMovie();
  }
  
}

class _UpCommingMovie extends State<UpCommingMovie>{

  @override
  void initState() {
   super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height:height*0.2,
      child: BlocBuilder<FetchUpComing,UpcomingMovieMainState>(builder: (context,state)
      {
        if(state is FetchUpcomingInitialState)
          {
            return Center(child: CircularProgressIndicator());
          }
        if(state is FetchUpcomingSuccessState)
          {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.movie.results!.length,


                itemBuilder: (context,index){
                final item = state.movie.results![index].posterPath;
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network("$imagePath$item}",height: height*0.07,),
                  ),
                );
                });
          }
        else{
          return SizedBox();
        }
      })
    );
  }
}
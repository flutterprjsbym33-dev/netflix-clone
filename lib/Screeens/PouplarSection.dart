import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';
import 'package:netflix_clone/apiservice/UpCommingMovies/UpCommingCubit.dart';

import '../PopularMovieCubit/PopularMovieMainState.dart';
import '../PopularMovieCubit/PoularMovieCubit.dart';
import '../apiservice/UpcomingMainState.dart';
import 'DetailsScreen.dart';

class Pouplarsection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpCommingMovie();
  }

}

class _UpCommingMovie extends State<Pouplarsection>{

  @override
  void initState() {
    super.initState();
    context.read<PoularMovieCubit>().fetchUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        height:height*0.2,
        child: BlocBuilder<PoularMovieCubit,PopularMovieMainState>(builder: (context,state)
        {
          if(state is FFetchPoPopularLoadingState)
          {
            return Center(child: CircularProgressIndicator());
          }
          if(state is FetchPoPopularSuccessState)
          {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.movie.results!.length,
                itemBuilder: (context,index){
                  final item = state.movie.results![index].posterPath;
                  final data = state.movie.results![index];
                  return GestureDetector(

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                            orginalTitle: data.originalTitle.toString(),
                            title: data.title.toString(),
                            picUrl: data.posterPath.toString(),
                            date: data.releaseDate.toString(),
                            quality: "HD",
                            description: data.overview.toString(),
                            time: data.releaseDate.toString())));

                      },

                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                              orginalTitle: data.originalTitle.toString(),
                              title: data.title.toString(),
                              picUrl: data.posterPath.toString(),
                              date: data.releaseDate.toString(),
                              quality: "HD",
                              description: data.overview.toString(),
                              time: data.releaseDate.toString())));

                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network("$imagePath$item}",height: height*0.07,),
                        ),
                      ),
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
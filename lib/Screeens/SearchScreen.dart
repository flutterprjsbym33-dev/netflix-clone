import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/SearchCubit/SearchQuerryMainBloc.dart';
import 'package:netflix_clone/SearchCubit/SearchquerryMainState.dart';
import 'package:netflix_clone/SearchCubit/TopRatedCubit.dart';
import 'package:netflix_clone/SearchCubit/TopRatedMainState.dart';

import '../SearchCubit/SearchQuerryMainEvents.dart';
import '../apiservice/APIConstants.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedCubit>().fetchTopMovies();

  }

  TextEditingController searchQuerry = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40.h,
          child: TextField(
            controller: searchQuerry,
            decoration: InputDecoration(
              hintText: "Search",
              filled: true,
              fillColor: Colors.grey.shade700,
              prefixIcon: GestureDetector(
                onTap: (){
                  searchQuerry.text.isEmpty ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                      content: Text("Please Enter Movie Name For Search"))) : context.read<SearchQuerryMainBlock>().add(OnSerachPressed(querry: searchQuerry.text));
                },
                  child: Icon(Icons.search)),
              suffixIcon: GestureDetector(
                onTap: (){
                  searchQuerry.text = "";
                  context.read<SearchQuerryMainBlock>().add(onSearchCancel());

                },
                  child: Icon(Icons.cancel)),

              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

      ),
      body: Padding(padding: EdgeInsets.all(10),
      child:
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("Top Searched",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
           SizedBox(height: 10.h,),
           BlocBuilder<SearchQuerryMainBlock,SearchquerryMainState>(builder: (context,state){
            if(state is SearchquerryInitailState){
             return BlocBuilder<TopRatedCubit,TopRatedMainState>(builder: (context,state){
               if(state is TopRatedLoadingState)
                 {
                   return Center(child: Lottie.asset('assets/dots.json',fit: BoxFit.cover));
                 }

                if(state is TopRatedSuccessState)
                  {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.topreatedmovies.results!.length,
                          itemBuilder: (context,index){
                          final image = state.topreatedmovies.results![index].posterPath;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: height*0.12,
                              child: Row(
                                children: [
                                  Image.network("$imagePath$image",),
                                  SizedBox(width: 5.w,),
                                  Expanded(child: Text(state.topreatedmovies.results![index].title ??"...Network Connection Error",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),maxLines: 1,))
                                ],
                              ),
                            ),
                          );
                          }),
                    );
                  }
                else{
                 return SizedBox();
                }
              });

            }
            if(state is SearchquerryLoadingState)
              {
                return  Center(child: Lottie.asset('assets/dots.json'));
              }
            if(state is SearchquerrySuccessState)
              {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.searchResult.results!.length,
                      itemBuilder: (context,index){
                        final image = state.searchResult.results![index].posterPath;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: height*0.12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 80.w,
                                  height: height * 0.12,
                                  child: image != null && image.isNotEmpty
                                      ? Image.network(
                                    "$imagePath$image",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/images/loading.png", fit: BoxFit.cover);
                                    },
                                  )
                                      : Image.asset("assets/images/loading.png", fit: BoxFit.cover),
                                ),
                                SizedBox(width: 5.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       Text(state.searchResult.results![index].title ??"...Network Connection Error",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),maxLines: 1,),
                                      Text(state.searchResult.results![index].overview ??"...Network Connection Error",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),maxLines: 1,),
                                      Text(state.searchResult.results![index].releaseDate ??"...Network Connection Error",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),maxLines: 1,)
                                    ],
                                  ),
                                ),
                                Icon(Icons.play_arrow)
                              ],
                            ),
                          ),
                        );
                      }),
                );

              }
            else{
              return SizedBox();
            }
              }
                 ),
         ],
       ),)

    );
  }
}

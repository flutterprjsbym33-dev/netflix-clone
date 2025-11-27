import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenAppBar extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Row(
          children: [

            IconButton(onPressed: (){}, icon: Icon(Icons.download, size: 35.h,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.cast,size: 35.h,)),

          ],
        )

      ],
    );
  }

}
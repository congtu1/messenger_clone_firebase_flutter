import 'package:flutter/material.dart';
import 'package:messenger_clone/constant/size.dart';
class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.07*SizeConfig.sHeight,
      width: SizeConfig.sWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.2)
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: 0.05*SizeConfig.sWidth,),
            Icon(Icons.search),
            SizedBox(width: 0.02*SizeConfig.sWidth,),
            Text("Tìm kiếm")
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:messenger_clone/constant/size.dart';
class buildListAcivityHorizontal extends StatelessWidget {
  const buildListAcivityHorizontal({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if(index == 0) {
          return Container(
            width: 0.25*SizeConfig.sWidth,
            height: 0.15*SizeConfig.sHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.camera),
                  backgroundColor: Colors.white,
                ),
                Expanded(child: Text("Tạo cuộc gọi video",textAlign: TextAlign.center,))
              ],
            ),
          );
        }
        else {
          return Container(
            width: 0.2*SizeConfig.sWidth,
            height: 0.15*SizeConfig.sHeight,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundColor: Colors.black12,),
                    Expanded(child: Text("Phan Nữ Phương Linh",textAlign: TextAlign.center))
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 15,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
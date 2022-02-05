//
// import 'package:flutter/material.dart';
// import 'package:messenger_clone/business_logic/model/message.dart';
// import 'package:provider/provider.dart';
//
// class AudioMessage extends StatelessWidget {
//   final Message message;
//
//   const AudioMessage({Key? key, required this.message}) : super(key: key);
//   bool whoSend(Message message) {
//     return message.sentBy == homeProvider.getCurrentUserInformation.uid ? true : false;
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.55,
//       padding: EdgeInsets.symmetric(
//         horizontal: 20 * 0.75,
//         vertical: 20 / 2.5,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: Colors.blue.withOpacity(whoSend(message) ? 1 : 0.1),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.play_arrow,
//             color: whoSend(message) ? Colors.white : Colors.blue,
//           ),
//           Expanded(
//             child: Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 20 / 2),
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 2,
//                     color: whoSend(message)
//                         ? Colors.white
//                         : Colors.blue.withOpacity(0.4),
//                   ),
//                   Positioned(
//                     left: 0,
//                     child: Container(
//                       height: 8,
//                       width: 8,
//                       decoration: BoxDecoration(
//                         color: whoSend(message) ? Colors.white : Colors.blue,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Text(
//             "0.37",
//             style: TextStyle(
//                 fontSize: 12, color: whoSend(message) ? Colors.white : null),
//           ),
//         ],
//       ),
//     );
//   }
// }

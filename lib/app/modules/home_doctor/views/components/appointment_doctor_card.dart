// import 'package:flutter/material.dart';
// import 'package:flutter_healthcare/app/modules/home/views/constants.dart';

// class AppointmentDoctorCard extends StatelessWidget {
//   AppointmentDoctorCard({
//     Key? key,
//     this.user_image,
//     this.user_name,
//     this.email,
//     this.date,
//     this.time,
//     this.status,
//     required this.onChat,
//   }) : super(key: key);

//   final String? user_image, user_name, email, date, time, status;
//   final GestureTapCallback onChat;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 350,
//       margin: EdgeInsets.only(right: 15),
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//       decoration: BoxDecoration(
//         color: Color(0xff107163),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user_name ?? '',
//                       style: largeTextStyle.copyWith(color: Colors.white),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       email ?? '',
//                       style: mediumTextStyle.copyWith(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 CircleAvatar(
//                   child: ClipOval(
//                     child: Image(
//                       image: AssetImage(user_image!),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.event_available,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         date!,
//                         style: smallTextStyle.copyWith(color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.watch_later,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         time!,
//                         style: smallTextStyle.copyWith(color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.fiber_manual_record,
//                         color:
//                             status == 'Waiting' ? Colors.yellow : Colors.green,
//                       ),
//                       Text(
//                         status!,
//                         style: smallTextStyle.copyWith(color: Colors.white),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 24),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints.tightFor(
//                 width: 200,
//                 height: 30,
//               ),
//               child: ElevatedButton(
//                 style: buttonStyle,
//                 child: Text(
//                   "Chat",
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//                 onPressed: onChat,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

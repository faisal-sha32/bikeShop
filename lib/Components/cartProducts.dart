// import 'package:bikeshop/Components/alertDialog.dart';
// import 'package:bikeshop/Constants/appColors.dart';
// import 'package:bikeshop/Service/firebaseServiceMethods.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CartListView extends StatelessWidget {
//   final String collectionName;
//   final AsyncSnapshot snapshot;
//   const CartListView(
//       {super.key, required this.collectionName, required this.snapshot});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
//       itemBuilder: (_, index) {
//         DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];

//         return Card(
//           elevation: 2,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   documentSnapshot['images'],
//                 ),
//               ),
//               Text(documentSnapshot['name']),
//               Text(
//                 "  \u{20B9}${documentSnapshot['price']}",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.kPrimaryColor,
//                 ),
//               ),
//               GestureDetector(
//                 child: const CircleAvatar(
//                   radius: 14,
//                   backgroundColor: AppColors.kPrimaryColor,
//                   child: Icon(
//                     Icons.remove,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 onTap: () {
//                   showAlertDialog(
//                     context: context,
//                     onConfirm: () {
//                       FirebaseServiceManager().removeItemFromCart(
//                         collectionName: collectionName,
//                         documentId: documentSnapshot.id,
//                         context: context,
//                       );

//                       Navigator.pop(
//                         context,
//                       );
//                     },
//                     dialogMessage: "Are you sure to delete item from cart?",
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return SizedBox(
//           height: 10.h,
//         );
//       },
//     );
//   }
// }

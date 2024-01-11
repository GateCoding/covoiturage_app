// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CardoffrelistItemWidget extends StatelessWidget {
//   const CardoffrelistItemWidget({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 165.r,
//       width: 344.h,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               margin: EdgeInsets.only(right: 1.h),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 17.h,
//                 vertical: 9.r,
//               ),
//               // decoration: AppDecoration.outlineBlack,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 7.r),
//                   Padding(
//                     padding: EdgeInsets.only(right: 13.h),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 3.r),
//                           child: const Text(
//                             "12:06",
//                             style: TextStyle(
//                               // color: appTheme.black900,
//                               // fontSize: 11.fSize,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         // CustomImageView(
//                         //   imagePath: ImageConstant.imgCarbonLocationFilled,
//                         //   height: 17.adaptSize,
//                         //   width: 17.adaptSize,
//                         //   margin: EdgeInsets.only(left: 22.h),
//                         // ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 7.h),
//                           child: const Text(
//                             "Metz",
//                             style: TextStyle(
//                               // color: appTheme.gray90001,
//                               // fontSize: 14.fSize,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         const Text(
//                           "45,5 €",
//                           style: TextStyle(
//                             // color: appTheme.whiteA700,
//                             // fontSize: 13.fSize,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.h),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 32.r),
//                           child: const Text(
//                             "4:00",
//                             style: TextStyle(
//                               // color: appTheme.gray500,
//                               // fontSize: 11.fSize,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 33.h),
//                           child: SizedBox(
//                             height: 45.r,
//                             child: VerticalDivider(
//                               width: 2.h,
//                               thickness: 2.r,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 1.r),
//                   SizedBox(
//                     height: 27.r,
//                     width: 309.h,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 75.h),
//                             child: const Text(
//                               "Paris",
//                               style: TextStyle(
//                                 // color: appTheme.gray90001,
//                                 // fontSize: 14.fSize,
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   top: 3.r,
//                                   bottom: 10.r,
//                                 ),
//                                 child: const Text(
//                                   "16:06",
//                                   style: TextStyle(
//                                     // color: appTheme.black900,
//                                     // fontSize: 11.fSize,
//                                     fontFamily: 'Roboto',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               // CustomImageView(
//                               //   imagePath:
//                               //       ImageConstant.imgCarbonLocationFilled,
//                               //   height: 17.adaptSize,
//                               //   width: 17.adaptSize,
//                               //   margin: EdgeInsets.only(
//                               //     left: 23.h,
//                               //     bottom: 10.r,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 3.r),
//                   Padding(
//                     padding: EdgeInsets.only(right: 1.h),
//                     child: Row(
//                       children: [
//                         // CustomImageView(
//                         //   imagePath: ImageConstant.imgEllipse10,
//                         //   height: 42.r,
//                         //   width: 44.h,
//                         //   radius: BorderRadius.circular(
//                         //     22.h,
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 10.h,
//                             top: 12.r,
//                             bottom: 12.r,
//                           ),
//                           child: const Text(
//                             "Jhone Doe",
//                             style: TextStyle(
//                               // color: appTheme.blueGray700,
//                               // fontSize: 14.fSize,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         // CustomImageView(
//                         //   imagePath: ImageConstant.imgSignal,
//                         //   height: 14.r,
//                         //   width: 15.h,
//                         //   margin: EdgeInsets.only(
//                         //     top: 17.r,
//                         //     bottom: 11.r,
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 6.h,
//                             top: 16.r,
//                             bottom: 8.r,
//                           ),
//                           child: const Text(
//                             "4,5",
//                             style: TextStyle(
//                               // color: appTheme.blueGray700,
//                               // fontSize: 14.fSize,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Align(
//           //   alignment: Alignment.center,
//           //   child: Container(
//           //     margin: EdgeInsets.only(left: 1.h),
//           //     padding: EdgeInsets.symmetric(
//           //       horizontal: 14.h,
//           //       vertical: 6.r,
//           //     ),
//           //     decoration: AppDecoration.outlineBlack900,
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         SizedBox(height: 12.r),
//           //         SizedBox(
//           //           height: 93.r,
//           //           width: 313.h,
//           //           child: Stack(
//           //             alignment: Alignment.center,
//           //             children: [
//           //               Align(
//           //                 alignment: Alignment.topLeft,
//           //                 child: Padding(
//           //                   padding: EdgeInsets.only(
//           //                     left: 75.h,
//           //                     top: 1.r,
//           //                   ),
//           //                   child: Text(
//           //                     "Marrakech",
//           //                     style: TextStyle(
//           //                       color: appTheme.gray90001,
//           //                       fontSize: 14.fSize,
//           //                       fontFamily: 'Roboto',
//           //                       fontWeight: FontWeight.w500,
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ),
//           //               Align(
//           //                 alignment: Alignment.center,
//           //                 child: SizedBox(
//           //                   height: 93.r,
//           //                   width: 313.h,
//           //                   child: Stack(
//           //                     alignment: Alignment.bottomCenter,
//           //                     children: [
//           //                       Align(
//           //                         alignment: Alignment.bottomLeft,
//           //                         child: Padding(
//           //                           padding: EdgeInsets.only(
//           //                             left: 75.h,
//           //                             bottom: 11.r,
//           //                           ),
//           //                           child: Text(
//           //                             "Casablanca",
//           //                             style: TextStyle(
//           //                               color: appTheme.gray90001,
//           //                               fontSize: 14.fSize,
//           //                               fontFamily: 'Roboto',
//           //                               fontWeight: FontWeight.w500,
//           //                             ),
//           //                           ),
//           //                         ),
//           //                       ),
//           //                       Align(
//           //                         alignment: Alignment.bottomCenter,
//           //                         child: Row(
//           //                           crossAxisAlignment:
//           //                               CrossAxisAlignment.start,
//           //                           mainAxisSize: MainAxisSize.min,
//           //                           children: [
//           //                             Padding(
//           //                               padding: EdgeInsets.only(
//           //                                 top: 3.r,
//           //                                 bottom: 10.r,
//           //                               ),
//           //                               child: Text(
//           //                                 "16:06",
//           //                                 style: TextStyle(
//           //                                   color: appTheme.black900,
//           //                                   fontSize: 11.fSize,
//           //                                   fontFamily: 'Roboto',
//           //                                   fontWeight: FontWeight.w500,
//           //                                 ),
//           //                               ),
//           //                             ),
//           //                             CustomImageView(
//           //                               imagePath: ImageConstant
//           //                                   .imgCarbonLocationFilled,
//           //                               height: 17.adaptSize,
//           //                               width: 17.adaptSize,
//           //                               margin: EdgeInsets.only(
//           //                                 left: 23.h,
//           //                                 bottom: 10.r,
//           //                               ),
//           //                             ),
//           //                           ],
//           //                         ),
//           //                       ),
//           //                       Align(
//           //                         alignment: Alignment.topLeft,
//           //                         child: Padding(
//           //                           padding: EdgeInsets.only(
//           //                             top: 1.r,
//           //                             right: 245.h,
//           //                           ),
//           //                           child: Column(
//           //                             mainAxisSize: MainAxisSize.min,
//           //                             children: [
//           //                               Row(
//           //                                 mainAxisAlignment:
//           //                                     MainAxisAlignment.spaceBetween,
//           //                                 children: [
//           //                                   Padding(
//           //                                     padding:
//           //                                         EdgeInsets.only(top: 3.r),
//           //                                     child: Text(
//           //                                       "12:06",
//           //                                       style: TextStyle(
//           //                                         color: appTheme.black900,
//           //                                         fontSize: 11.fSize,
//           //                                         fontFamily: 'Roboto',
//           //                                         fontWeight: FontWeight.w500,
//           //                                       ),
//           //                                     ),
//           //                                   ),
//           //                                   CustomImageView(
//           //                                     imagePath: ImageConstant
//           //                                         .imgCarbonLocationFilled,
//           //                                     height: 17.adaptSize,
//           //                                     width: 17.adaptSize,
//           //                                   ),
//           //                                 ],
//           //                               ),
//           //                               SizedBox(height: 1.r),
//           //                               Align(
//           //                                 alignment: Alignment.centerRight,
//           //                                 child: Padding(
//           //                                   padding:
//           //                                       EdgeInsets.only(right: 5.h),
//           //                                   child: SizedBox(
//           //                                     height: 45.r,
//           //                                     child: VerticalDivider(
//           //                                       width: 2.h,
//           //                                       thickness: 2.r,
//           //                                     ),
//           //                                   ),
//           //                                 ),
//           //                               ),
//           //                             ],
//           //                           ),
//           //                         ),
//           //                       ),
//           //                       Align(
//           //                         alignment: Alignment.topRight,
//           //                         child: Container(
//           //                           width: 61.h,
//           //                           margin: EdgeInsets.only(right: 4.h),
//           //                           padding: EdgeInsets.symmetric(
//           //                             horizontal: 12.h,
//           //                             vertical: 1.r,
//           //                           ),
//           //                           decoration: AppDecoration.fillTeal.copyWith(
//           //                             borderRadius:
//           //                                 BorderRadiusStyle.circleBorder10,
//           //                           ),
//           //                           child: Text(
//           //                             "80DH",
//           //                             style: TextStyle(
//           //                               color: appTheme.whiteA700,
//           //                               fontSize: 13.fSize,
//           //                               fontFamily: 'Roboto',
//           //                               fontWeight: FontWeight.w400,
//           //                             ),
//           //                           ),
//           //                         ),
//           //                       ),
//           //                       Align(
//           //                         alignment: Alignment.bottomRight,
//           //                         child: Container(
//           //                           height: 25.r,
//           //                           width: 106.h,
//           //                           margin: EdgeInsets.only(bottom: 9.r),
//           //                           child: Stack(
//           //                             alignment: Alignment.center,
//           //                             children: [
//           //                               Align(
//           //                                 alignment: Alignment.center,
//           //                                 child: Container(
//           //                                   height: 24.r,
//           //                                   width: 106.h,
//           //                                   decoration: BoxDecoration(
//           //                                     color: appTheme.teal700,
//           //                                     borderRadius:
//           //                                         BorderRadius.circular(
//           //                                       8.h,
//           //                                     ),
//           //                                   ),
//           //                                 ),
//           //                               ),
//           //                               Align(
//           //                                 alignment: Alignment.center,
//           //                                 child: Text(
//           //                                   "Book now",
//           //                                   style: TextStyle(
//           //                                     color: appTheme.whiteA700,
//           //                                     fontSize: 16.fSize,
//           //                                     fontFamily: 'Poppins',
//           //                                     fontWeight: FontWeight.w500,
//           //                                   ),
//           //                                 ),
//           //                               ),
//           //                             ],
//           //                           ),
//           //                         ),
//           //                       ),
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //         SizedBox(height: 3.r),
//           //         Padding(
//           //           padding: EdgeInsets.only(right: 5.h),
//           //           child: Row(
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             children: [
//           //               CustomImageView(
//           //                 imagePath: ImageConstant.imgEllipse12,
//           //                 height: 42.r,
//           //                 width: 44.h,
//           //                 radius: BorderRadius.circular(
//           //                   22.h,
//           //                 ),
//           //               ),
//           //               Padding(
//           //                 padding: EdgeInsets.only(
//           //                   left: 10.h,
//           //                   top: 12.r,
//           //                   bottom: 12.r,
//           //                 ),
//           //                 child: Text(
//           //                   "Essakhi aimrane",
//           //                   style: TextStyle(
//           //                     color: appTheme.blueGray700,
//           //                     fontSize: 14.fSize,
//           //                     fontFamily: 'Roboto',
//           //                     fontWeight: FontWeight.w500,
//           //                   ),
//           //                 ),
//           //               ),
//           //               const Spacer(),
//           //               CustomImageView(
//           //                 imagePath: ImageConstant.imgSignalTeal500,
//           //                 height: 14.r,
//           //                 width: 15.h,
//           //                 margin: EdgeInsets.only(
//           //                   top: 17.r,
//           //                   bottom: 11.r,
//           //                 ),
//           //               ),
//           //               Padding(
//           //                 padding: EdgeInsets.only(
//           //                   left: 6.h,
//           //                   top: 16.r,
//           //                   bottom: 8.r,
//           //                 ),
//           //                 child: Text(
//           //                   "4,5",
//           //                   style: TextStyle(
//           //                     color: appTheme.blueGray700,
//           //                     fontSize: 14.fSize,
//           //                     fontFamily: 'Roboto',
//           //                     fontWeight: FontWeight.w400,
//           //                   ),
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

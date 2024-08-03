// import 'package:flutter/material.dart';
//
// class Categories extends StatefulWidget {
//   const Categories({super.key});
//
//   @override
//   State<Categories> createState() => _CategoriesState();
// }
//
// class _CategoriesState extends State<Categories> {
//   int selectedIndex=0;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 130,
//       child: ListView.builder(
//
//         scrollDirection: Axis.horizontal,
//         itemCount: categoriesList.length, // corrected
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: (){
//               setState(() {
//                 selectedIndex=index;
//               });
//
//             },
//             child: Container(padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
//                 color: selectedIndex == index ?Colors.blue[200]:Colors.transparent,
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 65,
//                     width: 65,
//
//                     decoration: BoxDecoration(
//
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage(categoriesList[index].image), // corrected
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     categoriesList[index].title, // corrected
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//
//       ),
//     );
//   }
// }
//
// class Category {
//   final String title;
//   final String image;
//
//   Category({
//     required this.title,
//     required this.image,
//   });
// }
//
// final List<Category> categoriesList = [
//   Category(
//     title: "All",
//     image: "asset/images/all.png",
//   ),
//   Category(
//     title: "Shoes",
//     image: "asset/images/shoes.jpg",
//   ),
//   Category(
//     title: "Beauty",
//     image: "asset/images/face care.png",
//   ),
//   Category(
//     title: "Women's",
//     image: "asset/images/women.jpg",
//   ),
//   Category(
//     title: "Jewelry",
//     image: "asset/images/jewelry-box.png",
//   ),
//   Category(
//     title: "Men's",
//     image: "asset/images/man jacket.png",
//   ),
// ];
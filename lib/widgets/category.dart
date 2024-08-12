import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final Function(int) onCategorySelected;

  const Categories({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: selectedIndex == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : null,
                      image: DecorationImage(
                        image: AssetImage(categoriesList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    categoriesList[index].title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: selectedIndex == index ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categoriesList = [
  Category(
    title: "All",
    image: "asset/images/all.png",
  ),
  Category(
    title: "Shoes",
    image: "asset/images/shoes.jpg",
  ),
  Category(
    title: "Beauty",
    image: "asset/images/face care.png",
  ),
  Category(
    title: "Women",
    image: "asset/images/women.jpg",
  ),
  Category(
    title: "Jewelry",
    image: "asset/images/jewelry-box.png",
  ),
  Category(
    title: "Men",
    image: "asset/images/man jacket.png",
  ),
];

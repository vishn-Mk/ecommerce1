import 'package:flutter/material.dart';

class Categorie extends StatefulWidget {
  final Function(int) onCategorySelected;

  const Categorie({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  State<Categorie> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categorie> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
            widget.onCategorySelected(0);
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
                    border: selectedIndex == 0
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                    image: DecorationImage(
                      image: AssetImage(categoriesList[0].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  categoriesList[0].title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == 0 ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length - 1, // Exclude the first category
              itemBuilder: (context, index) {
                final categoryIndex = index + 1; // Adjust index for remaining categories
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = categoryIndex;
                    });
                    widget.onCategorySelected(categoryIndex);
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
                            border: selectedIndex == categoryIndex
                                ? Border.all(color: Colors.blue, width: 2)
                                : null,
                            image: DecorationImage(
                              image: AssetImage(categoriesList[categoryIndex].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          categoriesList[categoryIndex].title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == categoryIndex ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
    title: "Men",
    image: "asset/images/man jacket.png",
  ),
];

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';
import '../utils/constants.dart';
import '../view_model/whislist_viewmodel.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = loadData();
  }

  Future<void> loadData() async {
    final authService = AuthServices();
    await authService.loadUserId(); // Ensure this method is correctly awaited and fetches the userId
    final wishProvider = Provider.of<WishViewModel>(context, listen: false);
    print('=====================${wishProvider.wishItems.length}');
    if (authService.userId != null) {
      await wishProvider.fetchWishContents(authService.userId!, context);
    } else {
      print('User ID is null. Cannot fetch wishlist.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishProvider = context.watch<WishViewModel>();

    void deleteItem(String itemId) async {
      await wishProvider.deleteWishItem(itemId, context);
    }

    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
          future: _loadDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (wishProvider.wishData.isEmpty) {
              return const Center(child: Text('No favorite items found.'));
            }

            return ListView.builder(
                itemCount: wishProvider.wishItems.length,
                itemBuilder: (context, index) {
                  var item = wishProvider.wishData[index];
                  print(wishProvider.wishItems.length);
                  print("vishnu123:${wishProvider.wishData}");
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: kcontentColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(item.image ?? ""),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? "Unknown Title",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item.category ?? "Unknown Category",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$${item.price ?? '0.00'}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 35,
                        child: IconButton(
                          onPressed: () {
                            String itemId = item.sId ?? '';
                            deleteItem(itemId);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

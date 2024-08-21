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
    await authService.loadUserId();
    final wishProvider = Provider.of<WishViewModel>(context, listen: false);
    if (authService.userId != null) {
      await wishProvider.fetchWishContents(authService.userId!, context);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Favorites",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.shade200],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade100,
                                image: DecorationImage(
                                  image: NetworkImage(item.image ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title ?? "Unknown Title",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item.category ?? "Unknown Category",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "\$${item.price ?? '0.00'}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 15,
                      child: IconButton(
                        onPressed: () {
                          String itemId = item.sId ?? '';
                          deleteItem(itemId);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:ecommerce/provider/favorite_provider.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_cart.dart';
import '../services/auth_services.dart';
import '../view_model/whislist_viewmodel.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void>? _loadDataFuture;
  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = AuthServices();
    var id = await authService; // Wait for userId to load
    final wishProvider = Provider.of<WishViewModel>(context, listen: false);
    if (authService.userId != null) {
      await wishProvider.fetchWishContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishprovider = context.watch<WishViewModel>();
    void deleteItem(String itemId) async {
      await wishprovider.deleteWishItem(itemId, context);
    }
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorite;

    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        title: Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: wishprovider.wishItems.length,
              itemBuilder: (context, index) {
                var item = wishprovider.wishItems[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                color: kcontentColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Image.network( wishprovider.wishData[index].image!),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wishprovider.wishData[index].title!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  wishprovider.wishData[index].category!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$${ wishprovider.wishData[index].price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
                      right: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              String itemId = item.sId ?? '';
                              deleteItem(itemId);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
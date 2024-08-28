import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_services.dart';
import '../utils/constants.dart';
import '../view_model/whislist_viewmodel.dart';
import '../widgets/bottom_nav.dart'; // If needed for navigation
import '../widgets/check_out.dart';
import 'Home.dart'; // If needed for checkout box

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
        backgroundColor: Colors.grey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));

          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "My Favorites",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: wishProvider.wishItems.length,
                itemBuilder: (context, index) {
                  var item = wishProvider.wishItems[index];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kcontentColor,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    item.productId?.image ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productId?.title ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item.productId?.description ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "\$${item.productId?.price ?? ""}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: IconButton(
                          onPressed: () {
                            if (item.sId != null) {
                              deleteItem(item.sId!);
                            }
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

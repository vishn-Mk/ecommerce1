import 'package:ecommerce/provider/favorite_provider.dart';
import 'package:ecommerce/provider/provider_cart.dart';
import 'package:ecommerce/screens/login.dart';

import 'package:ecommerce/screens/profiile.dart';
import 'package:ecommerce/screens/splash.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/view_model/auth_viewmodel.dart';
import 'package:ecommerce/view_model/cart_viewmodel.dart';
import 'package:ecommerce/view_model/product_viewmodel.dart';
import 'package:ecommerce/view_model/whislist_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'widgets/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FavoriteProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartViewModel(),
          ), ChangeNotifierProvider(
            create: (_) => WishViewModel(),
          ),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              // Customize your theme here
              ),
          home: SplashScreen(),
        ),
      );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/add_image/add_image_bloc.dart';
import 'package:flutter_seller_app/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_seller_app/bloc/categories/categories_bloc.dart';
import 'package:flutter_seller_app/firebase_options.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/logout/logout_bloc.dart';
import 'bloc/products/products_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'pages/auth/auth_page.dart';
import 'pages/dashboard/seller_dashboard_page.dart';
import 'utils/light_themes.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

/* class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: light,
      home: const SellerDashboardPage(),
    );
  }
} */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => AddImageBloc(),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(),
        ),
        /* BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => BannersBloc(),
        ), */
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Seller App Taufiq',
        /* theme: ThemeData(
                primarySwatch: Colors.blue,
              ), */
        theme: light,
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        //home: const AuthPage(),
        home: FutureBuilder(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return const SellerDashboardPage();
              } else {
                return AuthPage();
              }
            }),
      ),
    );
  }
}

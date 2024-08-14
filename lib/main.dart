import 'package:campmart/bloc/add_product_bloc/add_product_bloc.dart';
import 'package:campmart/bloc/khalti_bloc/khalit_bloc.dart';
import 'package:campmart/pages/splash_screen.dart';
import 'package:campmart/repo/khalti_repo.dart';
import 'package:campmart/utils/size.dart';
import 'package:campmart/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'bloc/bottom_nav_bar_bloc/home_page_bloc.dart';
import 'bloc/fetch_product_bloc/fetch_product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return KhaltiScope(
        publicKey: 'test_public_key_d5d9f63743584dc38753056b0cc737d5',
        enabledDebugging: true,
        builder: (context, navKey) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomePageBloc(),
              ),
              BlocProvider(
                create: (context) => FetchProductBloc(),
              ),
              BlocProvider(
                create: (context) =>
                    KhaltiBloc(khaltiRepository: KhaltiRepository()),
              ),
              BlocProvider(
                create: (context) => AddProductBloc(),
              ),
            ],
            child: MaterialApp(
              title: 'Camp Mart',
              navigatorKey: navKey,
              debugShowCheckedModeBanner: false,
              theme: theme(context),
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              home: const SplashScreen(),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ren_task/model/transaction_response.dart';
import 'package:ren_task/screens/home_screen.dart';
import 'package:ren_task/screens/transaction_detail_screen.dart';
import 'package:ren_task/screens/transaction_list.dart';
import 'package:ren_task/values/app_strings.dart';
import 'package:ren_task/viewModel/transaction_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TransactionViewModel())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ptSansTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _routeFactory(),
      home: const HomeScreen(),
    );
  }

//  Generates Routes by strings
  RouteFactory _routeFactory() {
    return (settings) {
      Widget screen;
      switch (settings.name) {
        case AppStrings.homeRoute:
          screen = const HomeScreen();

          break;
        case AppStrings.transactionDetailRoute:
          screen = TransactionDetailScreen(
            transactionResponse: settings.arguments as ClientTransaction,
          );

          break;
        case AppStrings.transactionRoute:
          screen = const TransactionScreen();

          break;

        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

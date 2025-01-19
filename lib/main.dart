import 'package:flutter/material.dart';
import 'package:mosam/core/db/db.dart';
import 'package:mosam/core/router/app_router.dart';
import 'package:mosam/features/home/provider/home_provider.dart';
import 'package:mosam/features/home/respository/home_repository_impl.dart';
import 'package:mosam/features/search/provider/search_provider.dart';
import 'package:mosam/features/search/repository/search_repository_impl.dart';
import 'package:mosam/service/network.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp(
    db: Db(sharedPreferences: await SharedPreferences.getInstance()),
    networkService: NetworkService(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.networkService, super.key, required this.db});

  final NetworkService networkService;
  final Db db;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(
            repository: HomeRepositoryImpl(NetworkService()),
            db: db,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
            db: db,
            searchRepository:
                SearchRepositoryImpl(networkService: NetworkService()),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

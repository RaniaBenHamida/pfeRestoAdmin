import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_admin/firebase_options.dart';

import 'blocs/category/category_bloc.dart';
import 'blocs/category/category_event.dart';
import 'blocs/products/product_bloc.dart';
import 'blocs/settings/setting_bloc.dart';
import 'config/theme.dart';
import 'models/category_model.dart';
import 'repositories/restaurant/restaurant_repository.dart';
import 'screens/menu/menu_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RestaurantRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryBloc()
              ..add(
                LoadCategories(categories: Category.categories),
              ),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
              categoryBloc: BlocProvider.of<CategoryBloc>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          initialRoute: '/menu',
          routes: {
            '/menu': (context) => const MenuScreen(),
            '/settings': (context) => const SettingsScreen(),
            // '/dash': (context) => const DashboardScreen(),
          },
        ),
      ),
    );
  }
}

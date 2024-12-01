import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/models/product_details_arguments.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/cart_view.dart';
import 'package:usanacaixaapp/ui/views/config/stores/theme_store.dart';
import 'package:usanacaixaapp/ui/views/entry_point/entry_point.dart';
import 'package:usanacaixaapp/ui/views/image/fullscreen_image_view.dart';
import 'package:usanacaixaapp/ui/views/orders/order_details_view.dart';
import 'package:usanacaixaapp/ui/views/product_details/product_details_view.dart';
import 'package:usanacaixaapp/ui/views/products/products_view.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import './viewmodels/app_state_provider.dart';
import 'data/theme/app_theme.dart';
import 'ui/views/home/home_view.dart';
import 'data/services/navigation_service.dart';
import 'data/utils/app_routes.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('pt')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('pt'),
      startLocale: const Locale('pt'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final NavigatorService _navigatorService = NavigatorService();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final mediaQuery = MediaQuery.of(context);

    return MultiProvider(
      providers: [
        Provider(create: (context) => _navigatorService),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()..initialize()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeStore.themeMode,
        builder: (context, themeMode, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'usanacaixaapp',
            navigatorKey: _navigatorService.navigatorKey,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case Routes.home:
                  final VoidCallback buttonMenuPress =
                      settings.arguments as VoidCallback;
                  return MaterialPageRoute(
                    builder: (context) =>
                        HomeView(buttonMenuPress: buttonMenuPress),
                  );
                case Routes.products:
                  final GroupModel group = settings.arguments as GroupModel;
                  return MaterialPageRoute(
                    builder: (context) => ProductsView(group: group),
                  );
                case Routes.productDetails:
                  final ProductDetailsArguments product =
                      settings.arguments as ProductDetailsArguments;
                  return MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsView(arguments: product),
                  );
                case Routes.fullscreenImage:
                  final String urlImage = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (context) => FullScreenImage(imageUrl: urlImage),
                  );
                case Routes.cart:
                  final GroupModel group = settings.arguments as GroupModel;
                  return MaterialPageRoute(
                    builder: (context) => CartView(group: group),
                  );
                case Routes.orderDetails:
                  final int idOrder = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (context) => OrderDetailsView(idOrder: idOrder),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (context) => const Scaffold(
                      body: Center(
                          child: Text(
                              "Houve algum problema, estamos trabalhando nisso...")),
                    ),
                  );
              }
            },
            // SplashScreen como tela inicial
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

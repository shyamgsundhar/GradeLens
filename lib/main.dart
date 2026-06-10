import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_service.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/core/themes/app_theme.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/services/storage_service.dart';
import 'package:gradelens/widgets/error_state_view.dart';
import 'package:gradelens/widgets/loading_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdsenseService.initialize();
  runApp(const GradeLensBootstrap());
}

class GradeLensBootstrap extends StatefulWidget {
  const GradeLensBootstrap({super.key});

  @override
  State<GradeLensBootstrap> createState() => _GradeLensBootstrapState();
}

class _GradeLensBootstrapState extends State<GradeLensBootstrap> {
  late Future<StorageService> _storageFuture = _initStorage();

  Future<StorageService> _initStorage() async {
    final storageService = StorageService();
    await storageService.init();
    return storageService;
  }

  void _retry() {
    setState(() {
      _storageFuture = _initStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StorageService>(
      future: _storageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GradeLensApp(storageService: snapshot.data!);
        }

        final theme = AppTheme.light();
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'GradeLens',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: ErrorStateView(
              title: 'Could not start GradeLens',
              message: 'Local storage failed to initialize. Please try again.',
              onRetry: _retry,
            ),
          );
        }

        return MaterialApp(
          title: 'GradeLens',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const LoadingView(),
        );
      },
    );
  }
}

class GradeLensApp extends StatelessWidget {
  const GradeLensApp({required this.storageService, super.key});

  final StorageService storageService;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(storageService)..load(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'GradeLens',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            scaffoldMessengerKey: NavigationService.scaffoldMessengerKey,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: state.themeMode,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
            onUnknownRoute: AppRouter.onUnknownRoute,
          );
        },
      ),
    );
  }
}

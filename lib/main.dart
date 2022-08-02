import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasks_app/services/app_theme.dart';
import 'package:tasks_app/services/router/app_router.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // HydratedStorage will call native call (storage)
  // getApplicationDocumentsDirectory() provide the path to the local storage.

  // path_provider package, which allows us to access
  // commonly used locations on the device’s filesystem.
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        appRouter: AppRouter(),
      ),
    ),
    // Implement the storage
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Global access object
        BlocProvider(create: (BuildContext context) => TasksBloc()),
        BlocProvider(create: (BuildContext context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            // home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

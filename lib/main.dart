import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:test_driven_development/simple_bloc_observer.dart';

import 'features/counter/bloc/counter_bloc.dart';
import 'presentation/home_page/home_page.dart';
import 'repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(App(repository: Repository())),
    blocObserver: SimpleBlocObserver(),
    storage: storage,
  );
}

class App extends StatelessWidget {
  const App({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Counter App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  CounterBloc(repository: repository)..add(CounterStarted())),
        ],
        child: const HomePage(title: "Counter App"),
      ),
    );
  }
}

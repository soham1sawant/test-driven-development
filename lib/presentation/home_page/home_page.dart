import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/counter/bloc/counter_bloc.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have pushed the button this many times :"),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CounterLoaded) {
                  return Text(
                    state.counterModel.counter.toString(),
                    style: Theme.of(context).textTheme.headline2,
                    key: const Key("counter"),
                  );
                } else if (state is CounterLoadingError) {
                  return const Icon(Icons.error);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "Increment",
        onPressed: () {
          BlocProvider.of<CounterBloc>(context).add(CounterAdded());
        },
      ),
    );
  }
}

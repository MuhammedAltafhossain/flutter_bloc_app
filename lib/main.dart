import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/cubit/counter_cubit.dart';
import 'package:flutter_bloc_app/cubit/counter_cubit_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => CounterCubit())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<CounterCubit, CounterCubitState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  (state is CounterValueUpdated) ? Text(state.counter.toString(), style: Theme.of(context).textTheme.headlineMedium) : Text('0', style: Theme.of(context).textTheme.headlineMedium),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: (){
                          context.read<CounterCubit>().counterIncrease();
                        },
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: (){
                          context.read<CounterCubit>().counterDecrease();
                        },
                        tooltip: 'Decrement',
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  )


                ],
              ),

            );
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/features/application/radiante_controller.dart';
import 'src/features/infrastructure/sensor_service.dart';
import 'src/features/presentation/pages/radiante_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SensorService>(
          create: (_) => SensorService(),
          dispose: (_, service) => service.dispose(),
        ),
        ChangeNotifierProvider<RadianteController>(
          create: (ctx) => RadianteController(ctx.read<SensorService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prime Radiante',
        theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
        home: const RadiantePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/radiante_controller.dart';
import '../../domain/radiant_state.dart';
import '../widgets/status_text.dart';

class RadiantePage extends StatelessWidget {
  const RadiantePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RadianteController>();

    String message;
    switch (ctrl.state) {
      case RadiantState.idle:
        message = 'Faça um movimento circular com o dispositivo para ativar.';
        break;
      case RadiantState.prontoParaToque:
        message = 'Toque duas vezes na tela para ativar.';
        break;
      case RadiantState.ativo:
        message = 'Dispositivo ativo!';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prime Radiante'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Reiniciar',
            onPressed: () => context.read<RadianteController>().reset(),
          ),
        ],
      ),
      body: GestureDetector(
        onDoubleTap: () => context.read<RadianteController>().onDoubleTap(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatusText(text: message),
              const SizedBox(height: 12),

              if (ctrl.lastGyro != null) ...[
                const SizedBox(height: 40),
                Text(
                  'Último evento giroscópio:\n'
                  'gyro x: ${ctrl.lastGyro!.x.toStringAsFixed(2)}, '
                  'y: ${ctrl.lastGyro!.y.toStringAsFixed(2)}, '
                  'z: ${ctrl.lastGyro!.z.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                "Faça um ceirculo fisico incliando o celular:\n"
                "Direita > Baixo > Esquerda > Cima",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

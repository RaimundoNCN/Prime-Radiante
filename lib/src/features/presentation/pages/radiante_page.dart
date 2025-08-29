import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/radiante_controller.dart';
import '../../domain/radiant_state.dart';
import '../widgets/status_text.dart';
import '../widgets/radiante_interface_widget.dart';

class RadiantePage extends StatelessWidget {
  const RadiantePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RadianteController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Primeiro Radiante'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<RadianteController>().reset(),
            tooltip: 'Resetar',
          ),
        ],
      ),
      body: GestureDetector(
        onDoubleTap: () => context.read<RadianteController>().onDoubleTap(),
        behavior: HitTestBehavior.opaque,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, anim) {
            return ScaleTransition(
              scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
              child: FadeTransition(opacity: anim, child: child),
            );
          },
          child: ctrl.state == RadiantState.ativo
              ? const RadianteInterfaceWidget(key: ValueKey('ativo'))
              : _buildIdleOrWaiting(ctrl),
        ),
      ),
    );
  }

  Widget _buildIdleOrWaiting(RadianteController ctrl) {
    String message;
    switch (ctrl.state) {
      case RadiantState.idle:
        message = 'Aguardando movimento circular...';
        break;
      case RadiantState.prontoParaToque:
        message = 'Círculo detectado! Agora dê dois toques 👆👆';
        break;
      case RadiantState.ativo:
        message = ''; // não usado
        break;
    }

    return Center(
      key: const ValueKey('default'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatusText(text: message),
          const SizedBox(height: 24),
          const Text(
            'Faça um círculo físico inclinando o celular:\n'
            'Direita → Baixo → Esquerda → Cima, depois dê dois toques.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

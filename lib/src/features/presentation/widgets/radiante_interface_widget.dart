import 'package:flutter/material.dart';

class RadianteInterfaceWidget extends StatelessWidget {
  const RadianteInterfaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Painel olografico
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.cyanAccent.withOpacity(0.8),
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.6),
                  blurRadius: 16.0,
                  spreadRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.auto_awesome, size: 48.0, color: Colors.cyanAccent),
                const SizedBox(height: 16.0),
                Text(
                  "Interface Radiante",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.cyanAccent,
                        blurRadius: 8.0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Segredos antigos revelados",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
	runApp(const LoveFlutterApp());
}

class LoveFlutterApp extends StatelessWidget {
	const LoveFlutterApp({super.key});

	@override
	Widget build(BuildContext context) {
		return const MaterialApp(
			home: Scaffold(
				body: Center(
					child: Text('I love Flutter'),
				),
			),
		);
	}
}

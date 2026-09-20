import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Camra',
      theme: ThemeData.dark(),
      home: const SmartCameraScreen(),
    );
  }
}

class SmartCameraScreen extends StatefulWidget {
  const SmartCameraScreen({super.key});
  @override
  State<SmartCameraScreen> createState() => _SmartCameraScreenState();
}

class _SmartCameraScreenState extends State<SmartCameraScreen> {
  bool isViolation = false;
  bool autoZoom = true;
  double zoomLevel = 1.0;

  void triggerViolation() {
    setState(() {
      isViolation = true;
      zoomLevel = 2.5; // Auto Zoom
    });
    // 5 سیکنڈ بعد نارمل
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isViolation = false;
        zoomLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Camra - AI Security"),
        backgroundColor: isViolation? Colors.red : Colors.black,
        actions: [
          Icon(isViolation? Icons.warning : Icons.videocam, color: isViolation? Colors.yellow : Colors.green),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          // Camera View
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  transform: Matrix4.identity()..scale(zoomLevel),
                  width: double.infinity,
                  color: Colors.grey[900],
                  child: Icon(Icons.videocam, size: 100, color: Colors.grey),
                ),
                if (isViolation)
                  Positioned(
                    top: 20, left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      color: Colors.red,
                      child: Text("🔥 FIRE DETECTED - AUTO ZOOM x${zoomLevel}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                Positioned(
                  bottom: 20, left: 20, right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("REC ● LIVE", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      Text("Zoom: ${zoomLevel.toStringAsFixed(1)}x"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Controls
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black87,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: ElevatedButton.icon(onPressed: triggerViolation, icon: Icon(Icons.local_fire_department), label: Text("آگ کا ٹیسٹ کرو"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red))),
                      SizedBox(width: 10),
                      Expanded(child: ElevatedButton.icon(onPressed: (){setState(()=> autoZoom =!autoZoom);}, icon: Icon(Icons.zoom_in), label: Text(autoZoom? "Auto Zoom ON" : "OFF"))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(alignment: Alignment.centerLeft, child: Text("Activity Log:", style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(leading: Icon(Icons.check_circle, color: Colors.green, size: 20), title: Text("System Active - No violation", style: TextStyle(fontSize: 13)), dense: true),
                        if(isViolation) ListTile(leading: Icon(Icons.warning, color: Colors.red, size: 20), title: Text("Violation detected! Recording 15s clip & sending...", style: TextStyle(fontSize: 13, color: Colors.red)), dense: true),
                        ListTile(leading: Icon(Icons.videocam, size: 20), title: Text("Camera 01 connected", style: TextStyle(fontSize: 13)), dense: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
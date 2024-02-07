TEAM FEPA
1. MUHAMMAD FADZLI BIN MUHAMMAD SHIHAN (20227581313)
2. NURUL ERINA HANI BINTI RAMLIE (2022865226)
3. PUTERI NUR IZZATI BINTI ZUHAIREE (2022660576)
4. AIMIE ZAFIRAH BINTI ABD SUKOR (2022494792)

2310-ICT602
Lab Work 8
Access to Hardware
1. Group of 4
2. Create new project using command line 'flutter create Talk2Hardware'.
3. Run the project on the smartphone or AVD.
4. Create Splash Screen, Menu and Second Screen using FlutterFlow.
5. Access to Mobile hardware at least two of the following features: Bluetooth, WiFi-Direct, Wireless Display, GPS, Camera, Microphone, Gyrometer, Accelerometer, Pedometer, NFC, Infrared, 5G, WiFi
6. Speed Code Video + Music.
7. Highlight on YouTube using the timestamps.
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.


﻿# Group-Project
## Access to hardware
************************

**Splash Screen page:**

```
import 'dart:async';
import 'package:flutter/material.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToMenu(context);
  }

  void navigateToMenu(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Splash Screen',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```
************************

**Second Page:**

Intialize Camera:
```
  Future<void> _initializeCamera() async {
    if (!_isCameraInitialized) {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController.initialize();
      if (!mounted) return;
      setState(() {});
      _isCameraInitialized = true; // Set flag to true after initialization
    }
  }
```

Initialize GPS:
```
  void _initializeLocation() async {
    Location location = Location();
    _locationData = await location.getLocation();
    setState(() {
      // After getting location data, initialize the camera
      _initializeCamera();
    });
  }
```

Showing Both Camera and Location Coordinate:
```
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: FutureBuilder<void>(
        future: _initializeCamera(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the initialization is still in progress, show a loading indicator
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If an error occurred during initialization, display an error message
            return Center(
              child: Text('Error initializing camera: ${snapshot.error}'),
            );
          } else {
            // If initialization is complete, display the camera preview and location data
            return Column(
              children: [
                Expanded(
                  child: _cameraController.value.isInitialized
                      ? CameraPreview(_cameraController)
                      : Container(), // Only show CameraPreview if initialized
                ),
                Text(
                  'Latitude: ${_locationData?.latitude ?? "Loading..."}, Longitude: ${_locationData?.longitude ?? "Loading..."}',
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
```
************************


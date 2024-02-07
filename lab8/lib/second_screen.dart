import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late CameraController _cameraController;
  LocationData? _locationData; // Make _locationData nullable
  bool _isCameraInitialized = false; // Flag to track camera initialization

  @override
  void initState() {
    super.initState();
    _initializeLocation(); // Initialize location when the screen is initialized
  }

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

  void _initializeLocation() async {
    Location location = Location();
    _locationData = await location.getLocation();
    setState(() {
      // After getting location data, initialize the camera
      _initializeCamera();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

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

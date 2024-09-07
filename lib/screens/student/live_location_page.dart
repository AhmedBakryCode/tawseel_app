import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../components/default_appbar.dart';

class LiveLocationPAge extends StatefulWidget {
  const LiveLocationPAge({Key? key}) : super(key: key);

  @override
  State<LiveLocationPAge> createState() => _LiveLocationPAgeState();
}

class _LiveLocationPAgeState extends State<LiveLocationPAge> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    // Obtain a list of available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    // Create a CameraController and initialize it.
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    // Initialize the camera controller.
    _initializeControllerFuture = _cameraController!.initialize();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed.
    _cameraController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            centerWidget: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff182243),
                      radius: 30,
                      child: Image.asset("assets/user.png"),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mohamed",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                Positioned(
                  top: 100, // Adjust as needed
                  right: 20, // Adjust as needed
                  child: GestureDetector(
                    onTap: (){},
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the camera preview in a Container.
                return Container(
                width: double.infinity,
                height: 300, // Set your desired height for the video container
                child: CameraPreview(_cameraController!),
                );
                } else {
                // Otherwise, display a loading spinner.
                return Center(child: CircularProgressIndicator());
                }
                },
                ),
                ),
          ),
        ],
      ),
    );
  }
}

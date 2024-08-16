// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:flutter/material.dart';
//
// class ARView extends StatelessWidget {
//   final String productImage;
//
//   const ARView({Key? key, required this.productImage, required void Function(ARSessionManager arSessionManager, ARObjectManager arObjectManager, ARAnchorManager arAnchorManager) onARViewCreated}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AR View'),
//       ),
//       body: ARViewWidget(productImage: productImage),
//     );
//   }
// }
//
// class ARViewWidget extends StatefulWidget {
//   final String productImage;
//
//   const ARViewWidget({Key? key, required this.productImage}) : super(key: key);
//
//   @override
//   _ARViewWidgetState createState() => _ARViewWidgetState();
// }
//
// class _ARViewWidgetState extends State<ARViewWidget> {
//   late ARSessionManager _arSessionManager;
//   late ARObjectManager _arObjectManager;
//   late ARAnchorManager _arAnchorManager;
//
//   @override
//   Widget build(BuildContext context) {
//     return ARView(
//       onARViewCreated: _onARViewCreated, productImage: '',
//     );
//   }
//
//   void _onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager) {
//     _arSessionManager = arSessionManager;
//     _arObjectManager = arObjectManager;
//     _arAnchorManager = arAnchorManager;
//
//     _arSessionManager.onInitialize(
//       showFeaturePoints: false,
//       showPlanes: true,
//       showWorldOrigin: true,
//       handleTaps: false,
//     );
//
//     _arObjectManager.onInitialize();
//     _addPlaneWithTexture();
//   }
//
//   void _addPlaneWithTexture() {
//     // Load the texture from the image asset or network
//
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _arSessionManager.dispose();
//
//   }
// }

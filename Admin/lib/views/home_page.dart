// //
// //
// //
// //
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   late WebSocketChannel _channel;
//   final String _reverbIp = '192.168.1.13';
//   final int _reverbPort = 8080;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectToReverb();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             _connectToReverb();
//           },
//           child: Text("Test"),
//         ),
//       ),
//     );
//   }
//
//   void _connectToReverb() async {
//     try {
//       // Ensure you use 'ws://' if Reverb is not configured for SSL (REVERB_SCHEME=http)
//       final Uri uri = Uri.parse(
//         'ws://$_reverbIp:$_reverbPort/app/0suzb1x9lrcrempctyjx',
//       );
//
//       print(uri.toString());
//
//       // Use IOWebSocketChannel.connect for direct socket connection on mobile
//       _channel = IOWebSocketChannel.connect(uri);
//
//       // Wait for the connection to be ready. This is crucial.
//       // await _channel.ready;
//       print('Connected to Reverb: $uri');
//
//       _channel.stream.listen(
//         (message) {
//           // Handle incoming messages
//           print('✅ Received from Reverb: $message');
//         },
//         onError: (error) {
//           print('❌ WebSocket Error: $error');
//           // Implement reconnection logic here if needed
//         },
//         onDone: () {
//           print('✔️ WebSocket connection closed.');
//           // Handle connection closure, e.g., attempt to reconnect
//         },
//       );
//     } catch (e) {
//       print('‼️ Failed to connect to Reverb: $e');
//       // Log the specific exception to understand why it failed
//     }
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
// }

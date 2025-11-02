//
//
//
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mobile/constants/api_constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  ///
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  ///
  bool _isConnected = false;
  WebSocketChannel? _channel;

  /// Callback function for each channel
  final Map<String, Function(Map<String, dynamic>)> _subscriptions = {};

  /// Channel name for each event
  final Map<String, Function(Map<String, dynamic>)> _events = {};

  ///
  void connect() {
    if (_isConnected) return;
    //
    final url = ApiConstants.websocketUrl;
    _channel = IOWebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;

    _channel!.stream.listen(
      (message) {
        //
        final data = jsonDecode(message);
        //
        if (data['event'] == "pusher:connection_established") {
          debugPrint("✅ Connection Established with Reverb...");
        }
        //
        if (data['event'] == "pusher:ping") {
          debugPrint("🏓 Ping event from backend...");
          final subscribeToChannel = {"event": "pusher:pong"};
          _channel!.sink.add(jsonEncode(subscribeToChannel));
        }
        final event = data['event'];
        //
        if (_events.containsKey(event)) {
          // print("======================================");
          // print(jsonDecode(data['data']));
          // print("======================================");
          _events[event]!(jsonDecode(data['data']));
        }
      },
      onError: (error) {
        debugPrint('❌ WebSocket error: $error');
        _isConnected = false;
        reconnect();
      },
      onDone: () {
        debugPrint('✔️ WebSocket closed.');
        _isConnected = false;
        reconnect();
      },
    );
  }

  ///
  void subscribe(
    String channelName,
    Map<String, Function(Map<String, dynamic>)> eventsCallback,
  ) {
    _events.addAll(eventsCallback);
    _send({
      'event': 'pusher:subscribe',
      'data': {'channel': channelName},
    });
  }

  ///
  void unsubscribe(String channelName) {
    _subscriptions.remove(channelName);
    _send({
      'event': 'pusher:unsubscribe',
      'data': {'channel': channelName},
    });
  }

  ///
  void _send(Map<String, dynamic> data) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(data));
    }
  }

  ///
  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
  }

  ///
  void reconnect() {
    Future.delayed(Duration(seconds: 3), () {
      connect();
    });
  }
}

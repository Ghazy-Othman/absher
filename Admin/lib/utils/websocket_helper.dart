//
//
//
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService extends GetxService {
  ///
  WebSocketChannel? _channel;
  bool _isConnected = false;

  ///
  final RxMap<String, dynamic> events = <String, dynamic>{}.obs;

  ///
  Future<WebSocketService> init({bool needAuth = false}) async {
    await _connect(needAuth: needAuth);
    return this;
  }

  @override
  void onClose() {
    _disconnect();
    super.onClose();
  }

  ///
  Future<void> _connect({bool needAuth = false}) async {
    if (_isConnected) return;
    final uri = Uri.parse(await _buildWebSocketUrl(needAuth));
    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen(
      (data) {
        final msg = jsonDecode(data);
        final channel = msg['channel'] as String;
        final event = msg['event'] as String;
        final payload = msg['payload'];
        // Store or update reactively
        events["$channel:$event"] = payload;
      },
      onDone: () {
        _isConnected = false;
      },
      onError: (e) {
        _isConnected = false;
      },
    );

    _isConnected = true;
  }

  ///
  void send(String channel, String event, dynamic payload) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(
        jsonEncode({'channel': channel, 'event': event, 'payload': payload}),
      );
    }
  }

  ///
  void _disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
      _isConnected = false;
    }
  }

  ///
  Stream<dynamic> onEvent(String channel, String event) {
    return events.stream
        .where((map) => map["$channel:$event"] != null)
        .map((map) => map["$channel:$event"]);
  }

  Future<String> _buildWebSocketUrl(bool needAuth) async {
    const baseWsUrl = "wss://yourdomain.com/ws";
    if (!needAuth) return baseWsUrl;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return "$baseWsUrl?token=$token";
  }
}

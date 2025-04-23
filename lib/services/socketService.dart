import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../baseUrl.dart';

class SocketService {
  static IO.Socket? _socket;
  static Function(dynamic)? _notificationCallback;

  static Future<void> initialize() async {
    if (_socket != null && _socket!.connected) return;

    final String socketUrl = _getBaseUrlWithoutApi(baseUrl);

    _socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionAttempts': -1,
      'reconnectionDelay': 2000,
      'reconnectionDelayMax': 5000,
    });

    _socket!.onConnect((_) {
      print('✅ Connected to socket server');
    });

    _socket!.onDisconnect((_) {
      print('❌ Disconnected from socket server');
    });

    _socket!.on('newNotification', (data) {
      if (_notificationCallback != null) {
        _notificationCallback!(data);
      }
    });
  }

  static String _getBaseUrlWithoutApi(String baseUrl) {
    final uri = Uri.parse(baseUrl);
    return '${uri.scheme}://${uri.host}:${uri.port}';
  }

  static void onNewNotification(Function(dynamic) callback) {
    _notificationCallback = callback;
  }

  static bool isConnected() {
    return _socket?.connected ?? false;
  }

  static void disconnect() {
    _socket?.disconnect();
  }
}

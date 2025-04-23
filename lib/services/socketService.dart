import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../baseUrl.dart';  

class SocketService {
  static late IO.Socket socket;

  static void initialize() {
    socket = IO.io(
      baseUrl.replaceFirst('http', 'ws'), 
      IO.OptionBuilder()
          .setTransports(['websocket']) 
          .disableAutoConnect()      
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO');
    });
  }

  static void onNewNotification(Function(dynamic) callback) {
    socket.on('newNotification', callback); 
  }

  static void dispose() {
    socket.dispose();
  }
}

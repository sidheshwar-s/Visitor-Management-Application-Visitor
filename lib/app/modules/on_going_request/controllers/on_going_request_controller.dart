import 'dart:async';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';

late IO.Socket socket;
String userid = "";

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

void connectAndListen() {
  IO.Socket socket = IO.io(
      apiUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('meeting_updated', (data) {
    print(data);
    return streamSocket.addResponse;
  });
  socket.onDisconnect((_) => print('disconnect'));

  socket.connect();
}

class OnGoingRequestController extends GetxController {
  IO.Socket? socket;
  @override
  void onInit() {
    super.onInit();
    connectAndListen();
  }

  // void connect() {
  //   socket =
  //       IO.io("https://socketio-chat-h9jt.herokuapp.com/", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket!.connect();
  //   socket!.onConnect((data) {
  //     print("Connected");
  //     socket!.on("message", (msg) {
  //       log(msg, name: "socket message");
  //     });
  //   });
  //   socket!.
  //   socket!.emit('sidheshwar', 'testing');
  //   update();
  //   print(" isconnect " + socket!.connected.toString());
  // }

  @override
  void onReady() {}
}

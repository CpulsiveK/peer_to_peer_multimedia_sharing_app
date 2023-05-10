import 'dart:io';

const String serverAddr = "192.168.46.103";
const int port = 5050;

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}



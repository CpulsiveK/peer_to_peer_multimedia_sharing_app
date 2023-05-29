import 'dart:io';

const waitTimeToSendData = 1;
const int indexerPort = 5050;

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

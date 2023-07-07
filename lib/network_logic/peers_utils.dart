import 'dart:io';

const waitTimeToSendData = 1;
const String defaultIndexerAddr = '192.168.67.103';
const int indexerPort = 5050;
const peerPort = 50000;
String peerAddr = InternetAddress.anyIPv4.address;

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

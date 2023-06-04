import 'dart:io';

const waitTimeToSendData = 1;
const String defaultIndexerAddr = '192.168.70.103';
const int indexerPort = 5050;
String peerAddr = InternetAddress.anyIPv4.address;
const peerPort = 50000;

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

import 'dart:io';

const waitTimeToSendData = 1;

Future<String?> getIndexerAddress() async {
  const int multicastPort = 10000;
  late String? serverAddr;

  var socket =
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, multicastPort);
  socket.joinMulticast(InternetAddress('224.0.0.1'));

  await socket.forEach((event) {
    if (event == RawSocketEvent.read) {
      final datagram = socket.receive();
      serverAddr = String.fromCharCodes(datagram!.data);
      socket.close();
    }
  });

  return serverAddr;
}

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

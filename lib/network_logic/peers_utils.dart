import 'dart:io';

const waitTimeToSendData = 1;
const int indexerPort = 5050;
String? indexerAddr;

Future<String> getIndexerAddress() async {
  const int multicastPort = 10000;
  late final String result;

  try {
    var socket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, multicastPort);
    socket.joinMulticast(InternetAddress('224.0.0.1'));

    await socket.forEach((event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        result = String.fromCharCodes(datagram!.data);
        socket.close();
      }
    });
  } catch (e) {
    rethrow;
  }
  return result;
}

void receiveIndexerAddr() async {
  indexerAddr = await getIndexerAddress();
}

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

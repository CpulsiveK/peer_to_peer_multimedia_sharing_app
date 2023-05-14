import 'dart:io';
import 'peers.dart';

const waitTimeToSendData = 1;
const int serverPort = 5050;

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

void instantiatePeer() async {
  final serverAddr = await getIndexerAddress();
  print("received indexer address as: $serverAddr");

  final peer = Peers(id: 'user0001', serverAddr: serverAddr, port: serverPort);
}

void sendRequestType({
  required Socket socket,
  required String requestType,
  required String id,
}) {
  socket.write("$id $requestType ");
}

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


Future<String> getIndexerAddr() async {
  String message = "indexer ip?";
  String indexerAddr = '';

  try {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) async {
      socket.broadcastEnabled = true; // Enable broadcasting

      // Convert the message to bytes
      List<int> messageBytes = message.codeUnits;

      while (indexerAddr.isEmpty) {
        // Broadcast the message to all devices on the LAN
        socket.send(messageBytes, InternetAddress('255.255.255.255'), 10000);
        print("Message broadcasted on the LAN");

        // Receive response
        await socket.forEach((event) {
          if (event == RawSocketEvent.read) {
            final datagram = socket.receive();
            String result = String.fromCharCodes(datagram!.data);

            socket.close();

            indexerAddr = result;
            print(indexerAddr);
          }
        });
      }
    }).catchError((e) {
      print("Error: $e");
    });
  } catch (e) {
    rethrow;
  }

  return indexerAddr;
}

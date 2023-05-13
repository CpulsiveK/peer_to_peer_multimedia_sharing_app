import 'dart:io';
import 'peers_utils.dart';

class Peers {
  final String id;
  final String? serverAddr;
  final int port;

  Peers({
    required this.id,
    required this.serverAddr,
    required this.port,
  });

  Future<void> makeFilesPublic({
    required List<String> files,
  }) async {
    try {
      final peerPocket = await Socket.connect(serverAddr, port);
      print('connected to indexer: $serverAddr');

      const requestType = 'makeFilePublic';

      sendRequestType(socket: peerPocket, requestType: requestType, id: id);

      Future.delayed(const Duration(seconds: waitTimeToSendData));

      int numberOfFiles = files.length;
      peerPocket.write('$numberOfFiles');

      Future.delayed(const Duration(seconds: waitTimeToSendData));

      for (String file in files) {
        peerPocket.write(file);
        await Future.delayed(const Duration(seconds: waitTimeToSendData));
      }

      await peerPocket.flush();
      await peerPocket.close();
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchPublicFiles({required String fileName}) async {
    try {
      final socket = await Socket.connect(serverAddr, port);
      print('connected to indexer: $serverAddr');
      
      const requestType = 'searchFile';

      sendRequestType(socket: socket, requestType: requestType, id: id);

      Future.delayed(const Duration(seconds: waitTimeToSendData));

      socket.write(fileName);

      await for (final data in socket) {
        final result = String.fromCharCodes(data).trim();
        print(result);
      }
    } catch (e) {
      print(e);
    }
  }
}

void main(List<String> args) async {
  const int serverPort = 5050;

  final String? serverAddr = await getIndexerAddress();
  print('received indexer ip: $serverAddr');

  final peer = Peers(id: 'user0001', serverAddr: serverAddr, port: serverPort);
  peer.makeFilesPublic(files: ['file1', 'file2']);
}

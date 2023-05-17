import 'dart:io';
import 'peers_utils.dart';

class Peers {
  final String id;
  final String? indexerAddr;
  final int port;

  Peers({
    required this.id,
    required this.indexerAddr,
    required this.port,
  });

  Future<void> makeFilesPublic({
    required List<String> files,
  }) async {
    try {
      final peerPocket = await Socket.connect(indexerAddr, port);
      print('connected to indexer: $indexerAddr');

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
      final socket = await Socket.connect(indexerAddr, port);
      print('connected to indexer: $indexerAddr');

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

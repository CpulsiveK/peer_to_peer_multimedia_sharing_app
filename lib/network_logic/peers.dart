import 'dart:convert';
import 'dart:io';

import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers_utils.dart';

class Peers {
  static Future<void> makeFilesPublic(
      {required Map fileInfo, required String id}) async {
    try {
      final peerSocket = await Socket.connect(defaultIndexerAddr, indexerPort);
      print('connected to indexer: $defaultIndexerAddr');

      const requestType = 'makeFilePublic';

      sendRequestType(socket: peerSocket, requestType: requestType, id: id);

      peerSocket.write(jsonEncode(fileInfo));

      await peerSocket.flush();
      await peerSocket.close();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> searchPublicFiles(
      {required String fileName, required String id}) async {
    try {
      final peerSocket = await Socket.connect(defaultIndexerAddr, indexerPort);
      print('connected to indexer: $defaultIndexerAddr');

      const requestType = 'searchFile';

      sendRequestType(socket: peerSocket, requestType: requestType, id: id);

      peerSocket.write(fileName);

      await for (final data in peerSocket) {
        final result = String.fromCharCodes(data).trim();
        print(result);
      }
    } catch (e) {
      print(e);
    }
  }
}

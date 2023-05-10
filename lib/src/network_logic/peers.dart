import 'dart:io';
import 'peers_utils.dart';

class Peers {
  Future<void> makeFilesPublic({
    required List<String> files,
    required String id,
  }) async {
    try {
      final socket = await Socket.connect(serverAddr, port);

      const requestType = 'makeFilePublic';
      sendRequestType(socket: socket, requestType: requestType, id: id);

      final numberOfFiles = files.length;
      socket.write('$numberOfFiles');

      for (String file in files) {
        socket.write(file);
        print('sent $file');
      }

      await socket.flush();
      await socket.close();
    } catch (e) {
      print(e);
    }
  }
}

void main(List<String> args) {
  Peers peers = Peers();
  peers.makeFilesPublic(files: [
    'file1',
    'file2'
  ], id: 'gh0001');
}

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

      int numberOfFiles = files.length;
      socket.write('$numberOfFiles');

      const waitTimeToSendFile = 2;

      for (String file in files) {
        socket.write(file);
        await Future.delayed(const Duration(seconds: waitTimeToSendFile));
      }

      await socket.flush();
      await socket.close();
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchPublicFiles(
      {required String fileName, required String id}) async {
    try {
      final socket = await Socket.connect(serverAddr, port);

      const requestType = 'searchFile';
      sendRequestType(socket: socket, requestType: requestType, id: id);

      socket.write(fileName);

      // socket.listen((data) {
      //   final result = String.fromCharCodes(data);
      //   print(result);
      // });

      await for (final data in socket) {
        final result = String.fromCharCodes(data).trim();
        print(result);
      }
    } catch (e) {
      print(e);
    }
  }
}

void main(List<String> args) {
  final peers = Peers();
  peers.searchPublicFiles(fileName: 'file1', id: 'user001');
  // peers.makeFilesPublic(files: ['file1', 'file2'], id: 'gh001');
}

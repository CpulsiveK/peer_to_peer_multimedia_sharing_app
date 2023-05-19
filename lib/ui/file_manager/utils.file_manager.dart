import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'homepage.file_manager.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () => createFolder(context),
        icon: const Icon(Icons.create_new_folder_outlined),
      ),
      IconButton(
        onPressed: () => sort(context),
        icon: const Icon(Icons.sort_rounded),
      ),
      IconButton(
        onPressed: () => selectStorage(context),
        icon: const Icon(Icons.sd_storage_rounded),
      )
    ],
    title: ValueListenableBuilder<String>(
      valueListenable: HomePage.controller.titleNotifier,
      builder: (context, title, _) => Text(title),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () async {
        if (await HomePage.controller.isRootDirectory() == true) {
          Navigator.pop(context);
        }
        
        await HomePage.controller.goToParentDirectory();
      },
    ),
  );
}

Widget subtitle(FileSystemEntity entity) {
  return FutureBuilder<FileStat>(
    future: entity.stat(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (entity is File) {
          int size = snapshot.data!.size;

          return Text(
            FileManager.formatBytes(size),
          );
        }
        return Text(
          "${snapshot.data!.modified}".substring(0, 10),
        );
      } else {
        return const Text("");
      }
    },
  );
}

Future<void> selectStorage(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: FutureBuilder<List<Directory>>(
        future: FileManager.getStorageList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<FileSystemEntity> storageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: storageList
                      .map((e) => ListTile(
                            title: Text(
                              FileManager.basename(e),
                            ),
                            onTap: () {
                              HomePage.controller.openDirectory(e);
                              Navigator.pop(context);
                            },
                          ))
                      .toList()),
            );
          }
          return const Dialog(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}

sort(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: const Text("Name"),
                onTap: () {
                  HomePage.controller.sortBy(SortBy.name);
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text("Size"),
                onTap: () {
                  HomePage.controller.sortBy(SortBy.size);
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text("Date"),
                onTap: () {
                  HomePage.controller.sortBy(SortBy.date);
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text("type"),
                onTap: () {
                  HomePage.controller.sortBy(SortBy.type);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    ),
  );
}

createFolder(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController folderName = TextEditingController();
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: TextField(
                  controller: folderName,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Create Folder
                    await FileManager.createFolder(
                        HomePage.controller.getCurrentPath, folderName.text);
                    // Open Created Folder
                    HomePage.controller.setCurrentPath =
                        "${HomePage.controller.getCurrentPath}/${folderName.text}";
                  } catch (e) {}

                  Navigator.pop(context);
                },
                child: const Text('Create Folder'),
              )
            ],
          ),
        ),
      );
    },
  );
}

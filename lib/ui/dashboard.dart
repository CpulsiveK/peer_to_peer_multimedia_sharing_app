import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // String? id;
  // String? indexerAddr;

  final TextEditingController _controller = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    // final arguements =
    //     ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    // id = arguements[0] as String?;
    // indexerAddr = arguements[1] as String?;

    _controller.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {
      _searchText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.indigo.shade900),
                  prefixIcon: Icon(color: Colors.indigo.shade900, Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(color: Colors.indigo.shade900, Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      _onSearchTextChanged();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 50,
                itemBuilder: ((context, index) {}),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade900,
        onPressed: () async {
          final PermissionStatus status = await Permission.storage.request();
          debugPrint("[PERMISSION]: $status");

          Navigator.pushNamed(context, 'file_manager');
        },
        child: const Icon(color: Colors.white, Icons.share),
      ),
    );
  }
}

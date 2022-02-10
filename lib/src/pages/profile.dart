import 'package:blood_71/src/theme/drawer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List _files;
  Future _openFileExplorer() async {
    _files = (await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      allowedExtensions: null,
    ))!.files;

    print('Loaded file path is ${_files!.first.path}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Blood 71'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: (){
                _openFileExplorer();
              },
              child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/nobody.png'),
                  backgroundColor: Colors.white,
                  radius: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



import 'package:attendance/view/attendance.dart';
import 'package:attendance/view/members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/file_operations.dart';
import '../user_permissions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPermissions permissions = UserPermissions();
  FileOperations excelFiles = ExcelFiles();
  int? groupValue = 0;
  double textSize = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Flexible(
                      child: Text(
                        "\t\t_auth.currentUser?.displayName}",
                        style: TextStyle(fontSize: 20, color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Attendance",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => browse()));
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.white,
                thumbColor: CupertinoColors.systemYellow,
                padding: const EdgeInsets.all(8),
                groupValue: groupValue,
                children: {
                  0: Text(
                    "Attendance",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                  1: Text(
                    "Members",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                  2: Text(
                    "Statistics",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            ),
            (groupValue == 0) ? Attendance() : const SizedBox(),
            (groupValue == 1) ? Members() : const SizedBox(),
            (groupValue == 2) ? Text("$groupValue") : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> checkPermission() async {
    await permissions.storagePermission();
    if (permissions.storageStatus.toString().contains('granted')) {
      final file = await excelFiles.selectFile();

      // _counter =
      await excelFiles.readContent(file);
    }
  }
}

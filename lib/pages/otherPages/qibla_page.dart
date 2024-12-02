import 'package:flutter/material.dart';
import 'package:iccmw/features/app_theme/utils/app_theme_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:iccmw/features/qiblah_page/presentation/pages/qiblah_screen.dart';

class QiblahPage extends StatefulWidget {
  const QiblahPage({super.key});

  @override
  State<QiblahPage> createState() => QiblahPageState();
}

class QiblahPageState extends State<QiblahPage> {
  bool hasPermission = false;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then(
          (value) {
            setState(() {
              hasPermission = (value == PermissionStatus.granted);
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackgroundColor,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: appBarColor,

        title: Row(
          children: [
            Image(
              image: AssetImage('assets/images/icons/qibla.png'),
              width: 24.0,
              height: 24.0,
            ),
            SizedBox(width: 8.0),
            Text(
              "Qilblah",
              style: TextStyle(
                color: appBarTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBarIconColor,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPermission(),
        builder: (context, snapshot) {
          if (hasPermission) {
            return const QiblahScreen();
          } else {
            return const Center(
              child: Text('Qiblah not working in your mobile'),
            );
          }
        },
      ),
    );
  }
}

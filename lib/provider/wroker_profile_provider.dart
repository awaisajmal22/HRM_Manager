import 'dart:io';

import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/worker_profile_model.dart';
import 'package:hrm_manager/Network/Server/permission_handler.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/app_text.dart';

class WorkerProfileProvider extends ChangeNotifier {
  List<String> documentList = <String>[
    'WHIM',
    'Working Form Height',
    "First Aid",
  ];
  WorkerProfileModel workerProfileModel = WorkerProfileModel(
    name: "Awais",
    price: "\$47.00/hr",
    trade: 'Carpenter',
    status: 'Now on Site',
    dob: '1988, Dec 27',
    experience: '6 Years of high rise, 5 commercial, 2 years drywall',
    previousEmployment: 'MCF, Structform, Supplier',
    unionAffiliation: '183, Local 27',
    flag: 'No papers',
    transportation: 'Yes',
    specialTickets: 'No',
    note: '',
    certificate: '',
    home: 'Toronto (King & Young)',
  );
// DateTime date = DateTime.now();
//   void generateCsvFile({required BuildContext context}) async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();

//     List<List<dynamic>> rows = [];

//     List<dynamic> row = [];
//     List<dynamic> row2 = [];
//     row.add("Name");
//     row.add("Price");
//     row.add("Trade");
//     row.add("Status");
//     row.add("Date of birth");
//     row.add('Experience');
//     row.add('Previous Employment');
//     row.add('Union Affiliation');
//     row.add('Flag');
//     row.add('Transportation');
//     row.add('Home');
//     row.add('Certificates');
//     row.add('Special Tickets');
//     row.add('Note');
//     row2.add(workerProfileModel.name);
//     row2.add(workerProfileModel.price);
//     row2.add(workerProfileModel.status!);
//     row2.add(workerProfileModel.trade);
//     row2.add(workerProfileModel.dob);
//     row2.add(workerProfileModel.experience);
//     row2.add(workerProfileModel.previousEmployment);
//     row2.add(workerProfileModel.unionAffiliation);
//     row2.add(workerProfileModel.flag);
//     row2.add(workerProfileModel.transportation);
//     row2.add(workerProfileModel.home);
//     row2.add(workerProfileModel.certificate);
//     row2.add(workerProfileModel.specialTickets);
//     row2.add(workerProfileModel.note);
//     rows.add(row);
//     rows.add(row2);

//     String csv = const ListToCsvConverter().convert(rows);

//     String dir = await ExternalPath.getExternalStoragePublicDirectory(
//         ExternalPath.DIRECTORY_DOWNLOADS);
//     print("dir $dir");
//     String file = "$dir";

//     File f = File("$file/${workerProfileModel.name}HRMfile.csv");
// //${workerProfileModel.name}${DateFormat.yMMMMd(date).toString()}-${DateFormat.jms(date).toString()}-
//     f.writeAsString(csv).then((val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: appText(
//       context: context,
//       title: 'File Exported Successfully',
//       textColor: AppColor.whiteColor,
//     ))));

//   }

  generateCsvFile({required BuildContext context}) async {
    Directory directory;
    String dateTime = DateTime.now().toIso8601String();
    List<String> date = dateTime.split(':');
    String joinDate = date.join('');
    List<String> removeDot = joinDate.split('.');
    String join2 = removeDot.join('');
    print(join2);
    try {
      List<List<dynamic>> rows = [];

      List<dynamic> row = [];
      List<dynamic> row2 = [];
      row.add("Name");
      row.add("Price");
      row.add("Trade");
      row.add("Status");
      row.add("Date of birth");
      row.add('Experience');
      row.add('Previous Employment');
      row.add('Union Affiliation');
      row.add('Flag');
      row.add('Transportation');
      row.add('Home');
      row.add('Certificates');
      row.add('Special Tickets');
      row.add('Note');
      row2.add(workerProfileModel.name);
      row2.add(workerProfileModel.price);
      row2.add(workerProfileModel.status!);
      row2.add(workerProfileModel.trade);
      row2.add(workerProfileModel.dob);
      row2.add(workerProfileModel.experience);
      row2.add(workerProfileModel.previousEmployment);
      row2.add(workerProfileModel.unionAffiliation);
      row2.add(workerProfileModel.flag);
      row2.add(workerProfileModel.transportation);
      row2.add(workerProfileModel.home);
      row2.add(workerProfileModel.certificate);
      row2.add(workerProfileModel.specialTickets);
      row2.add(workerProfileModel.note);
      rows.add(row);
      rows.add(row2);

      String csv = const ListToCsvConverter().convert(rows);

      if (Platform.isAndroid) {
        if (await requestPermission()) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";

          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/HRM";
          directory = Directory(newPath);
          print(directory.path);
        } else {
          return false;
        }
      } else {
        if (await requestPermission()) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      File saveFile =
          File("${directory.path}/${workerProfileModel.name}-$join2-HRM.csv");
      if (!await directory.exists()) {
        await directory
            .create(
              recursive: true,
            )
            .then((value) => saveFile.writeAsString(csv).then(
                (val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: appText(
                      context: context,
                      title: 'File Exported Successfully',
                      textColor: AppColor.whiteColor,
                    )))));
        print('Directory Created');
      }
      if (await directory.exists()) {
        saveFile
            .writeAsString(csv)
            .then((val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: appText(
                  context: context,
                  title: 'File Exported Successfully',
                  textColor: AppColor.whiteColor,
                ))));

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  
}

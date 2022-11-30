import 'dart:io';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

class SearchState extends ChangeNotifier{
  String selected = 'Name';
  List<String> menus = [
    "Name",
    "Description",
    "Project",
    "Reservation",
    "Tags",
    "Date",
    "Reference",
  ];
  var query = TextEditingController();
  void onSelect(value){
    selected = value;
    notifyListeners();
  }
}
class SearchController extends GetxController{

  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  var query = TextEditingController();
  var fileName = TextEditingController(text: appName);
  RxString selected = 'Name'.obs;
  List<String> menus = [
    "Name",
    "Description",
    "Project",
    "Reservation",
    "Tags",
    "Date",
    "Reference",
  ];

  void onChange(text){
    update();
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<void> exportDataGridToExcel() async {
    final path = await _localPath;
    final workbook = key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    if(fileName.text.isNotEmpty){
      try{
        File('$path/${fileName.text.trim()}.xlsx').writeAsBytes(bytes);
        handleSnackBar("Save File","File Save in Documents Directory",Colors.green);
        workbook.dispose();
      }catch(e){
        handleSnackBar("Failed","Already Exists",Colors.red);
        print(e);
      }
    }else{
      try{
        File('$path/${fileName.text.trim()}.xlsx').writeAsBytes(bytes);
        handleSnackBar("Save File","File Save in Documents Directory",Colors.green);
        workbook.dispose();
      }catch(e){
        handleSnackBar("Failed","Already Exists",Colors.red);
        print(e);
      }
    }
  }
  void dialogToGetFileName(width){
    Get.dialog(
        Dialog(
          backgroundColor: lightBackgroundColor,
          child: Container(
            margin: const EdgeInsets.only(left: 10,top: 10),
            height: 135,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter File Name",style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: fileName,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "File Name",
                        suffixIcon: GestureDetector(
                          onTap: () => fileName.clear(),
                          child: const Icon(Icons.clear),
                        )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text("Cancel")
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 225, 1),)
                        ),
                        onPressed: () => exportDataGridToExcel(),
                        child: const Text("Save File")),
                    const SizedBox(width: 10,),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
  void onSelect(value){
    selected(value);
    query.clear();
    update();
  }
  void handleSnackBar(title,context,color){
    Get.snackbar(title,context,
      borderRadius: 8.0,
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
      backgroundColor: color,
      duration: const Duration(seconds: 6),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
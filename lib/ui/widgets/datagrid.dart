
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epp_film/cors/item.controller.dart';
import 'package:epp_film/models/m_item.dart';
import 'package:epp_film/provider/searchstate.dart';
import 'package:epp_film/ui/page/imageview.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGrid extends StatefulWidget {
  final UserDataSource userDataSource;
  const DataGrid({Key? key,required this.userDataSource}) : super(key: key);
  @override
  State<DataGrid> createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  final search = Get.put(SearchController());
  final DataGridController _dataGridController = DataGridController();
  final itemCon = Get.put(ItemController());
  final upDateText = TextEditingController();
  late Map<String, double> columnWidths;
  String  id = "";
  String values = "";
  @override
  void initState() {
    columnWidths = {
      'id': double.nan,
      'name': double.nan,
      'designation': double.nan,
      'salary': double.nan
    };
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: search,
      builder: (_) => SfDataGridTheme(
        data: SfDataGridThemeData(headerColor: const Color.fromRGBO(0, 0, 255, 1)),
        child: SfDataGrid(
          key: search.key,
          controller: _dataGridController,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columnWidthMode: ColumnWidthMode.fill,
          horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
          source: widget.userDataSource,
          allowColumnsResizing: true,
          isScrollbarAlwaysShown: true,
          allowPullToRefresh: true,
          onCellTap: (DataGridCellDetails details){
            String field = details.column.columnName;
            if (details.rowColumnIndex.rowIndex != 0) {
              int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
              var row = widget.userDataSource.effectiveRows.elementAt(selectedRowIndex);
              id = row.getCells()[0].value.toString();
              if(field == "Image"){
                Get.to(() => ImageViewPage(id: id));
              }else{
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        backgroundColor: lightBackgroundColor,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        content: SizedBox(
                          height: 120,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(field),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextField(
                                    controller: upDateText,
                                    cursorColor: Colors.black45,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(onTap: (){Navigator.pop(context);}, child: const Text("Cancel")),
                                    const SizedBox(width: 8,),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.red,)
                                        ),
                                        onPressed: (){
                                          Navigator.pop(context);
                                          itemCon.deleteItem(id: id);
                                        }, child: const Text("Delete")),
                                    const SizedBox(width: 8,),
                                    ElevatedButton(
                                        onPressed: (){
                                          if(upDateText.text.isNotEmpty){
                                            itemCon.updateItem(id: id,field: field, data: upDateText.text);
                                            Navigator.pop(context);
                                          }
                                        }, child: const Text("Update")),
                                  ],
                                ),
                              ]
                          ),
                        )
                    )
                );
              }
            }
          },
          onColumnResizeStart: (ColumnResizeStartDetails details) {
            // Disable resizing for the `id` column.
            if (details.column.columnName == 'id') {
              return false;
            }
            return true;
          },
          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
            setState(() {
              columnWidths[details.column.columnName] = details.width;
            });
            return true;
          },
          highlightRowOnHover: true,
          allowEditing: true,
          selectionMode: SelectionMode.single,
          navigationMode: GridNavigationMode.cell,

          columns: <GridColumn>[
            GridColumn(
              width: columnWidths["id"]??100,
              columnName: "id",
              visible: false,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('id',style: TextStyle(color: Colors.white),),
              ),
            ),
            GridColumn(
              width: columnWidths["Image"]??100,
              columnName: "Image",
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Image',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              ),
            ),
            GridColumn(
              columnName: "Name",
              width: columnWidths["Name"]??100,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Name',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Description"]??100,
              columnName: "Description",
              label: Container(
                padding: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                child: const Text('Description',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Project"]??100,
              columnName: "Project",
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Project',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Reservation"]??100,
              columnName: "Reservation",
              label: Container(
                padding: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                child: const Text('Reservation',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Tags"]??100,
              columnName: "Tags",
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Tags',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Date"]??100,
              columnName: "Date",
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Date',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
            GridColumn(
              width: columnWidths["Reference"]??100,
              columnName: "Reference",
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text('Reference',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class UserDataSource extends DataGridSource {
  final search = Get.put(SearchController());
  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (column.columnName == 'id') {
      print("Here");
      return false;
    } else {
      return true;
    }
  }
  @override
  bool onCellBeginEdit(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    if (column.columnName == 'id') {
      // Return false, to restrict entering into the editing.
      return false;
    } else {
      return true;
    }
  }

  UserDataSource(this.currentUserInfo) {
    _buildDataRow();
  }

  List<DataGridRow> users = [];
  List<MItem> currentUserInfo;

  void _buildDataRow() {
    users = currentUserInfo.map<DataGridRow>((e) => DataGridRow(
      cells: [
        DataGridCell<String>(
          columnName: "id",
          value: e.id
          ,
        ),
        DataGridCell<String>(
          columnName: "Image",
          value: e.image,
        ),
        DataGridCell<String>(
          columnName: "Name",
          value: e.name,
        ),
        DataGridCell(
          columnName: "Description",
          value: e.description,
        ),
        DataGridCell(
          columnName: "Project",
          value: e.project,
        ),
        DataGridCell(
          columnName: "Reservation",
          value: e.reservation,
        ),
        DataGridCell(
          columnName: "Tags",
          value: e.tags,
        ),
        DataGridCell(
          columnName: "Date",
          value: e.date,
        ),
        DataGridCell(
          columnName: "Reference",
          value: e.reference,
        ),
      ],
    )).toList();
  }

  @override
  List<DataGridRow> get rows => users;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return e.columnName =="Image"? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(e.value)
              ),
            ),
          ) :GetBuilder(
            init: search,
            builder: (_) => search.query.text.isEmpty? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            ):e.columnName == search.selected.value?Directionality(
                textDirection: TextDirection.ltr,
                child: SubstringHighlight(
                  text: e.value,
                  term: search.query.text,
                ),
            ):Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            ),
          );
        }).toList());
  }
}
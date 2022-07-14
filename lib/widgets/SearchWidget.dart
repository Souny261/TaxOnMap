import 'package:easy_tax_map/helper/Laoder.dart';
import 'package:easy_tax_map/main.dart';
import 'package:easy_tax_map/models/ProvineModel.dart';
import 'package:easy_tax_map/models/tax.dart';
// import 'package:easy_tax_map/models/TaxModel.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller = TextEditingController();
  Helpers _helpers = Helpers();
  String latlng = "";
  late var e;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Locations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.arrow_drop_down,
            size: 45,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onSubmitted: ((_) async {
                  if (_controller.text.isNotEmpty) {
                    e = mainProvider.taxData?.data!
                        .where((element) => element.tIN == _controller.text)
                        .first as Data;
                    // showAnimatedDialog(
                    //   context: context,
                    //   barrierDismissible: true,
                    //   builder: (BuildContext context) {
                    //     return Material(
                    //       type: MaterialType.transparency,
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         child: Stack(
                    //           children: [
                    //             Container(
                    //               width:
                    //                   MediaQuery.of(context).size.width / 2,
                    //               height: MediaQuery.of(context).size.height /
                    //                   1.2,
                    //               margin: const EdgeInsets.all(8.0),
                    //               padding: const EdgeInsets.all(20.0),
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(15.0),
                    //                 color: Colors.white,
                    //               ),
                    //               child: Column(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Text(
                    //                     "ລາຍລະອຽດ",
                    //                     style: TextStyle(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                   Divider(
                    //                     color: Colors.blue,
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ເລກປະຈຳຕົວຜູ່ເສຍອາກອນ:"),
                    //                         Text(
                    //                           e.tin!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ບາໂຄດ:"),
                    //                         Text(
                    //                           e.barcode!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ຊື່ວິສາຫະກິດ:"),
                    //                         Text(
                    //                           e.name!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ຊື່ບ້ານ:"),
                    //                         Text(
                    //                           e.village!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ປະເພດການຖືບັນຊີ:"),
                    //                         Text(
                    //                           e.accType!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                             "ປະເພດອາກອນມຸນຄ່າເພີ່ມຂອງວິສາຫະກິດ:"),
                    //                         Text(
                    //                           e.taxType!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ປະເພດທຸລະກິດ:"),
                    //                         Text(
                    //                           e.busType!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ປະເພດທຸລະກິດຫລັກ:"),
                    //                         Text(
                    //                           e.mainBusTpye!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ປະເພດທຸລະກິດ LSIC ຫຼັກ:"),
                    //                         Text(
                    //                           e.busTypeLSIC!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ວັນທີອອກ​ໃບ​ແຈ້ງ:"),
                    //                         Text(
                    //                           e.issueDate!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ປະເພດອາກອນ:"),
                    //                         Text(
                    //                           e.type!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ເຫດຜົນການຊຳລະ:"),
                    //                         Text(
                    //                           e.description!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ຈຳນວນເງິນ(ກີບ):"),
                    //                         Text(
                    //                           _helpers.customCurrency(
                    //                               e.taxAmount!.toString()),
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ອາກອນຄົງຄ້າງ:"),
                    //                         Text(
                    //                           _helpers.customCurrency(
                    //                               e.debitTax!.toString()),
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ສະຖານະ:"),
                    //                         Text(
                    //                           e.status!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ວັນທີຈ່າຍ:"),
                    //                         Text(
                    //                           e.dates!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ເມືອງ:"),
                    //                         Text(
                    //                           e.district!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(4.0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("ແຂວງ:"),
                    //                         Text(
                    //                           e.province!,
                    //                           style: TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //             Positioned(
                    //                 right: 8,
                    //                 child: IconButton(
                    //                   onPressed: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                   icon: Icon(
                    //                     Icons.cancel,
                    //                     color: Colors.red,
                    //                     size: 30,
                    //                   ),
                    //                 ))
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   animationType: DialogTransitionType.slideFromTop,
                    //   curve: Curves.fastOutSlowIn,
                    //   duration: Duration(seconds: 1),
                    // )
                    //     .whenComplete(() =>
                   mainProvider.setSearchData(e);
                    mainProvider.moveMap(
                        e.lOCATION!.split(",")[0], e.lOCATION!.split(",")[1]);
                        // setState(() {
                        //   latlng = "kk";
                        // });
                    
                  } else {
                    mainProvider.loadData();
                    // setState(() {
                    //       latlng = "gg";
                    //     });
                  }
                }),
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.18,
            decoration: BoxDecoration(
                border:
                    Border(right: BorderSide(width: 1, color: Colors.blue))),
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: mainProvider.provinceModel!.data!.length,
                itemBuilder: (context, index) {
                  ProvinceData data = mainProvider.provinceModel!.data![index];
                  // print(data.provinceName);
                  return Card(
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value) {
                          // mainProvider.setProvinceData(data.code);
                          mainProvider.moveMap(
                              data.lat.toString(), data.lng.toString());
                        }
                      },
                      title: Text(
                        data.provinceName!,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      // children: data.districtList!.map((e) {
                      //   return Text(e.district!);
                      // }).toList(),

                      children: ListTile.divideTiles(
                          color: Colors.blue.shade100,
                          context: context,
                          tiles: data.districtList!.map(
                            (e) => ListTile(
                              onTap: () {
                                // mainProvider.setDistrictData(e.code);
                                mainProvider.moveMap(e.lat!, e.lng!);
                              },
                              title: Text(e.district!),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                      Text(e.code! == "0101"
                                          ? "${mainProvider.taxData?.data?.where((element) => element.statusNumber! < 0).length.toString() ?? 0}"
                                          : "0")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.yellow,
                                        size: 10,
                                      ),
                                      Text(e.code! == "0101"
                                          ? "${mainProvider.taxData?.data?.where((element) => element.statusNumber! > 0).length.toString() ?? 0}"
                                          : "0")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 10,
                                      ),
                                      Text(e.code! == "0101"
                                          ? "${mainProvider.taxData?.data?.where((element) => element.statusNumber == 0).length.toString() ?? 0}"
                                          : "0")
                                    ],
                                  )
                                ],
                              ),
                              // subtitle: Text(
                              //   e.code! == "0101"
                              //       ? "${mainProvider.taxData!.data!.length.toString()}"
                              //       : "0",
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.blue),
                              // ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 15,
                              ),
                            ),
                          )).toList(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

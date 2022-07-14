// import 'package:easy_tax_map/helper/Laoder.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_tax_map/helper/Laoder.dart';
import 'package:easy_tax_map/pages/ReportPage.dart';
import 'package:easy_tax_map/provider/LocationProvider.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:easy_tax_map/widgets/zoombuttons_plugin_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

class CreatedMapWidget extends StatefulWidget {
  const CreatedMapWidget({Key? key}) : super(key: key);

  @override
  _CreatedMapWidgetState createState() => _CreatedMapWidgetState();
}

class _CreatedMapWidgetState extends State<CreatedMapWidget> {
  double zoom = 10.0;
  Helpers _helpers = Helpers();
  var tin;
  var isShowImage = true;

  @override
  void initState() {
    super.initState();
    // final channel = HtmlWebSocketChannel.connect("ws://172.28.14.87:8765");
    final channel = HtmlWebSocketChannel.connect("wss://io.mmoney.la");
    channel.stream.listen((message) {
      Provider.of<MainProvider>(context, listen: false).loadData();
      Provider.of<MainProvider>(context, listen: false).loadSubData(tin);
      print("success");
    });
  }

  getPin(status, tintype) {
    if (status == 0 && tintype == "[01]ວິສາຫະກິດສ່ວນບຸກຄົນ") {
      return Image.asset("assets/images/icons8-done.png");
    } else if (status == 0 && tintype == "[23]ຫົວ​ໜ່ວຍ​ຄ່າ​ເຊົ່າ") {
      return Image.asset("assets/images/home-done.png");
    } else if (status > 0 && tintype == "[01]ວິສາຫະກິດສ່ວນບຸກຄົນ") {
      // print("yello");
      return Image.asset("assets/images/icons8-warning.png");
    } else if (status > 0 && tintype == "[23]ຫົວ​ໜ່ວຍ​ຄ່າ​ເຊົ່າ") {
      return Image.asset("assets/images/home-warning.png");
    } else if (status < 0 && tintype == "[01]ວິສາຫະກິດສ່ວນບຸກຄົນ") {
      return Image.asset("assets/images/icons8-Red.png");
    } else if (status < 0 && tintype == "[23]ຫົວ​ໜ່ວຍ​ຄ່າ​ເຊົ່າ") {
      return Image.asset("assets/images/home-red.png");
    }
  }

  Uint8List imageFromBase64String(String base64String) {
    return base64.decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    return Container(
      child: Stack(
        children: [
          FlutterMap(
            mapController: mainProvider.mapController,
            nonRotatedLayers: [
              ZoomButtonsPluginOption(
                maxZoom: 19,
                mini: true,
                padding: 16,
                alignment: Alignment.topRight,
              )
            ],
            options: MapOptions(
              boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
              onTap: (value) {
                // qrProvider.saveFormLat(latReq: value.latitude.toString());
                // qrProvider.saveFormLon(
                //     lonReq: value.longitude.toString());
                // setState(() {
                //   lat = value.latitude;
                //   lon = value.longitude;
                // });
              },
              center: LatLng(locationProvider.latLngPosition!.latitude,
                  locationProvider.latLngPosition!.longitude),
              zoom: zoom,
              plugins: [
                ZoomButtonsPlugin(),
              ],
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/souny/cksd9gocg31wg19mu66lqwzrt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic291bnkiLCJhIjoiY2tzZDUxYmM3MG4zejJ3bWN6dXNucTVndyJ9.iyjQ3aysiIRpzzZ_pBKBJg",
                additionalOptions: {
                  "accessToken":
                      "pk.eyJ1Ijoic291bnkiLCJhIjoiY2tzZDUxYmM3MG4zejJ3bWN6dXNucTVndyJ9.iyjQ3aysiIRpzzZ_pBKBJg",
                  "id": "mapbox.mapbox-streets-v8"
                },
              ),
              MarkerLayerOptions(
                markers: mainProvider.taxData!.data == null
                    ? []
                    : mainProvider.taxData!.data!
                        .map(
                          (e) => Marker(
                            point: LatLng(
                                double.parse(
                                    e.lOCATION!.split(",")[0].toString()),
                                double.parse(
                                    e.lOCATION!.split(",")[1].toString())),
                            builder: (ctx) => InkWell(
                              onTap: () async {
                                setState(() {
                                  tin = e.tIN;
                                });

                                await mainProvider.loadSubData(e.tIN);
                                var data = mainProvider.taxDetail!.data![0];
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.2,
                                                  margin:
                                                      const EdgeInsets.all(8.0),
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.white,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "ລາຍລະອຽດ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Divider(
                                                        color: Colors.blue,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "ເລກປະຈຳຕົວຜູ່ເສຍອາກອນ:"),
                                                            Text(
                                                              data.tIN!,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text("ຊື່:"),
                                                            Text(
                                                              data.tINNAME!,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "ເລກປະເພດກູ່ມຜູ່ເສຍອາກອນ:"),
                                                            Text(
                                                              data.tINTYPEGROUP!,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "ຈຳນວນທີ່ຕ້ອງຈ່າຍທັງໝົດ:"),
                                                            Text(
                                                              _helpers.customCurrency(
                                                                  data.tOTALTAXES !=
                                                                          ""
                                                                      ? data
                                                                          .tOTALTAXES!
                                                                      : "0"),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text("ສະຖານະ:"),
                                                            Text(
                                                              data.sTATUS!,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text("ຊຳລະແລ້ວ:"),
                                                            Text(
                                                              _helpers.customCurrency(
                                                                  data.totalPaid !=
                                                                          null
                                                                      ? data
                                                                          .totalPaid!
                                                                          .toString()
                                                                      : "0.0"),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text("ບາໂຄດ"),
                                                            // Text(
                                                            //   data.totalPaid!
                                                            //       .toString(),
                                                            //   style: TextStyle(
                                                            //       fontWeight:
                                                            //           FontWeight.bold),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text(
                                                      //           "ປະເພດອາກອນມຸນຄ່າເພີ່ມຂອງວິສາຫະກິດ:"),
                                                      //       Text(
                                                      //         e.taxType!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ປະເພດທຸລະກິດ:"),
                                                      //       Text(
                                                      //         e.busType!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ປະເພດທຸລະກິດຫລັກ:"),
                                                      //       Text(
                                                      //         e.mainBusTpye!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text(
                                                      //           "ປະເພດທຸລະກິດ LSIC ຫຼັກ:"),
                                                      //       Text(
                                                      //         e.busTypeLSIC!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ວັນທີອອກ​ໃບ​ແຈ້ງ:"),
                                                      //       Text(
                                                      //         e.issueDate!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ປະເພດອາກອນ:"),
                                                      //       Text(
                                                      //         e.type!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ເຫດຜົນການຊຳລະ:"),
                                                      //       Text(
                                                      //         e.description!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ຈຳນວນເງິນ(ກີບ):"),
                                                      //       Text(
                                                      //         _helpers.customCurrency(e
                                                      //             .taxAmount!
                                                      //             .toString()),
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ອາກອນຄົງຄ້າງ:"),
                                                      //       Text(
                                                      //         _helpers.customCurrency(e
                                                      //             .debitTax!
                                                      //             .toString()),
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ສະຖານະ:"),
                                                      //       Text(
                                                      //         e.status!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ວັນທີຈ່າຍ:"),
                                                      //       Text(
                                                      //         e.dates!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ເມືອງ:"),
                                                      //       Text(
                                                      //         e.district!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(4.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text("ແຂວງ:"),
                                                      //       Text(
                                                      //         e.province!,
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight.bold),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3.3,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3.7),
                                                child: data.bARCODES!.length > 0
                                                    ? ListView.builder(
                                                        itemCount:
                                                            data.bARCODES !=
                                                                    null
                                                                ? data.bARCODES!
                                                                    .length
                                                                : 0,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          var item = data
                                                              .bARCODES![index];
                                                          return Container(
                                                            child: Row(
                                                              children: [
                                                                Text(item
                                                                    .barcode!),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    "ທັງໝົດ: "),
                                                                Text(_helpers
                                                                    .customCurrency(item
                                                                        .total!
                                                                        .toString())),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    "ຄົງຄ້າງ: "),
                                                                Text(_helpers
                                                                    .customCurrency(item
                                                                        .debitTotal!
                                                                        .toString())),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  item.statusCode ==
                                                                          0
                                                                      ? "ຍັງບໍ່ທັນຈ່າຍ"
                                                                      : "ຈ່າຍແລ້ວ",
                                                                  style: TextStyle(
                                                                      color: item.statusCode == 1
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .red),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        })
                                                    : Text("ຍັງບໍ່ມີ"),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 265, left: 400),
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.memory(
                                                        imageFromBase64String(
                                                            data.iMAGE!),
                                                        height: 250),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 8,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  animationType:
                                      DialogTransitionType.slideFromTop,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 1),
                                );
                              },
                              child: Tooltip(
                                  message: "${e.tINNAME}",
                                  decoration: BoxDecoration(color: Colors.blue),
                                  padding: EdgeInsets.all(5),
                                  textStyle: TextStyle(color: Colors.white),
                                  // decoration: BoxDecoration(
                                  //     color: Color(int.parse(
                                  //         "${e.color}".replaceAll('#', '0xff'))),
                                  //     borderRadius: BorderRadius.circular(10)),
                                  // child: Icon(
                                  //   Icons.location_on_sharp,
                                  //   color: e.statusCode == 0
                                  //       ? Colors.red
                                  //       : e.statusCode == 1
                                  //           ? Colors.yellow
                                  //           : Colors.green,
                                  //   size: 25.0,
                                  // ),
                                  child:
                                      getPin(e.statusNumber, e.tINTYPEGROUP)),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
          Positioned(
              top: 5,
              left: 16,
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ຍັງບໍ່ແຈ້ງອາກອນ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ຍັງບໍ່ຈ່າຍ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ຈ່າຍແລ້ວ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ReportPage()));
                      },
                      color: Colors.blue,
                      child: Text(
                        "ລາຍງານ",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              right: 16,
              bottom: 20,
              child: FloatingActionButton(
                mini: true,
                heroTag: 'zoomInButton',
                onPressed: () async {
                  mainProvider.moveMap(
                      locationProvider.latLngPosition!.latitude.toString(),
                      locationProvider.latLngPosition!.longitude.toString());
                  // mapController!.move(
                  //     LatLng(locationProvider.latLngPosition!.latitude,
                  //         locationProvider.latLngPosition!.longitude),
                  //     16);
                },
                child:
                    Icon(Icons.location_searching_sharp, color: Colors.white),
              )),
        ],
      ),
    );
  }
}

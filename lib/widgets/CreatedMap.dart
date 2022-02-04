// import 'package:easy_tax_map/helper/Laoder.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final channel = HtmlWebSocketChannel.connect("ws://172.28.14.87:8765");
    // channel.stream.listen((open) {
    //   print("connected");
    // });

    channel.stream.listen((message) {
      
      Provider.of<MainProvider>(context,listen: false).loadData();
      print("success");
    });
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
                markers: mainProvider.taxData!.data!
                    .map(
                      (e) => Marker(
                        point: LatLng(double.parse(e.locations!.split(",")[1]),
                            double.parse(e.locations!.split(",")[0])),
                        builder: (ctx) => InkWell(
                          onTap: () {
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
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.2,
                                          margin: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ລາຍລະອຽດ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Divider(
                                                color: Colors.blue,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "ເລກປະຈຳຕົວຜູ່ເສຍອາກອນ:"),
                                                    Text(
                                                      e.tin!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ບາໂຄດ:"),
                                                    Text(
                                                      e.barcode!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ຊື່ວິສາຫະກິດ:"),
                                                    Text(
                                                      e.name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ຊື່ບ້ານ:"),
                                                    Text(
                                                      e.village!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ປະເພດການຖືບັນຊີ:"),
                                                    Text(
                                                      e.accType!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "ປະເພດອາກອນມຸນຄ່າເພີ່ມຂອງວິສາຫະກິດ:"),
                                                    Text(
                                                      e.taxType!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ປະເພດທຸລະກິດ:"),
                                                    Text(
                                                      e.busType!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ປະເພດທຸລະກິດຫລັກ:"),
                                                    Text(
                                                      e.mainBusTpye!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "ປະເພດທຸລະກິດ LSIC ຫຼັກ:"),
                                                    Text(
                                                      e.busTypeLSIC!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ວັນທີອອກ​ໃບ​ແຈ້ງ:"),
                                                    Text(
                                                      e.issueDate!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ປະເພດອາກອນ:"),
                                                    Text(
                                                      e.type!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ເຫດຜົນການຊຳລະ:"),
                                                    Text(
                                                      e.description!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ຈຳນວນເງິນ(ກີບ):"),
                                                    Text(
                                                      e.taxAmount!.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ອາກອນຄົງຄ້າງ:"),
                                                    Text(
                                                      e.debitTax!.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ສະຖານະ:"),
                                                    Text(
                                                      e.status!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ວັນທີຈ່າຍ:"),
                                                    Text(
                                                      e.dates!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ເມືອງ:"),
                                                    Text(
                                                      e.district!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ແຂວງ:"),
                                                    Text(
                                                      e.province!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
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
                              animationType: DialogTransitionType.slideFromTop,
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(seconds: 1),
                            );
                          },
                          child: Tooltip(
                            message: "${e.name}",
                            decoration: BoxDecoration(color: Colors.blue),
                            padding: EdgeInsets.all(5),
                            textStyle: TextStyle(color: Colors.white),
                            // decoration: BoxDecoration(
                            //     color: Color(int.parse(
                            //         "${e.color}".replaceAll('#', '0xff'))),
                            //     borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.location_on,
                              color: e.statusCode == 0
                                  ? Colors.red
                                  : e.statusCode == 1
                                      ? Colors.yellow
                                      : Colors.green,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Positioned(
              top: 16,
              left: 16,
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
                ],
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

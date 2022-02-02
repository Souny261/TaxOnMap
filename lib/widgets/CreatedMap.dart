import 'package:easy_tax_map/helper/Laoder.dart';
import 'package:easy_tax_map/provider/LocationProvider.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:easy_tax_map/widgets/zoombuttons_plugin_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class CreatedMapWidget extends StatefulWidget {
  const CreatedMapWidget({Key? key}) : super(key: key);

  @override
  _CreatedMapWidgetState createState() => _CreatedMapWidgetState();
}

class _CreatedMapWidgetState extends State<CreatedMapWidget> {
  double zoom = 10.0;

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
                        point:
                            LatLng(double.parse(e.lng!), double.parse(e.lat!)),
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
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
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
                                                    Text("TIN:"),
                                                    Text(
                                                      e.tIN!,
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
                                                    Text("TaxpayerType:"),
                                                    Text(
                                                      e.taxpayerType!,
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
                                                    Text("BusinessType:"),
                                                    Text(
                                                      e.businessType!,
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
                                                    Text("BusinessName:"),
                                                    Text(
                                                      e.businessName!,
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
                                                    Text("OwnerName:"),
                                                    Text(
                                                      e.ownerName!,
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
                                                    Text("Province:"),
                                                    Text(
                                                      e.province!,
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
                                                    Text("District:"),
                                                    Text(
                                                      e.district!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                            message: "${e.businessName}",
                            decoration: BoxDecoration(color: Colors.blue),
                            padding: EdgeInsets.all(5),
                            textStyle: TextStyle(color: Colors.white),
                            // decoration: BoxDecoration(
                            //     color: Color(int.parse(
                            //         "${e.color}".replaceAll('#', '0xff'))),
                            //     borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
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

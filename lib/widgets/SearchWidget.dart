import 'package:easy_tax_map/models/ProvineModel.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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
      body: Container(
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.blue))),
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: mainProvider.provinceModel!.data!.length,
            itemBuilder: (context, index) {
              ProvinceData data = mainProvider.provinceModel!.data![index];
              return Card(
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    if (value) {
                      mainProvider.moveMap(
                          data.lat.toString(), data.lng.toString());
                    }
                  },
                  title: Text(
                    data.provinceName!,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
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
                            mainProvider.moveMap(e.lat!, e.lng!);
                          },
                          title: Text(e.district!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 10,
                                  ),
                                  Text(e.code! == "0101"
                                      ? "${mainProvider.taxData!.data!.where((element) => element.statusCode == 0).length.toString()}"
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
                                      ? "${mainProvider.taxData!.data!.where((element) => element.statusCode == 1).length.toString()}"
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
                                      ? "${mainProvider.taxData!.data!.where((element) => element.statusCode == 2).length.toString()}"
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
    );
  }
}

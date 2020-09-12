import 'package:absent_udacoding/DashboardAbsen.dart';
import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelRole.dart';
import 'package:absent_udacoding/model/ModelUser.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/ui_page/checkin/CheckIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearch = true;
  List filterList;
  TextEditingController _etSearch = TextEditingController();
  List finalData;
  String keyword;

  Future<List<Datum>> getSearch() async{
    // TODO: implement getSearch
    final response = await http.post(ConstantFile().baseUrl + "searchUser", body: {
      'keyword': _etSearch.text
    });
    ResultNews data = resultNewsFromJson(response.body);
    return data.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _SearchPageState() {
    _etSearch.addListener(() {
      if (_etSearch.text.isEmpty) {
        setState(() {
          _isSearch = true;
          keyword = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          keyword = _etSearch.text;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _createSearchVIew(),
          _isSearch ? _createListView() : performSearch(),
        ],
      ),
    );
  }

  Widget _createSearchVIew() {
    return Card(
      margin: EdgeInsets.only(top: 8),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _etSearch,
          textAlign: TextAlign.start,
          decoration: InputDecoration(hintText: "Search"),
        ),
      ),
    );
  }

  Widget _createListView() {
    return Flexible(
      child: FutureBuilder(
          future: getSearch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ListCheckin(
              list: snapshot.data,
            )
                : new Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget performSearch() {
    return Flexible(
      child: FutureBuilder(
          future: getSearch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ListCheckin(
              list: snapshot.data,
            )
                : new Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

}

class Search extends StatefulWidget {
  List list;
  Search({this.list});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  BaseEndPoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: network.getAbsent(""),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListCheckin(list: snapshot.data)
            : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ListCheckin extends StatelessWidget {
  List<Datum> list;
  ListCheckin({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(8),
        child: GridView.builder(
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0, //MENGATUR JARAK ANTARA OBJEK ATAS DAN BAWAH
              crossAxisSpacing: 3, //MENGATUR JARAK ANTARA OBJEK KIRI DAN KANAN
              childAspectRatio: 0.65, //ASPEK RASIONYA KITA SET BANDING 1 SAJA
            ),
            itemBuilder: (context, index) {
              Datum data = list[index];
              // Role dataa = list[index];
              return InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => DetailProfile(data: data)));
//                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10.0,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Image.network(
                                ConstantFile().imageUrl + data.photoUser,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              data?.fullnameUser ?? "",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 8),
//                            child: Text(
//                              data?.nameRole ?? "",
//                              style: TextStyle(
//                                  color: Colors.grey,
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.w500),
//                            ),
//                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                textColor: Colors.white,
                                child: Text("Checkin"),
                                color: Colors.green,
//                                onPressed: () => dialogCheckin(context, data),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }


}



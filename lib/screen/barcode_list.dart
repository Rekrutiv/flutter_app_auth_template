import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/dao/barcode_dao.dart';
import 'package:flutter_app_auth_template/model/barcodes_model.dart';


class BarCodesList extends StatefulWidget {
  @override
  _BarCodesListState createState() => _BarCodesListState();
}

class _BarCodesListState extends State<BarCodesList> {
  CodesDao dau = CodesDao();


  //static final _list1=dau.getAllCodes();

  TextEditingController barCodeController = TextEditingController();
  TextEditingController responseUserController = TextEditingController();

  @override
  void initState() {
    //dau.insertBooks(BarCodes(barCode: 1, responseuser: "some text"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<BarCodes>> _checkList =dau.getAllCodes();


    return Scaffold(
      appBar: AppBar(
        title: Text("BarCodes List"),
      ),
      body: Container(
        child: FutureBuilder<List<BarCodes>>(

          future: _checkList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              print("asdff ${snapshot.data}");
              return Container(color: Colors.red);
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  BarCodes student = snapshot.data[index];
                  return snapshot.data.length == null
                      ? CircularProgressIndicator()
                      : ListTile(
                          title:
                              Text("Штрихкод: " + student.barCode.toString()),
                          subtitle: Text(student.responseuser),
                          onTap: () {
                            setState(() {
                              dau.delete(BarCodes(barCode: student.barCode));
                              snapshot.data.removeAt(index);
                            });
                          },
                        );
                });
          },
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                child: Dialog(
                    child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Штрихкод"),
                        controller: barCodeController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Ваш відгук"),
                        controller: responseUserController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FlatButton(
                        child: Text("Добавити штрихкод"),
                        onPressed: () {
                          setState(() {
                            dau.insertBooks(BarCodes(
                              barCode: int.parse(barCodeController.text),
                              responseuser: responseUserController.text,
                            ));
                            barCodeController.clear();
                            responseUserController.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BarCodesList()));
                           Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                )));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

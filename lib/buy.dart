import 'package:flutter/material.dart';
import 'package:farmafriend/currentUserProfileData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'alreadyBought.dart';

class Buy extends StatefulWidget {

  Buy();
  @override
  BuyState createState() => BuyState();
}

class BuyState extends State<Buy> {

  final dbRefBuy = FirebaseDatabase.instance.reference().child("Inventory");
  String searchField;
  final GlobalKey<
      ScaffoldState> _scaffoldKey = new GlobalKey< //Mainly for snackbar
      ScaffoldState>();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery //To find height of screen
        .of(context)
        .size
        .height;
    double widthScreen = MediaQuery //To find width of screen
        .of(context)
        .size
        .width;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Color(0xFF3CB371),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context){
                return AlreadyBought();
              }
          ));
        },
      ),
      body: ListView(
        children: <Widget>[
          Container( // This is for the back button
            color: Color(0xFF3CB371),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.00),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 32,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(  //This is for the rounded background
              height: heightScreen * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xFF3CB371),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50.00),
                      bottomLeft: Radius.circular(50.00)
                  )
              ),
              child: Column(
                children: <Widget>[
                  Padding(  //The word Buy on the rounded background
                    padding: EdgeInsets.only(top: 30.00),
                    child: Text(
                      "Buy",
                      style: TextStyle(
                          fontSize: 32.00,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Padding(  // For the search bar where items can be searched
                    padding: EdgeInsets.only(left: 30.0),
                    child: SizedBox(
                      child: TextFormField(
                        controller: search,
                        textAlign: TextAlign.center,
                      ),
                      width: widthScreen*(0.5),
                    ),
                  ),
                  Container(
                    width: 30.0,
                  ),
                  RaisedButton( // Search Button
                    color: Color(0xFF3CB371),
                    child: Text('Search', style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      setState(() {
                        if(search.text == ""){
                          searchField = null;
                        }
                        else{
                          searchField = search.text;
                        }
                      });
                    },
                  )
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: FutureBuilder(
              future: dbRefBuy.orderByChild("Buyer").equalTo("Null").once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                if(snapshot.hasData){
                  //print(snapshot.data.value);
                  bool toPut = true;
                  Map<dynamic, dynamic> values = snapshot.data.value;  //Map of the data received
                  List<dynamic> lists = [];
                  values.forEach((x,y) {
                    List<dynamic> temp = [];
                    y.forEach((a,b){
                      temp.add(b);
                      if(a == "Location" && b != currentUserData.city){
                        toPut = false;
                      }
                      if(a == "Product" && searchField != null){
                        if(searchField.toLowerCase() != b.toString().toLowerCase()){
                          toPut = false;
                        }
                      }
                    });
                    if(toPut){
                      lists.add([x,temp]);
                    }
                  });
                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Color(0xFF3CB371),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: ListTile(
                                    title: Text(lists[index][1][1] + "  " + lists[index][1][2], textScaleFactor: 1.1,style: TextStyle(color: Colors.white),),
                                    subtitle: Text("Sold By ${lists[index][1][4]} at Rs ${lists[index][1][5]}", textScaleFactor: 1,style: TextStyle(color: Colors.white),),
                                    trailing: FlatButton(
                                      child: Text("Buy", textScaleFactor: 1.1,style: TextStyle(color: Colors.white),),
                                      onPressed: (){

                                      },
                                    ),
                                  )
                              ),
                            ],
                          ),
                        );
                      });

                }
                else{
                  return Container(  //If data still fetching, show circle progress bar
                    height: heightScreen*0.2,
                    width: widthScreen*0.4,
                    child: CircularProgressIndicator(),
                  );

                }
              },
            ),
          )
        ],
      ),
    );
  }
}

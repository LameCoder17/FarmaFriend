import 'package:flutter/material.dart';
import 'package:farmafriend/currentUserProfileData.dart';
import 'package:firebase_database/firebase_database.dart';

class Sell extends StatefulWidget {

  Sell();
  @override
  SellState createState() => SellState();
}

class SellState extends State<Sell> {

  final dbRefBuy = FirebaseDatabase.instance.reference().child("Inventory");
  final GlobalKey<
      ScaffoldState> _scaffoldKey = new GlobalKey< //Mainly for snackbar
      ScaffoldState>();
  TextEditingController cost = TextEditingController();
  TextEditingController product = TextEditingController();
  TextEditingController quantity = TextEditingController();
  var _formKey = GlobalKey<FormState>();

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
        backgroundColor: Color(0xFF3CB371),
        child: Icon(Icons.history),
        onPressed: () {

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
                      "Sell",
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
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Product", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    width: widthScreen*0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: product,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Enter Product Name';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Product',

                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Quantity (with Units)", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    width: widthScreen*0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: quantity,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Enter Quantity (with units)';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Quantity',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Cost", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    width: widthScreen*0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cost,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Enter Cost in Rupees';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Cost',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: widthScreen*0.2),
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Cancel',
                            textScaleFactor: 1.2,),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          color: Color(0xFF3CB371),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          width: 50.0,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if(_formKey.currentState.validate())
                            {
                              readData(product.text, quantity.text, cost.text);
                            }
                          },
                          color: Color(0xFF3CB371),
                          child: Text('Sell Product',
                            textScaleFactor: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  void readData(String product, String quantity, String cost ){
    dbRefBuy.once().then((DataSnapshot snapshot){
      print(snapshot.value);
      Map<dynamic, dynamic> values = snapshot.value;
      int temp = 0;
      values.forEach((key, value) {
        if(temp < int.parse(key.toString().split(" ")[1])){
          temp = int.parse(key.toString().split(" ")[1]);
        }
      });
      dbRefBuy.child("Item ${temp+1}").set(
          {
            'Buyer' : 'Null',
            'Cost' : int.parse(cost),
            'Location': currentUserData.city,
            'Product' : product,
            'Quantity' : quantity,
            'Seller' : currentUserData.UserName,
            'Status' : 'Pending'
          }
      );
    });
    showSnackBar("Item successfully added to Marketplace");
  }

  void showSnackBar(String message) { // For the snackbar
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
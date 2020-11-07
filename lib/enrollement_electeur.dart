import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnrollementElecteur extends StatefulWidget {
  @override
  _EnrollementElecteurState createState() => _EnrollementElecteurState();
}

class _EnrollementElecteurState extends State<EnrollementElecteur> {
  List _promotions = ["G1", "G2", "G3", "L1", "L2"];
  List _facultes = ["Gestion-Info", "Lettre", "Communication"];
  String _name;
  String _matricule;
  String _pwd;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  List<DropdownMenuItem<String>> _dropDownMenuFaculteItems;
  String _faculteCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _dropDownMenuFaculteItems = getDropDownMenuFaculteItems();
    _currentCity = _dropDownMenuItems[0].value;
    _faculteCity = _dropDownMenuFaculteItems[0].value;
    super.initState();
  }

  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _promotions) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFaculteItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _facultes) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enrollement Electeur"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                suffixIcon: Icon(Icons.edit),
                labelText: "Nom complet",
              ),
              onChanged: (v) {
                setState(() {
                  _name = v;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                suffixIcon: Icon(Icons.edit),
                labelText: "Matricule",
              ),
              onChanged: (v) {
                setState(() {
                  _matricule = v;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(6),
                child: Row(
                  children: [
                    Expanded(
                      child: new DropdownButton(
                        hint: Text("Promotion"),
                        isExpanded: true,
                        value: _currentCity,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: new DropdownButton(
                        hint: Text("Departement"),
                        isExpanded: true,
                        value: _faculteCity,
                        items: _dropDownMenuFaculteItems,
                        onChanged: changedDropDownFaculteItem,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                suffixIcon: Icon(Icons.edit),
                labelText: "Mot de passe",
              ),
              onChanged: (v) {
                setState(() {
                  _pwd = v;
                });
              },
            ),
            SizedBox(
              height: 56,
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () {},
                      child: Text("Annuler"),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("electeurs")
                            .doc(_matricule)
                            .set({
                          "matricule": _matricule,
                          "name": _name,
                          "pwd": _pwd,
                          "promotion": _currentCity,
                          "departement": _faculteCity,
                          "createdAt": DateTime.now()
                        });
                      },
                      child: Text("Enregistrer"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }

  void changedDropDownFaculteItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _faculteCity = selectedCity;
    });
  }
}

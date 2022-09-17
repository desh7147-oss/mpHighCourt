import 'package:flutter/material.dart';
import 'package:hcabaj/Networking/GetGreeingsMessage.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/ReusableWidgets.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class GreetingsScreen extends StatefulWidget {
  String currentScreen = "Send SMS";
  final List<String> dropdown2Items;
  GreetingsScreen(this.dropdown2Items, {Key? key}) : super(key: key);

  static const List<String> _dropdown1Items = [
    "Select Type--",
    "Member",
    "Number",
    "Life Members",
    "Senior Advocates"
  ];

  @override
  _GreetingsScreenState createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  var _dropdownValue = "Select Type--";
  var _dropdownTwoValue = "Select Occasion--";
  late bool dropdownOneValidated;
  late bool dropdownTwoValidated;
  bool loaderVisibility = true;
  TextEditingController _messageController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loaderVisibility = false;
      });
    });
  }

  // void callTheApi() async {
  //   setState(() {
  //     loaderVisibility = true;
  //   });
  //   final list = await MessageHandling.getOccasions();
  //   setState(() {
  //     loaderVisibility = false;
  //     _dropdown2Items = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: buildGlobalAppBarWidget(context),
        bottomNavigationBar:
            customBottomNavigationBar(context, screenSource: "Send SMS"),
        drawer: buildCustomDrawer(context, "Send SMS"),
        body: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return loaderVisibility
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // red divider ( centered )
                  Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 80.0,
                      // alignment: Alignment.center,
                      // transformAlignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 140, vertical: 15.0),
                      child: Divider(
                        thickness: 3.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // SMS text ( on the left with padding )
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "SMS",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // two dropdowns in a row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Container(
                      //   height: 40.0,
                      //   width: 80.0,
                      //   child: DropdownButtonFormField(
                      //     value: _dropdownValue,
                      //     icon: Icon(Icons.arrow_drop_down_outlined),
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         _dropdownValue = newValue!;
                      //       });
                      //     },
                      //     items: GreetingsScreen._dropdown1Items
                      //         .map((String value) =>
                      //             DropdownMenuItem(value: value, child: Text(value)))
                      //         .toList(),
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: Colors.black,
                      //       ),
                      //     )),
                      //   ),
                      // ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 140.0,
                          maxWidth: 180.0,
                          maxHeight: 80,
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                // onTap: callTheApi,
                                alignment: AlignmentDirectional.centerStart,
                                elevation: 4,
                                iconSize: 15.0,
                                isExpanded: true,
                                // style: TextStyle(fontSize: 12.0),
                                value: _dropdownValue,
                                dropdownColor: Colors.white,
                                items: GreetingsScreen._dropdown1Items
                                    .map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                icon: Transform(
                                    transform:
                                        Matrix4.translationValues(-5, 0, 0),
                                    child: const Icon(
                                        Icons.arrow_drop_down_outlined)),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _dropdownValue = newValue!;
                                  });
                                  if (_validateTheDropdown(_dropdownValue) !=
                                          null &&
                                      _validateTheDropdown(_dropdownValue)) {
                                    dropdownOneValidated = true;
                                  } else {
                                    dropdownOneValidated = false;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 140.0,
                          maxWidth: 180.0,
                          maxHeight: 80,
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                iconSize: 15.0,
                                // iconSize: 20.0,
                                // style: TextStyle(fontSize: 12.0),
                                value: _dropdownTwoValue,
                                dropdownColor: Colors.white,
                                items: widget.dropdown2Items.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    _dropdownTwoValue = newValue!;
                                  });
                                  if (_validateTheDropdown(_dropdownTwoValue) !=
                                          null &&
                                      _validateTheDropdown(_dropdownTwoValue)) {
                                    dropdownTwoValidated = true;
                                  }
                                  if (_validateTheDropdown(_dropdownValue) !=
                                          null &&
                                      _validateTheDropdown(_dropdownValue)) {
                                    dropdownOneValidated = true;
                                  } else {
                                    dropdownOneValidated = false;
                                  }
                                  if (dropdownOneValidated != null &&
                                      dropdownOneValidated &&
                                      dropdownTwoValidated != null &&
                                      dropdownTwoValidated) {
                                    loaderVisibility = true;
                                    loaderVisibility =
                                        await fillTheMessageField(
                                            occasion: _dropdownTwoValue);
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // a text field for number with visibility conditions
                  Visibility(
                    visible:
                        _dropdownValue.toLowerCase() == "number" ? true : false,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 8.0),
                      child: Text(
                        "Number",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        _dropdownValue.toLowerCase() == "number" ? true : false,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Mobile Number"),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  // a text field for message
                  Container(
                    child: Text(
                      "Message",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    height: 200.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        ),
                        hintText: "Enter your message here",
                      ),
                      maxLines: 5,
                      controller: _messageController,
                      maxLength: 500,
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    transform: Matrix4.translationValues(
                        MediaQuery.of(context).size.width / 4 - 10, -70, 0),
                    padding: const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 10.0),
                    width: 200.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromHeight(45),
                        ),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                              // borderRadius: BorderRadius.circular(10.0),
                              ),
                        ),
                      ),
                      onPressed: () {
                        String message = "";
                        late Color color;
                        debugPrint("will send the message button");
                        if (_validateTheDropdown(_dropdownValue) &&
                            _validateTheDropdown(_dropdownTwoValue) &&
                            _messageController.text.isNotEmpty) {
                          sendTheMessage(_numberController.text, _dropdownValue,
                              _dropdownTwoValue);
                        } else if (!_validateTheDropdown(_dropdownValue) &&
                            _validateTheDropdown(_dropdownTwoValue)) {
                          message = "Please Select a Type";
                          color = Colors.redAccent;
                        } else if (!_validateTheDropdown(_dropdownTwoValue) &&
                            _validateTheDropdown(_dropdownValue)) {
                          message = "Please Select an Occasion";
                          color = Colors.redAccent;
                        } else {
                          message = "Please enter the fields carefully !";
                          color = Colors.redAccent;
                        }
                        if (message.isNotEmpty) {
                          _scaffoldKey.currentState!.showSnackBar(
                              ReusableWidgets.getSnackBar(
                                  context, message, color));
                        }
                      },
                      child: Text("SEND MESSAGE",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              letterSpacing: 2.0)),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          );
  }

  // validate the drop down two
  bool _validateTheDropdown(String dropdownValue) {
    if (dropdownValue != null &&
        dropdownValue.isNotEmpty &&
        dropdownValue.toLowerCase() != "select type--" &&
        dropdownValue.toLowerCase() != "select occasion--") {
      return true;
    } else
      return false;
  }

  Future<bool> fillTheMessageField({String occasion: "Meeting"}) async {
    String? message =
        await MessageHandling.getGreetingsMessage(occasion: occasion);
    if (message != null && message.isNotEmpty) {
      _messageController.text = message;
    }
    return false;
  }

  Future sendTheMessage(
      String? number, String value, String selectedFestival) async {
    String message = _messageController.text;
    ;
    await MessageHandling.sendTheMessage(
            number: number,
            value: value,
            selectedFesValue: selectedFestival,
            message: message)
        .then((value) {
      Color color;
      if (value != null && value) {
        message = "Message sent successfully";
        color = Color(0xff00A86B);

        _messageController.text = "";
        _numberController.text = "";
        setState(() {
          _dropdownValue = "Select Type--";
          _dropdownTwoValue = widget.dropdown2Items[0];
        });
      } else {
        message = "Oops, something went wrong";
        color = Colors.redAccent;
      }
      _scaffoldKey.currentState!
          .showSnackBar(ReusableWidgets.getSnackBar(context, message, color));
    });
  }
}

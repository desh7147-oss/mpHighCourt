import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Models/MemberDetailsModel.dart';
import 'package:hcabaj/Networking/MemberDetailsApi.dart';
import 'package:hcabaj/Screens/MemberProfileScreen.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

// global var
// static List<User>? membersList = [];

class MembersScreen extends StatefulWidget {
  // variables
  String baseImagePath = "https://hcabaj.org/API/profile_img/";
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  // variables
  final currentScreen = "Members";
  static List<User>? membersList = [];
  int totalItems = 0;
  int itemsPerPage = 10;
  int currentPage = 0;
  bool nextAndPreviousVisibility = true;
  var loader = true;
  var filterIsOn = false;
  bool filterWorking = false;
  late List<User>? _foundUsers = [];
  String? searchStr = "";
  TextEditingController? controller = TextEditingController();

  // init state
  void initState() {
    callTheApi();
    super.initState();
  }

  void callTheApi() async {
    final result = await MemberDetailsApi.getMemberDetails();
    print("result is: ${result.toString()} && users are: ${result.user}");
    setState(() {
      membersList = result.user;
      membersList = membersList;
      loader = false;
      if (membersList != null && membersList!.isNotEmpty) {
        totalItems = membersList!.length;
        // at the beginning, all users are shown
        _foundUsers = membersList;
        if (membersList!.length <= 10) {
          nextAndPreviousVisibility = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: buildGlobalAppBarWidget(context),
          body: _createHistoryScreenBody(context),
          drawer: buildCustomDrawer(context, "Members"),
          bottomNavigationBar: customBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _createHistoryScreenBody(context) {
    print("members list is: ${membersList.toString()} && ${membersList}");
    return loader == true
        ? Center(child: CircularProgressIndicator())
        : _foundUsers != null && _foundUsers!.isEmpty && !filterIsOn
            ? Center(
                child: const Text('No results found',
                    style: TextStyle(fontSize: 24)),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 2), () {
                    callTheApi();
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, left: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "MEMBERS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                          // alignment: Alignment.topRight,
                          transformAlignment: Alignment.topRight,
                          transform: Matrix4.translationValues(80, 0, 0),
                          height: 40.0,
                          width: 190.0,
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: TextField(
                            onChanged: (String? value) {
                              setState(() {
                                String searchString = value!;
                                searchStr = value;
                                _runFilter(enteredKeyword: searchString);
                              });
                            },
                            onEditingComplete: _runFilter,
                            controller: controller,
                            decoration: InputDecoration(
                                labelText: 'Search',
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      _runFilter(enteredKeyword: searchStr);
                                    }),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(8.0)),
                          ),
                        ),
                        membersCard(context),
                        Visibility(
                          visible: nextAndPreviousVisibility ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                child: Text("Previous page"),
                                onPressed:
                                    (currentPage - 1) < 0 ? null : previousPage,
                              ),
                              TextButton(
                                child: Text("Next page"),
                                onPressed: (currentPage + 1) < pageCount()
                                    ? nextPage
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }

  Widget membersCard(BuildContext context) {
    return _foundUsers != null && _foundUsers!.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height / 2 - 15,
            child: Center(
              child: const Text('No results found',
                  style: TextStyle(fontSize: 24)),
            ),
          )
        : _foundUsers != null &&
                _foundUsers!.isNotEmpty &&
                _foundUsers!.length <= 1
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 6.0, top: 10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      sendToProfileScreen(context, _foundUsers![index]);
                    },
                    child: Card(
                      child: Container(
                        // height: 350.0,
                        // height: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          // alignment: Alignment.topCenter,
                          children: [
                            Container(
                                child: Image.asset(
                              "lib/assets/gavel-auction-hammer-3577258.jpeg",
                              height: 94,
                              fit: BoxFit.contain,
                            )),
                            Transform(
                              transform: Matrix4.translationValues(0, -40, 0),
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(widget
                                        .baseImagePath +
                                    _foundUsers![index].profileImg!.toString()),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.baseImagePath +
                                        _foundUsers![index]
                                            .profileImg!
                                            .toString(),
                                    placeholder: (ctx, url) => Image.asset(
                                      "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (ctx, url, error) => Image.asset(
                                        "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg"),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0, -30, 0),
                              // padding: const EdgeInsets.only(top: 2.0, bottom: 5.0),
                              child: Center(
                                child: Text(
                                  "${_foundUsers![index].displayName ?? ""}",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _foundUsers!.length >= 10
                    ? itemsPerPage
                    : _foundUsers!.length,
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 6.0, top: 10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  // print(
                  //     "current member image: ${widget.baseImagePath + _foundUsers![index].profileImg!.toString()}");
                  return InkWell(
                    onTap: () {
                      sendToProfileScreen(context,
                          _foundUsers![index + (currentPage * itemsPerPage)]);
                    },
                    child: Card(
                      child: Container(
                        // height: 350.0,
                        // height: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          // alignment: Alignment.topCenter,
                          children: [
                            Container(
                                child: Image.asset(
                              "lib/assets/gavel-auction-hammer-3577258.jpeg",
                              height: 94,
                              fit: BoxFit.contain,
                            )),
                            Transform(
                              transform: Matrix4.translationValues(0, -40, 0),
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(widget
                                        .baseImagePath +
                                    ((_foundUsers!.length >= 1)
                                        ? _foundUsers![index +
                                                (currentPage * itemsPerPage)]
                                            .profileImg
                                            .toString()
                                        : "")),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.baseImagePath +
                                        _foundUsers![index +
                                                (currentPage * itemsPerPage)]
                                            .profileImg
                                            .toString(),
                                    placeholder: (ctx, url) => Image.asset(
                                      "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (ctx, url, error) => Image.asset(
                                        "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg"),
                                  ),
                                ),
                              ),
                            ),
                            // backgroundImage: AssetImage(
                            Container(
                              transform: Matrix4.translationValues(0, -30, 0),
                              // padding: const EdgeInsets.only(top: 2.0, bottom: 5.0),
                              child: Center(
                                child: Text(
                                  "${membersList![index + (currentPage * itemsPerPage)].displayName ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
  }

  num pageCount() {
    return totalItems / itemsPerPage;
  }

  nextPage() {
    if ((currentPage + 1) < pageCount()) {
      setState(() {
        currentPage += 1;
      });
    }
  }

  previousPage() {
    //lets not go bellow 0 :-)
    if (currentPage != 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  void _runFilter({String? enteredKeyword}) {
    // List<Map<String, dynamic>> results = [];
    Future.delayed(Duration(seconds: 4));
    List<User>? results = [];
    enteredKeyword = controller!.text;
    // enteredKeyword = controller!.text;
    if (enteredKeyword!.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = membersList;
    } else {
      if (membersList != null && membersList!.isNotEmpty) {
        for (int i = 0; i < membersList!.length; ++i) {
          if (membersList![i]
              .displayName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())) {
            results.add(membersList![i]);
          }
        }
      }
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
      filterIsOn = true;
      if (_foundUsers != null && _foundUsers!.length <= 10) {
        nextAndPreviousVisibility = false;
      } else {
        nextAndPreviousVisibility = true;
      }
    });
  }

  sendToProfileScreen(BuildContext context, User user) {
    var splittedName =
        user != null ? user.displayName.toString().split(" ") : [];
    String firstName = splittedName.isNotEmpty ? splittedName[0] : "";
    String lastName = "";
    if (splittedName.isNotEmpty) {
      for (int i = 1; i < splittedName.length; i++) {
        print("name" + splittedName[i]);
        String currentName =
            lastName!.isNotEmpty ? " " + splittedName[i] : splittedName[i];

        lastName = lastName! + currentName;
      }
    }
    print("tapped inkwell");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MemberProfileDetailsScreen(user, firstName, lastName),
      ),
    );
  }
}

import 'package:e_management/services/user_preferences.dart';
import 'package:e_management/src/models/user_model.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: FutureBuilder<User?>(
        future: UserPreferences.read(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userInfo = snapshot.data;
            if (userInfo != null) {
              var userData = userInfo;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/profile.jpg",
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${userData.firstName} ${userData.lastName}',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.phone,
                                            size: 20.0,
                                            color: MyThemes.primary)),
                                    Text(
                                      '${userData.telephone}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.business,
                                            size: 20.0,
                                            color: Colors.purpleAccent)),
                                    Text(
                                      '${userData.nameBusiness}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.money,
                                            size: 20.0, color: Colors.green)),
                                    Text(
                                      '${userData.typeAbonnement}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.email,
                                            size: 20.0,
                                            color: MyThemes.primary)),
                                    Text(
                                      '${userData.email}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.place,
                                            size: 20.0,
                                            color: Colors.purpleAccent)),
                                    Text(
                                      '${userData.province}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/profile.jpg", height: 150.0, width: 150.0, fit: BoxFit.cover,),
                    SizedBox(height: 8.0),
                    Text(
                      '${userData.firstName} ${userData.lastName}',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 16.0,),
                    
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone,
                                size: 40.0, color: MyThemes.primary)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.business,
                                size: 40.0, color: MyThemes.primary)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.money,
                                size: 40.0, color: MyThemes.primary))
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      children: [
                        Text(
                          '${userData.telephone}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Text(
                          '${userData.nameBusiness}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Text(
                          '${userData.typeAbonnement}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800),
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

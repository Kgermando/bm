import 'package:e_management/services/user_preferences.dart';
import 'package:e_management/src/models/user_model.dart';
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
      body: Center(
        child: FutureBuilder<User?>(
          future: UserPreferences.read(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                var userData = userInfo;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.network(userData.avatar),
                    SizedBox(height: 8.0),
                    Text(
                      '${userInfo.firstName} ${userInfo.lastName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              }
            }
            return CircularProgressIndicator();
            
          },
        ),
      ),


    );
  }
}

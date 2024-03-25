import 'package:firebase_demo/notificationservice/local_notification_service.dart';
import 'package:firebase_demo/view/demo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  // ====================================================================
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Demo(
                  id: message.data['_id'],
                ),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  // ====================================================================
  String deviceTokenToSendPushNotification = "";

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value: $deviceTokenToSendPushNotification");
  }

//   Step 2. Go to firebase console -> select your project -> go to project settings -> copy server key

// step 3. open postman
// 	go to Headers section and set Header
// 	Content-Type -> application/json
// 	Authorization ->key=AAAAreRA0mw:APA91bGvTRVxEABpWoOr4irshG_MArL1ek9J4LMu9yQOdQsssHCKCX4wuc6dcxb1pNaw4BG5gYgypgUT7jpwdte4_Pa0l7mJ8tsDtZtgQxM-xBZjr8uWtTRe-X5jIRs1IMGvXKBkHez4

// step 4. now you are ready to send notification via postman

// 	1. method post
// 	2. API Url -> https://fcm.googleapis.com/fcm/send
// 	3. json Body ->
// {
//     "registration_ids": [
//         "dJVh8FWXQ_2ipxYVpFaXCT:APA91bFyHc6mSyWHMgN7_iVDk5zB1WwB6qKlZGcxIpRBFnnxl4CRRi9qTCD3oLrJU6OY12AGzuM8_XZkEiWuwXUMc8nIlupjfrjIgNdzuhmq3bAOBYdw1z_8nmcSWyFNin24jkfgFTC5"
//     ],
//     "notification": {
//         "body": "New Video has been uploaded",
//         "title": "Inventorcode",
//         "android_channel_id": "pushnotificationapp",
//         "sound": false
//     }
// }

// Step 5. If you want to send extra data
// 	add data key in josn like this
// 	{
// 		"notification"{
// 				}
// 		"data":{"_id":1}

// 	}

// NOTE-> For single user user  "to":"" or for multipal users use "registration_ids": [] array
// 	"registration_ids": [
//         "dJVh8FWXQ_2ipxYVpFaXCT:APA91bFyHc6mSyWHMgN7_iVDk5zB1WwB6qKlZGcxIpRBFnnxl4CRRi9qTCD3oLrJU6OY12AGzuM8_XZkEiWuwXUMc8nIlupjfrjIgNdzuhmq3bAOBYdw1z_8nmcSWyFNin24jkfgFTC5"
//     ]

// NOTE ->>>>>>>>>>> If you want to send image in notification add "image":"", key in "":{"notification":""},

// {
//     "registration_ids": [
//         "dJVh8FWXQ_2ipxYVpFaXCT:APA91bFyHc6mSyWHMgN7_iVDk5zB1WwB6qKlZGcxIpRBFnnxl4CRRi9qTCD3oLrJU6OY12AGzuM8_XZkEiWuwXUMc8nIlupjfrjIgNdzuhmq3bAOBYdw1z_8nmcSWyFNin24jkfgFTC5"
//     ],
//     "notification": {
//         "body": "New Video has been uploaded",
//         "title": "Inventorcode",
//         "android_channel_id": "pushnotificationapp",
//         "image":"https://cdn2.vectorstock.com/i/1000x1000/23/91/small-size-emoticon-vector-9852391.jpg",
//         "sound": false
//     }

// }

  // ====================================================================

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Click 1",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
      ),
    );
  }
}

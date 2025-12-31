import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hiss_root/hiss_ui/dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class HissIosNotificationUtils{
  static final HissIosNotificationUtils _hissIosNotificationUtils=HissIosNotificationUtils();
  static HissIosNotificationUtils get instance => _hissIosNotificationUtils;

  Function()? notificationCallback;

  AndroidFlutterLocalNotificationsPlugin plugin=AndroidFlutterLocalNotificationsPlugin();

  final int notification1=10;
  final int notification2=11;
  final int notification3=12;
  final int notification4=13;
  final int notification5=14;

  var titleList1=[
    "Holiday Prize Pieces Found!",
    "Christmas Cash Explosion",
    "Unlock Your Earnings",
    "CHANEL Bag Piece Detected",
  ];

  var descList1=[
    "You may unlock an iPhone 17 Pro Max—tap to collect your fragments!",
    "Flip your daily spider cards for real payouts instantly.",
    "Your payout is ready—get your cash right now!",
    "You’re getting closer—tap to collect more fragments!",
  ];

  var titleList2=[
    "Santa Dropped Cash",
    "Holiday Gift Hunt",
    "Your Cash Is Waiting",
    "Mystery Reward Unlocked",
  ];
  var descList2=[
    "Today’s card flip could reveal real USD—don’t miss it!",
    "Collect all fragments and claim luxury prizes this Christmas!",
    "One tap sends it straight to your account.",
    "Something valuable is inside—tap to reveal.",
  ];

  var titleList3=[
    "Christmas Mystery Bag!",
    "Festive Rewards Unlocking",
    "A Secret Prize Awaits",
    "Jackpot Item Incoming",
  ];

  var descList3=[
    "Collect fragments to win a \$500 Amazon Gift Card!",
    "Your next flip could reveal Chanel, Dyson, or real cash—try now!",
    "Your mystery box card is ready—open it now!",
    "Your next flip might reveal iPhone, CHANEL or Switch fragments—don’t miss it!",
  ];

  // var titleList4=[
  //   "Christmas Event: Don’t Miss Out",
  //   "Christmas Luck Boost",
  //   "A Fragment Could Unlock Cash",
  //   "Your Final Fragment May Be Next",
  // ];
  //
  // var descList4=[
  //   "Premium prize fragments are dropping for a limited time!",
  //   "Your chances of winning premium gifts are doubled today!",
  //   "Your next flip might complete your withdrawal—try now!",
  //   "Flip a card now—cashout could be seconds away.",
  // ];
  //
  // var titleList5=[
  //   "Santa Left You a “Rare Fragment”!",
  //   "Christmas Gift Shower!",
  //   "Withdrawal Unlocked!",
  //   "Faster Payout Alert!",
  // ];

  // var descList5=[
  //   "Santa Left You a “Rare Fragment”!",
  //   "Play one more round for an extra chance to grab the \$500 Amazon Gift Card fragment!",
  //   "Today’s payout speed is boosted. Check your available cash now.",
  //   "Earn just a little more to reach your next withdrawal.",
  // ];

  var lockTitle=[
    "Christmas Event: Don’t Miss Out",
    "Christmas Luck Boost",
    "A Fragment Could Unlock Cash",
    "Your Final Fragment May Be Next",
  ];

  var lockDesc=[
    "Premium prize fragments are dropping for a limited time!",
    "Your chances of winning premium gifts are doubled today!",
    "Your next flip might complete your withdrawal—try now!",
    "Flip a card now—cashout could be seconds away.",
  ];


  checkOpenNotification()async{
    await Future.delayed(Duration(milliseconds: 800));
    var status = await Permission.notification.request();
    if(status.isGranted){
      notificationCallback?.call();
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_suc);
      init();
    }else{
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_fail);
    }
  }

  init()async{
    var status = await Permission.notification.request();
    if(!status.isGranted){
      return;
    }
    uploadShowNum();
    var success = await plugin.initialize(
      AndroidInitializationSettings("logo"),
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _click(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _click(notificationResponse.payload);
            break;
        }
      },
    );
    if(success==true){
      _show(
        notification1,
        titleList1.random(),
        descList1.random(),
        Duration(minutes: 23),
      );

      _show(
        notification2,
        titleList2.random(),
        descList2.random(),
        Duration(minutes: 49),
      );

      _show(
        notification3,
        titleList3.random(),
        descList3.random(),
        Duration(minutes: 61),
      );

      // _show(
      //   notification4,
      //   titleList4.random(),
      //   descList4.random(),
      //   Duration(minutes: 137),
      // );
      //
      // _show(
      //   notification5,
      //   titleList5.random(),
      //   descList5.random(),
      //   Duration(minutes: 173),
      // );
      _initFcm("C134_us_data_fcm");
      _initFcm("C134_us_normal_fcm");
      _showLock();
    }else{
      HissRoutersUtils.instance.showDialog(child: OpenNotificationDialog());
    }
    checkClickByLaunchApp();
  }

  _show(id,title,body,repeatDurationInterval,)async{
    AndroidNotificationDetails details = AndroidNotificationDetails(
      'hiss_channel',
      'hiss_channel_name',
      styleInformation: BeautyStyleInformation(
        title,
        body,
        'big',
        'Go Earn',
        'logo',
      ),
      priority: Priority.high,
      importance: Importance.high,
      groupKey: "$id",
    );
    await plugin.periodicallyShowWithDuration(
        id,
        title,
        body,
        kDebugMode?Duration(minutes: 1):repeatDurationInterval,
        notificationDetails: details,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: "local"
    );
  }

  _initFcm(String fcmStr)async{
    var result = await plugin.subscribeToTopic(
      fcmStr,
      const AndroidNotificationDetails(
        'hiss_channel_fcm',
        'hiss_channel_name_fcm',
        styleInformation: BeautyStyleInformation(
          '',
          '',
          '',
          'Go Earn',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
      ),
    );
  }

  _showLock()async{
    var title = lockTitle.random();
    var desc = lockDesc.random();
    await plugin.showBroadcastNotification(
      70,
        title,
      desc,
      kDebugMode?Duration(seconds: 5):Duration(minutes: 10),
      'android.intent.action.USER_PRESENT',
      AndroidNotificationDetails(
        'hiss_channel_lock',
        'hiss_channel_name_lock',
        priority: Priority.high,
        importance: Importance.high,
        styleInformation: BeautyStyleInformation(
          title,
          desc,
          'big',
          'Go Earn',
          'logo',
        ),
        groupKey: "70",
      ),
      'unlock',
    );
  }


  _click(String? from){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.all_noti_c,params: {"type":from});
  }

  uploadShowNum()async{
    var localNum = await plugin.extractMessageReceivedNum("local");
    if(localNum>0){
      for(var index=0;index<localNum;index++){
        HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.all_noti_t,params: {"type":"local"});
      }
    }
    var unlockNum = await plugin.extractMessageReceivedNum("unlock");
    if(unlockNum>0){
      for(var index=0;index<unlockNum;index++){
        HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.all_noti_t,params: {"type":"unlock"});
      }
    }
    var fcmNum = await plugin.extractMessageReceivedNum("fcm");
    if(fcmNum>0){
      for(var index=0;index<fcmNum;index++){
        HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.all_noti_t,params: {"type":"fcm"});
      }
    }
  }

  checkClickByLaunchApp()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      var id = launchDetails?.notificationResponse?.payload;
      _click(id);
    }
  }

  checkOpenApp()async{
    // var launchDetails = await plugin.getNotificationAppLaunchDetails();
    // TTTTUtils.instance.pointEvent(customId: CustomId.launch_page,params: {"source_from":launchDetails?.didNotificationLaunchApp==true?"push":"icon"});
  }
}
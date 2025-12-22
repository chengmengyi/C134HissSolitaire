import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hiss_root/hiss_ui/dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class HissIosNotificationUtils{
  static final HissIosNotificationUtils _hissIosNotificationUtils=HissIosNotificationUtils();
  static HissIosNotificationUtils get instance => _hissIosNotificationUtils;

  var plugin=FlutterLocalNotificationsPlugin();

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

  var titleList4=[
    "Christmas Event: Don’t Miss Out",
    "Christmas Luck Boost",
    "A Fragment Could Unlock Cash",
    "Your Final Fragment May Be Next",
  ];

  var descList4=[
    "Premium prize fragments are dropping for a limited time!",
    "Your chances of winning premium gifts are doubled today!",
    "Your next flip might complete your withdrawal—try now!",
    "Flip a card now—cashout could be seconds away.",
  ];

  var titleList5=[
    "Santa Left You a “Rare Fragment”!",
    "Christmas Gift Shower!",
    "Withdrawal Unlocked!",
    "Faster Payout Alert!",
  ];

  var descList5=[
    "Santa Left You a “Rare Fragment”!",
    "Play one more round for an extra chance to grab the \$500 Amazon Gift Card fragment!",
    "Today’s payout speed is boosted. Check your available cash now.",
    "Earn just a little more to reach your next withdrawal.",
  ];

  checkOpenNotification()async{
    if(!Platform.isIOS){
      return;
    }
    await Future.delayed(Duration(milliseconds: 800));
    var status = await Permission.notification.request();
    if(status.isGranted){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_suc);
      init();
    }else{
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_fail);
    }
  }

  init()async{
    if(!Platform.isIOS){
      return;
    }
    var success = await plugin.initialize(
      InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _click(notificationResponse.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _click(notificationResponse.id);
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
        Duration(minutes: 59),
      );

      _show(
        notification3,
        titleList3.random(),
        descList3.random(),
        Duration(minutes: 97),
      );

      _show(
        notification4,
        titleList4.random(),
        descList4.random(),
        Duration(minutes: 137),
      );

      _show(
        notification5,
        titleList5.random(),
        descList5.random(),
        Duration(minutes: 173),
      );
    }else{
      HissRoutersUtils.instance.showDialog(child: OpenNotificationDialog());
    }
    checkClickByLaunchApp();
  }

  _show(id,title,body,repeatDurationInterval,){
    plugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      repeatDurationInterval,
      NotificationDetails(),
    );
  }

  _click(int? id){
    var from="";
    if(id==notification1){
      from="notification1";
    }
    if(id==notification2){
      from="notification2";
    }
    if(id==notification3){
      from="notification3";
    }
    if(id==notification4){
      from="notification4";
    }
    if(id==notification5){
      from="notification5";
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.all_noti_c,params: {"type":from});
  }

  checkClickByLaunchApp()async{
    if(!Platform.isIOS){
      return;
    }
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      var id = launchDetails?.notificationResponse?.id;
      _click(id);
    }
  }

  checkOpenApp()async{
    if(!Platform.isIOS){
      return;
    }
    // var launchDetails = await plugin.getNotificationAppLaunchDetails();
    // TTTTUtils.instance.pointEvent(customId: CustomId.launch_page,params: {"source_from":launchDetails?.didNotificationLaunchApp==true?"push":"icon"});
  }
}
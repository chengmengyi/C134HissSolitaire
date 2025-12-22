import Flutter
import UIKit
import flutter_local_notifications
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
        }

        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization{ [weak self] status in
                    if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                            print("iOS 17.4 authorization bug detected")
                    }
                }
            }
    }

}

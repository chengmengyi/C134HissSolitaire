import Flutter
import UIKit
import AbstractAssembler

public class IosHhhPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_hhh", binaryMessenger: registrar.messenger())
    let instance = IosHhhPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    if let flutterController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
            let flutterView = flutterController.view
             if let flutterView = flutterView {
                AbstractAssembler.primaryUtility().deactivateCamera(flutterController, unhighlightTent: flutterView)
             }
        }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     switch call.method {
     //a包调用
        case "hiss1":
          AbstractAssembler.primaryUtility().flushFirewall()
          result("")
          //b包调用
        case "hiss2":
          AbstractAssembler.primaryUtility().leadDisk()
          result("")
              //b包调用
        case "hiss3":
          AbstractAssembler.primaryUtility().pausePod()
          result("")
          //跳转h5
        case "hiss4":
          AbstractAssembler.primaryUtility().paintHorizon()
          result("")
        default:
          result(FlutterMethodNotImplemented)
        }
  }
}

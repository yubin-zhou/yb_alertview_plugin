import Flutter
import UIKit

public class SwiftYbAlertviewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yb_alertview_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftYbAlertviewPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method{
      case "getPlatformVersion":
          result("iOS " + UIDevice.current.systemVersion)
          break;
      case "show_native_alertView":
          showAlert(call.arguments as! String)
          result ("显示原生弹窗回调")
          break;
      default:
          result (FlutterMethodNotImplemented)
          break;
      }
  }
    public func showAlert(_ msg: String){
        let alert = UIAlertController.init(title: "iOS 温馨提示", message: msg, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "确定", style: .default) { a in
            print("iOS确定")
        }
        let action2 = UIAlertAction.init(title: "取消", style: .cancel) { a in
            print("iOS取消")
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.getCurrentVc().present(alert, animated: true)
        
    }
    public func getCurrentVc() -> UIViewController{
        let rootVc = UIApplication.shared.keyWindow?.rootViewController
        let currentVc = getCurrentVcFrom(rootVc!)
        return currentVc
       }
    private func getCurrentVcFrom(_ rootVc:UIViewController) -> UIViewController{
     var currentVc:UIViewController
     var rootCtr = rootVc
     if(rootCtr.presentedViewController != nil) {
       rootCtr = rootVc.presentedViewController!
     }
     if rootVc.isKind(of:UITabBarController.classForCoder()) {
       currentVc = getCurrentVcFrom((rootVc as! UITabBarController).selectedViewController!)
     }else if rootVc.isKind(of:UINavigationController.classForCoder()){
       currentVc = getCurrentVcFrom((rootVc as! UINavigationController).visibleViewController!)
     }else{
       currentVc = rootCtr
     }
     return currentVc
    }


}

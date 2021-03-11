import Flutter
import UIKit

public class SwiftExtendedClipboardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "extended_clipboard", binaryMessenger: registrar.messenger())
    let instance = SwiftExtendedClipboardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        getPlatformVersion(result: result)
    case "getClipboard":
        getClipboard(result: result)
    default:
        result(nil)
    }
  }
    
    func getPlatformVersion(result: FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    func getClipboard(result: FlutterResult) {
        if #available(iOS 10.0, *) {
            let pastboard = UIPasteboard.general
            if pastboard.hasImages {
                if (pastboard.image != nil) {
                    let url = saveImage(image: pastboard.image!)
                    result(["type": "image", "data": url?.path])
                } else {
                result(nil)
                }
            } else if pastboard.hasStrings {
                result(["type": "text", "data": pastboard.string])
            } else {
                result(nil)
            }
        } else {
            result(nil)
        }
    }
    
    func saveImage(image: UIImage) -> URL?{
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return nil
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        do{
            let time = Date().timeIntervalSince1970
            let path = directory.appendingPathComponent(String(time) + ".png")
            try data.write(to: path!)
            return path
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

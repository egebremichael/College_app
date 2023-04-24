import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBz5puFlqt13YZR1B1XaoKmOew1WNd9Mqk") // Replace with your API key
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let registrar : FlutterPluginRegistry = controller
        GeneratedPluginRegistrant.register(with: registrar)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}




import UIKit
import Flutter
import Firebase
import OneSignal

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      // Remove this method to stop OneSignal Debugging
      OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

      // OneSignal initialization
      OneSignal.initWithLaunchOptions(launchOptions)
      OneSignal.setAppId("1a70b990-e3ec-42d3-80e5-8eecb094176c")

      // promptForPushNotifications will show the native iOS notification permission prompt.
      // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
      OneSignal.promptForPushNotifications(userResponse: { accepted in
        print("User accepted notifications: \(accepted)")
      })

      // Set your customer userId
      // OneSignal.setExternalUserId("userId")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // NOTE: For logging
    // let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    // print("==== didRegisterForRemoteNotificationsWithDeviceToken ====")
    // print(deviceTokenString)
    Messaging.messaging().apnsToken = deviceToken
  }
}

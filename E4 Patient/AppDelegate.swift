//
//  AppDelegate.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import IQKeyboardManager
import FBSDKCoreKit
import Firebase
import FirebaseMessaging
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn
import GoogleUtilities
import FirebaseMessaging
import FirebaseDatabase
import UserNotifications

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate ,MessagingDelegate ,GIDSignInDelegate{


    var window: UIWindow?
    var databaseRef: DatabaseReference!
    let gcmMessageIDKey = "gcm.message_id"

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("User signed into google")
        
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                          accessToken: (authentication?.accessToken)!)
    
        Auth.auth().signIn(with: credential) { (user, error) in
            print("User Signed Into Firebase")
            UITabBar.appearance().tintColor = UIColor (named: "Blue")
            
            self.databaseRef = Database.database().reference()
            
            self.databaseRef.child("user_profiles").child(user!.user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapshot = snapshot.value as? NSDictionary
                
                if(snapshot == nil)
                {
                    self.databaseRef.child("user_profiles").child(user!.user.uid).child("name").setValue(user?.user.displayName)
                    self.databaseRef.child("user_profiles").child(user!.user.uid).child("email").setValue(user?.user.email)
                }
            
            

            })
            
        }
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
        //Google Sign in
        if(url.scheme == "fb398186212319395") { //Facebook
             return ApplicationDelegate.shared.application(
                application,
                open: url,
                options: options
            )
        }
        else { //Gmail
            return GIDSignIn.sharedInstance().handle(url)
        }
        
        //Facebook Sign in
        /*
         
         */
    }
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        Messaging.messaging().isAutoInitEnabled = true
        application.registerForRemoteNotifications()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        Languagee.language = .english

        // let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]

        //setupTabbar()
      //  window?.rootViewController = LoginVC()
       // window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = AppColor.Blue
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
    //    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColor.Blue]
        
     //UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = AppColor.Blue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")


        setupKeyboard()
        return true
    }
    func setupKeyboard(){
        IQKeyboardManager.shared().isEnabled  = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       }
    ////////////Notification
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
           // Print message ID.
          

           // With swizzling disabled you must let Messaging know about the message, for Analytics
           // Messaging.messaging().appDidReceiveMessage(userInfo)

           // Print full message.
           print(response)

    //let navigator =  UINavigationController()
    //let dict = userInfo as! [String: Any]
    //if let categoryResponse = dict["type"] {
    //  print(categoryResponse)
    //    if categoryResponse as! String == "consultation-status-updated" {
    //        AuthService.instance.isNavigate = true
    //        AuthService.instance.consultationId = dict["id"] as! String
    //        NotificationCenter.default.post(name: Notification.Name("ConsultationNotification"), object: dict["id"], userInfo: nil)
    ////                let adviceDetailsVC = MyAdviceDetailsViewController()
    ////                let consID = "\(dict["id"] ?? "")"
    ////                adviceDetailsVC.consID = Int(consID) ?? 0
    ////                navigator.pushViewController(adviceDetailsVC, animated: true)
    //    }else if categoryResponse as! String == "prescription-status-updated" {
    //        if self.window?.rootViewController is MyAdvicesViewController {
    //        }else{
    //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PrescriptionNotification"), object: dict["id"])
    //        }
    //}
    //}
    //if let idResponse = dict["id"] {
    //  print(idResponse)
    //}

           completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                            willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    //      if let messageID = userInfo[gcmMessageIDKey] {
    //        print("Message ID: \(messageID)")
    //      }

    // Print full message

    //        UIApplication.shared.applicationIconBadgeNumber += 1
    //      print(userInfo)
    //        let navigator =  UINavigationController()
    //        let dict = userInfo as! [String: Any]
    //        if let categoryResponse = dict["type"] {
    //          print(categoryResponse)
    //            if categoryResponse as! String == "consultation-status-updated" {
    //                if self.window?.rootViewController is MyAdvicesViewController {
    //                }else{
    //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ConsultationNotification"), object: dict["id"])
    //                }
    //            }else if categoryResponse as! String == "prescription-status-updated" {
    //                if self.window?.rootViewController is MyAdvicesViewController {
    //                }else{
    //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PrescriptionNotification"), object: dict["id"])
    //                }
    //        }
    //        }
    //        if let idResponse = dict["id"] {
    //          print(idResponse)
    //        }

    //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound, .badge]])
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print(userInfo)

    //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    //        let navigator =  UINavigationController()
    //        let dict = userInfo as! [String: Any]
    //        if let categoryResponse = dict["type"] {
    //          print(categoryResponse)
    //            if categoryResponse as! String == "consultation-status-updated" {
    //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ConsultationNotification"), object: dict["id"])
    //            }else if categoryResponse as! String == "prescription-status-updated" {
    //                if self.window?.rootViewController is MyAdvicesViewController {
    //                }else{
    //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PrescriptionNotification"), object: dict["id"])
    //                }
    //        }
    //        }
    //        if let idResponse = dict["id"] {
    //          print(idResponse)
    //        }

    completionHandler(.newData)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    Messaging.messaging().appDidReceiveMessage(userInfo)

    //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    print(userInfo)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //            print("APNs token retrieved: \(deviceToken)")

    //var token = ""
    //for i in 0..<deviceToken.count {
    //  token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
    //}
    //print("Notification: APNs token: \((deviceToken as NSData))")
    //print("Notification: APNs token retrieved: \(token)")
    // With swizzling disabled you must set the APNs token here.
    let deviceTokenString = deviceToken.hexString
    UserDefaults.standard.set(deviceTokenString, forKey: "DEVICETOKEN")
    Messaging.messaging().apnsToken = deviceToken
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
     guard let fcmToken = fcmToken else { return }
     print("Firebase registration token: \(fcmToken)")
    }





}

extension UINavigationController{

    func customizeBackArrow(){
        let yourBackImage = UIImage(named: "ic_back")
        self.navigationBar.backIndicatorImage = yourBackImage
       // self.navigationBar.tintColor = Common.offBlackColor
        self.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        navigationItem.leftItemsSupplementBackButton = true
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
           style: .plain, target: self, action: nil)

    }
}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}


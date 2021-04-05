import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase()

        if Firebase.Auth.auth().currentUser == nil {
            setLandingView("LoginView")
        } else {
            setLandingView("PlayerView")
        }

        return true
    }

    func configureFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }

    func setLandingView(_ name: String) {
        print("Landing View: \(name)")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: name, bundle: .main).instantiateInitialViewController()
        window?.makeKeyAndVisible()
    }
}

import UIKit
import FirebaseAuth

class LoginView: UIViewController {
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passwordField : UITextField!

    @IBAction func loginPressed(_ sender : Any) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            RegisterView.showMessage("Invalid Username / Password", success: false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let _ = error {
                // see registerview for correct error handling ;)
                RegisterView.showMessage("Invalid Username / Password", success: false)
            } else {
                guard let unsafeWindow = UIApplication.shared.delegate?.window, let window = unsafeWindow else {
                    fatalError("invalid app state D:")
                }
                window.rootViewController = UIStoryboard(name: "PlayerView", bundle: .main).instantiateInitialViewController()
            }
        }
    }
}

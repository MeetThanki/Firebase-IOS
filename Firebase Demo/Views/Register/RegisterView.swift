import UIKit
import FirebaseAuth
import SwiftMessages

class RegisterView: UIViewController {
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passwordField : UITextField!

    @IBAction func registerPresssed (_ sender : Any) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else{
            RegisterView.showMessage("Invalid Username / Password", success: false)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password ) { user, error in
            if let _ = error {
                // dont show exact error messages on login and registration ( can be used to exfiltrate user data ) !!!
                // i could try and input thousands of emails to see which ones are registered ... and then send them a acam email ;)
                // also makes password bruteforcing possible ( if i can see if the password is wrong etc ... )
                // so always return a generic error message ^^
                RegisterView.showMessage("Invalid Username / Password", success: false)
            } else {
                RegisterView.showMessage("Registered Successfully", success: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    // if its not only for error messages -> dont call the func showErrorMsg :D ^^
    // use 'tenary expressions' for simple if else replacement ( makes the code really nice and readable )
    public class func showMessage(_ body: String, success: Bool) {
        let view = MessageView.viewFromNib(layout: .cardView)

        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 3)

        view.button?.isHidden = true
        view.configureTheme(success ? .success : .error)
        view.configureContent(title: success ? "Success" : "Failure", body: body)
        SwiftMessages.show(config: config, view: view)
    }
    
}

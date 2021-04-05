//
//  LoginView.swift
//  Firebase Demo
//
//  Created by Meet Thanki on 03/04/21.
//

import UIKit
import Firebase

class LoginView: UIViewController {
    
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passwordField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPressed(_ sender : Any){
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else{
            print("Email or password is empty!")
            return
        }
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
          if let error = error {
            print(error.localizedDescription)
          } else {
            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "USERID")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(vc, animated: true)
          }
        }
    }

}

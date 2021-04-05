//
//  RegisterView.swift
//  Firebase Demo
//
//  Created by Meet Thanki on 03/04/21.
//

import UIKit
import FirebaseAuth
import SwiftMessages

class RegisterView: UIViewController {
    
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passwordField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerPresssed (_ sender : Any){
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else{
            print("Email or password is empty!")
            return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text! ) { [self] user, error in
            if let x = error {
                let err = x as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.errorMessage(msg: "wrong password", msgType: "Error")
                case AuthErrorCode.invalidEmail.rawValue:
                    self.errorMessage(msg: "invalid email", msgType: "Error")
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    self.errorMessage(msg: "accountExistsWithDifferentCredential", msgType: "Error")
                case AuthErrorCode.emailAlreadyInUse.rawValue: //<- Your Error
                    self.errorMessage(msg: "email is already in use", msgType: "Error")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
                //return
            } else {
                //continue to app
                self.errorMessage(msg: "Registered Successfully", msgType: "Success")
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func errorMessage(msg : String,msgType : String){
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 3)
        let view = MessageView.viewFromNib(layout: .cardView)

        var msgt : Int = 0
        if msgType == "Error" {
            msgt = 0
        }else{
            msgt = 1
        }
        //0 = error, 1 = success
        if msgt == 0 {
            view.configureTheme(.error)
            view.button?.isHidden = true
            view.configureContent(title: "Message", body: msg)
            SwiftMessages.show(config: config, view: view)
        }else{
            view.configureTheme(.success)
            view.button?.isHidden = true
            view.configureContent(title: "Message", body: msg)
            SwiftMessages.show(config: config, view: view)
        }
    }
    
}

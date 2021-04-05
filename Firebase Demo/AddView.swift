//
//  AddView.swift
//  Firebase Demo
//
//  Created by Meet Thanki on 17/03/21.
//

import UIKit
import Firebase
class AddView: UIViewController {
    
    @IBOutlet weak var playerName : UITextField!
    @IBOutlet weak var playerScore : UITextField!
    
    private let database = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onAdd(_ sender : Any){
        let object : [String : Any] = [
            "playerName" : playerName.text!,
            "playerScore" : playerScore.text!
        ]
        
        database.child("FavoritePlayers").childByAutoId().setValue(object)
        
        self.navigationController?.popViewController(animated: true)
    
    }
}

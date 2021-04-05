import UIKit
import FirebaseDatabase

class AddView: UIViewController {
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerScore: UITextField!
    
    private let ref = Database.database().reference(withPath: "FavoritePlayers")
    
    @IBAction func onAdd(_ sender : Any) {
        let object: [String: Any] = [
            "playerName" : playerName.text!,
            "playerScore" : playerScore.text!
        ]
        
        #warning("needs error handling ( empty playerName, ...")
        ref.childByAutoId().setValue(object)
        
        navigationController?.popViewController(animated: true)
    }
}

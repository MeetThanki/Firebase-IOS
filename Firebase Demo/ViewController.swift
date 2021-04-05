//
//  ViewController.swift
//  Firebase Demo
//
//  Created by Meet Thanki on 14/03/21.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var tableView : UITableView!
    var myPlayerSection: [PlayerList] = []
    var myPlayers = [Players]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        // for fetching
        fetchData()
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddView")
            as? AddView
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func fetchData(){
        database.child("FavoritePlayers").observe(.value) { snapshot in
            do {
                guard let value = snapshot.value else { return }
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let dict = try JSONDecoder().decode([String: Players].self, from: jsonData)
                self.myPlayers = [Players]()
                self.myPlayers.append(contentsOf: Array(dict.values))
                self.tableView.reloadData()
                print(value)
            } catch let error {
                print(error)
            }
        }
    }
    
    // table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPlayers.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? ViewCell {
            cell.playerName.text = self.myPlayers[indexPath.row].playerName
            cell.playerScore.text = self.myPlayers[indexPath.row].playerScore
        }
        return cell
    }
}

class ViewCell : UITableViewCell{
    @IBOutlet weak var playerName : UILabel!
    @IBOutlet weak var playerScore : UILabel!
}

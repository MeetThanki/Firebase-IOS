import UIKit
import FirebaseDatabase

class PlayerView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let ref = Database.database().reference(withPath: "FavoritePlayers")
    private var myPlayers: [Players] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ref.observe(.value) { snapshot in
            let value = snapshot.value ?? ""
            let jsonData: Data = (try? JSONSerialization.data(withJSONObject: value, options: [])) ?? Data()
            let dict = (try? JSONDecoder().decode([String: Players].self, from: jsonData)) ?? [:]

            self.myPlayers = Array(dict.values)
            self.tableView.reloadData()
        }
    }
}

extension PlayerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPlayers.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ViewCell {
            cell.playerName.text = myPlayers[indexPath.row].playerName
            cell.playerScore.text = myPlayers[indexPath.row].playerScore
        }
    }
}

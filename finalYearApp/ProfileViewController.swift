import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    
    var posts: [Dictionary<String, Any>] = [
        [
            "image ": "Screenshot",
            "exercise" : "Back-Squat",
            "weights": "40",
            "sets": "4",
            "reps": "6"
        ],
        [
            "image ": "Screenshot",
            "exercise" : "Back-Squat",
            "weights": "45",
            "sets": "4",
            "reps": "6"
        ],
        [
            "image ": "Screenshot",
            "exercise" : "Back-Squat",
            "weights": "60",
            "sets": "4",
            "reps": "3"
        ]
    ]
    
    let cellIndentifier: String = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let character = posts[indexPath.row]
        
        cell.exerciseLabel.text = character["exercise"] as? String
        cell.weightsLabel.text = character["weights"] as? String
        cell.setsLabel.text = character["sets"] as? String
        cell.repsLabel.text = character["reps"] as? String
        cell.screenshotImage.image = character["image"] as? UIImage
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    @IBAction func logOutButton(_ sender: Any) {
    
    do {
        try Auth.auth().signOut()
            dismiss(animated: true, completion: nil )
            }   catch {
            print("There was a problem logging out")
            }
    }

}

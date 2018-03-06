import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var ref: DatabaseReference!
    var postList = [Post]()
    var databaseHandle: DatabaseHandle!
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [String]()
//        [Dictionary<String, Any>] = [
//        [
//            "image": #imageLiteral(resourceName: "Screenshot"),
//            "exercise" : "Back-Squat",
//            "weights": "40",
//            "sets": "4",
//            "reps": "6"
//        ],
//        [
//            "image": #imageLiteral(resourceName: "Screenshot"),
//            "exercise" : "Back-Squat",
//            "weights": "45",
//            "sets": "4",
//            "reps": "6"
//        ],
//        [
//            "image": #imageLiteral(resourceName: "Screenshot"),
//            "exercise" : "Back-Squat",
//            "weights": "60",
//            "sets": "4",
//            "reps": "3"
//        ]
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        ref = Database.database().reference()
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? String
            if let actualPost = post {
            self.posts.append(actualPost)
            self.tableView.reloadData()
            }
        })
        fecthUsers()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")

    }
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController

    }
    
    func fecthUsers(){
        
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
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        let character = posts[indexPath.row]
        
//        Cell.exerciseLabel.text = character["exercise"] as? String
//        Cell.weightsLabel.text = character["weights"] as? String
//        Cell.setsLabel.text = character["sets"] as? String
//        Cell.repsLabel.text = character["reps"] as? String
//        Cell.screenShotImage.image = character["image"] as? UIImage
        
        Cell.selectionStyle = .none
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    
    @IBAction func addPost(_ sender: Any) {
        
        ref?.child("Posts").childByAutoId().setValue("Please work for me Firebase")
        
        let alert = UIAlertController(title: "Add Exercise", message: nil, preferredStyle: .alert)
        alert.addTextField { (exerciseTF) in
        exerciseTF.placeholder = "Enter Exercise"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let exercise = alert.textFields?.first?.text else { return }
            print(exercise)
            //self.add(Post)
        
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func add(_ Post: Dictionary<String, Any>) {
        let index = 0
        //postList.insert(Post, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
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

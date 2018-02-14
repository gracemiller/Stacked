import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var postList = [Post]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Dictionary<String, Any>] = [
        [
            "image": "Snapshot",
            "exercise" : "Back-Squat",
            "weights": "40",
            "sets": "4",
            "reps": "6"
        ],
        [
            "image": "Screenshot",
            "exercise" : "Back-Squat",
            "weights": "45",
            "sets": "4",
            "reps": "6"
        ],
        [
            "image": "Screenshot",
            "exercise" : "Back-Squat",
            "weights": "60",
            "sets": "4",
            "reps": "3"
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        fecthUsers()
        
//        nameLabel.text = animalObject?.name
//        descriptionTextView.text = animalObject?.description
//        //Creates URL for images
//        let url = URL(string: (animalObject?.picture)!)
//        //Calls data function and passes the URL of the image which returns, data, response and error
//        getDataFromUrl(url: url!) { data, response, error in
//            //Set varible for data
//            guard let data = data, error == nil else { return }
//            //Gets to main thread which handles UI
//            DispatchQueue.main.async {
//                //Sets image based on data returned
//                self.imageView.image = UIImage(data: data)!
//            }
//        }
//    }
        
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")

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
        
        Cell.exerciseLabel.text = character["exercise"] as? String
        Cell.weightsLabel.text = character["weights"] as? String
        Cell.setsLabel.text = character["sets"] as? String
        Cell.repsLabel.text = character["reps"] as? String
        Cell.screenShotImage.image = character["image"] as? UIImage
        
        Cell.selectionStyle = .none
        
        return Cell
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

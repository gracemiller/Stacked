    //import UIKit
    //import Firebase
    //
    //class NewExerciseViewController: UIViewController {
    //    
    //    let ref = Database.database().reference()
    //    var posts = [post]()
    //    
    //    @IBOutlet var weightsTextField: UITextField!
    //    @IBOutlet var setsTextField: UITextField!
    //    @IBOutlet var repsTextField: UITextField!
    //    
    //    @IBOutlet var saveButton: UIButton!
    //    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        
    //        weightsTextField.delegate = self as! UITextFieldDelegate
    //        setsTextField.delegate = self as! UITextFieldDelegate
    //        repsTextField.delegate = self as! UITextFieldDelegate
    //
    //        ref.observe(.value) { snapshot in
    //            print ("New Post")
    //            
    //            self.posts.removeAll()
    //            
    //            for message in snapshot.children {
    //                let posts = self.posts as! DataSnapshot
    //                let newPost = Post(snapshot: posts)
    //                self.posts.append(newPost)
    //                
    //            }
    //            self.posts.reverse()
    //            
    //            
    //            //self.tableView.reloadData()
    //        }
    //        
    //    }
    //    
    //
    //    
    //    @IBAction func saveButton(_ sender: Any) {
    //        
    //        guard let text = weightsTextField.text else {return}
    //        
    //        weightsTextField.text = nil
    //        let userRef = ref.childByAutoId()
    //        
    //        let dict = [
    //            "exercise" : text,
    //            "weights": Int.self,
    //            "reps": Int.self,
    //            "sets": Int.self
    //            ] as [String : Any]
    //        userRef.setValue(dict)
    //    }
    //    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        weightsTextField.resignFirstResponder()
    //        setsTextField.resignFirstResponder()
    //        repsTextField.resignFirstResponder()
    //
    //    }
    //
    //    
    //    
    //}
    //
    //
    //extension ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return posts.count
    //    }
    //    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "post")!
    //        
    //        let post = posts[indexPath.row]
    //        
    //        cell.textLabel?.text = "Hello"
    //        cell.detailTextLabel?.text = Post.user
    //        
    //        
    //        return cell
    //    }
    //    
    //    
    //}
    //
    //

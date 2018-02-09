import UIKit
import Firebase

class ProfileViewController: UIViewController {

//    @IBOutlet var tableVideoStorage: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

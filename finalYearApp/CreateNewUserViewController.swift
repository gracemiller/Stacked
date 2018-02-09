import UIKit
import FirebaseAuth

class CreateNewUserViewController: UIViewController {
    
    @IBOutlet var usernameSignUp: UITextField!
    @IBOutlet var emailSignUp: UITextField!
    @IBOutlet var passwordSignUp: UITextField!
    @IBOutlet var confirmPasswordSignUp: UITextField!
    @IBOutlet var genderSignUp: UISegmentedControl!
    
    @IBOutlet var backToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backToButton(_ sender: UIButton) {
    }
}


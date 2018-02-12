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
    
    @IBAction func backToLogin(_ sender: UIButton) {}
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let _ = usernameSignUp.text, let email = emailSignUp.text, let password = passwordSignUp.text, let confirmPassowrd = confirmPasswordSignUp.text else {
            return
        }
    
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let firebaseError = error {
            print(firebaseError.localizedDescription)
            return
        }
    })
    
}

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameSignUp.resignFirstResponder()
        emailSignUp.resignFirstResponder()
        passwordSignUp.resignFirstResponder()
        confirmPasswordSignUp.resignFirstResponder()
        
    }
}


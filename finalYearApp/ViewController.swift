import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createAccountButton(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                
                print ("success")
            })
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
            if let email = emailTextField.text, let password = passwordTextField.text{
                
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in

                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        return
                    }
                    
                    print ("success")
                })
            }
    }
}


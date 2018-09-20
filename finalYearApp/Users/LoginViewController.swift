import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //LOGIN IN
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                print(user)
                self.presentLoggedInScreen()
            }
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self.errorLabel.text = "Incorrect email/password"
                return
            }
        })
    }
    
    
    func presentLoggedInScreen() {

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoggedInViewController: LoggedInViewController = storyboard.instantiateViewController(withIdentifier: "LoggedInVC") as! LoggedInViewController

        self.present(LoggedInViewController, animated: true, completion: nil)


    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }

}

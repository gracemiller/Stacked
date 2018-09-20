import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateNewUserViewController: UIViewController {
    
    @IBOutlet var usernameSignUp: UITextField!
    @IBOutlet var emailSignUp: UITextField!
    @IBOutlet var passwordSignUp: UITextField!
    @IBOutlet var confirmPasswordSignUp: UITextField!
    @IBOutlet var passwordValidation: UILabel!
    @IBOutlet var confirmImage: UIImageView!
    @IBOutlet var backToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameSignUp.text = "grace"
        emailSignUp.text = "grace+1@miller.com"
        passwordSignUp.text = "123456"
        confirmPasswordSignUp.text = "123456"

        
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        guard let _ = usernameSignUp.text, let email = emailSignUp.text, let password = passwordSignUp.text, let confirmPassword = confirmPasswordSignUp.text else {
            return }
        
        guard password == confirmPassword else {
            passwordValidation.text = "Passwords don't match"
            return
        }
        
        let ref = Database.database().reference().root
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error == nil {
                ref.child("users").child((user?.uid)!).setValue(email, withCompletionBlock: { error, ref in
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let _ = user {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Test") as! PageContainerViewController
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                    })
                })
                
            } else {
                if let _ = error {
                    self.passwordValidation.text = "This email already exists"
                    return
                }
            }
            
        })
    }
    
    @IBAction func confirmPassword(_ sender: Any) {
        if confirmPasswordSignUp.text == passwordSignUp.text {
            confirmImage.image = #imageLiteral(resourceName: "green tick")
            passwordValidation.text = ""
            } else {
            confirmImage.image = #imageLiteral(resourceName: "cross")
            passwordValidation.text = "Passwords do not match"
            
            }

        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameSignUp.resignFirstResponder()
        emailSignUp.resignFirstResponder()
        passwordSignUp.resignFirstResponder()
        confirmPasswordSignUp.resignFirstResponder()
        
    }
}


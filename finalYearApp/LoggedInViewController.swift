import UIKit
import FirebaseAuth


class LoggedInViewController: UIViewController {

    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            dismiss(animated: true, completion: nil )
            }   catch {
            print("There was a problem logging out")
        
            
        }
   
    }
    
}
 

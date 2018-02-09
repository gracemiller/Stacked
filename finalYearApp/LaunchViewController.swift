import UIKit
import Firebase

class LaunchViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)

        let viewController: UIViewController

        if let _ = Auth.auth().currentUser {
            viewController = storyboard?.instantiateViewController(withIdentifier: "LoggedInVC") as! LoggedInViewController
        } else {
            viewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        }

        present(viewController, animated: true)
    }
    
    func logout() {
        try! Auth.auth().signOut()
        //appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    

}

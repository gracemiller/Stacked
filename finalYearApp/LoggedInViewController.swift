import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CameraVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as UIViewController!
        self.addChildViewController(CameraVC!)
        self.scrollView.addSubview((CameraVC!.view))
        CameraVC?.didMove(toParentViewController: self)
        CameraVC?.view.frame = scrollView.bounds
        
        let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as UIViewController!
        self.addChildViewController(ProfileVC!)
        self.scrollView.addSubview((ProfileVC!.view))
        ProfileVC?.didMove(toParentViewController: self)
        ProfileVC?.view.frame = scrollView.bounds
        
        var ProfileVCFrame: CGRect = (ProfileVC?.view.frame)!
        ProfileVCFrame.origin.x = self.view.frame.width
        ProfileVC?.view.frame = ProfileVCFrame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height)
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            dismiss(animated: true, completion: nil )
            }   catch {
            print("There was a problem logging out")
        
            
        }
   
    }
    
}
 

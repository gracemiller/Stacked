import UIKit

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController!
        self.addChildViewController(profileVC!)
        self.scrollView.addSubview((profileVC!.view))
        profileVC?.didMove(toParentViewController: self)
        profileVC?.view.frame = scrollView.bounds
        
        let cameraVC = self.storyboard?.instantiateViewController(withIdentifier: "cameraVC") as! CameraViewController!
        self.addChildViewController(cameraVC!)
        self.scrollView.addSubview((cameraVC!.view))
        cameraVC?.didMove(toParentViewController: self)
        cameraVC?.view.frame = scrollView.bounds
        
        var cameraVCFrame: CGRect = (cameraVC?.view.frame)!
        cameraVCFrame.origin.x = self.view.frame.width
        cameraVC?.view.frame = cameraVCFrame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height)
        
    }

    
}

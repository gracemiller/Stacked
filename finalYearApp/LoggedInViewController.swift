import UIKit
import FirebaseDatabase
import FirebaseStorage

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var cameraVC: CustomCameraViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.delegate = self
        
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController!
        self.addChildViewController(profileVC!)
        self.scrollView.addSubview((profileVC!.view))
        profileVC?.didMove(toParentViewController: self)
        profileVC?.view.frame = scrollView.bounds
        
        cameraVC = self.storyboard?.instantiateViewController(withIdentifier: "cameraVC") as! CustomCameraViewController!
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


//extension LoggedInViewController: UIScrollViewDelegate {
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
//        if page == 1 {
//        cameraVC.captureSession
//        }
//    }
//
//}


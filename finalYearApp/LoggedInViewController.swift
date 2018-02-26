import UIKit
import FirebaseDatabase
import FirebaseStorage

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var recorderVC: RecorderViewController!
    var arDemoVC: ARDemoViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! UINavigationController!
        self.addChildViewController(profileVC!)
        self.scrollView.addSubview((profileVC!.view))
        profileVC?.didMove(toParentViewController: self)
        profileVC?.view.frame = scrollView.bounds
        
        recorderVC = self.storyboard?.instantiateViewController(withIdentifier: "recorderVC") as! RecorderViewController!
        self.addChildViewController(recorderVC!)
        self.scrollView.addSubview((recorderVC!.view))
        recorderVC?.didMove(toParentViewController: self)
        recorderVC?.view.frame = scrollView.bounds
        
        var recorderVCFrame: CGRect = (recorderVC?.view.frame)!
        recorderVCFrame.origin.x = self.view.frame.width
        recorderVC?.view.frame = recorderVCFrame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height)
        
        arDemoVC = self.storyboard?.instantiateViewController(withIdentifier: "arDemoVC") as! ARDemoViewController!
        self.addChildViewController(arDemoVC!)
        self.scrollView.addSubview((arDemoVC!.view))
        arDemoVC?.didMove(toParentViewController: self)
        arDemoVC?.view.frame = scrollView.bounds

        var arDemoVCFrame: CGRect = (arDemoVC?.view.frame)!
        arDemoVCFrame.origin.x = self.view.frame.width
        arDemoVC?.view.frame = arDemoVCFrame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        
    }

    
}

extension LoggedInViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        if page == 3 {
        arDemoVC.ARSCsceneView()
        }
    }

}


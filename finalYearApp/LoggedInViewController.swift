import UIKit
import FirebaseDatabase
import FirebaseStorage

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var recorderVC: RecorderViewController!
    var arDemoVC: ARDemoViewController!
    
    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "profileVC") as! UINavigationController
        self.addChildViewController(profileVC)
        self.scrollView.addSubview(profileVC.view)
        profileVC.didMove(toParentViewController: self)
        profileVC.view.frame = scrollView.bounds
        
        vcs.append(profileVC)
        
        
        recorderVC = self.storyboard?.instantiateViewController(withIdentifier: "recorderVC") as! RecorderViewController
        vcs.append(recorderVC)
        self.addChildViewController(recorderVC)
        self.scrollView.addSubview(recorderVC.view)
        recorderVC.didMove(toParentViewController: self)
        recorderVC.view.frame = scrollView.bounds
        
        
        var recorderVCFrame: CGRect = (recorderVC?.view.frame)!
        recorderVCFrame.origin.x = self.view.frame.width
        recorderVC?.view.frame = recorderVCFrame
        

        
        
        arDemoVC = self.storyboard?.instantiateViewController(withIdentifier: "arDemoVC") as! ARDemoViewController
        vcs.append(arDemoVC)
        self.addChildViewController(arDemoVC)
        self.scrollView.addSubview(arDemoVC.view)
        arDemoVC.didMove(toParentViewController: self)
        
        
        arDemoVC?.view.frame = CGRect(origin: self.view.frame.origin, size: self.view.frame.size)
        arDemoVC.view.frame.origin.x = self.view.frame.width * 2
        
        calculateWidth()
    }
    
    func calculateWidth() {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(vcs.count), height: view.frame.height)
    }

    
}

extension LoggedInViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        if page == 2 {

        }
    }

}


import UIKit
import FirebaseDatabase
import FirebaseStorage

class LoggedInViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var recorderVC: VideoRecorderViewController!
    var arDemoVC: ARDemoViewController!
    
    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "profileVC") as! UINavigationController
        vcs.append(profileVC)

        recorderVC = self.storyboard?.instantiateViewController(withIdentifier: "recorderVC") as! VideoRecorderViewController
        vcs.append(recorderVC)
        
        arDemoVC = self.storyboard?.instantiateViewController(withIdentifier: "arDemoVC") as! ARDemoViewController
        vcs.append(arDemoVC)
        
        addChildren()
        calculateWidth()
    }
    
    func addChildren() {
        for (i, vc) in vcs.enumerated() {
            addAsChildViewControllerToScrollView(vc, toView: scrollView, index: i)
        }
    }
    
    func calculateWidth() {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(vcs.count), height: view.frame.height)
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.isUserInteractionEnabled = false
    }

}

extension LoggedInViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        if page == 1 {
            recorderVC.captureSession.startRunning()
        } else {
            recorderVC.captureSession.stopRunning()
        }
    }

}



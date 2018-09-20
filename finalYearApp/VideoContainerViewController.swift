import UIKit
import AVKit
import FirebaseStorage

class VideoContainerViewController: UIViewController {

    var player: AVPlayer!
    
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let avViewController = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! AVPlayerViewController
        avViewController.player = player
        addAsChildViewController(avViewController, toView: self.view)
        let asset = player.currentItem!.asset as! AVURLAsset
  
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue" {
            let newExerciseVC = segue.destination as! NewExerciseViewController
            newExerciseVC.asset = player.currentItem!.asset as! AVURLAsset
        }
        
    }

}

extension VideoContainerViewController: AVAssetResourceLoaderDelegate {
}

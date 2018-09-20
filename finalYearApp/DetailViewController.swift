import Foundation
import UIKit
import AVKit
import FirebaseStorage
import Firebase

class DetailViewController: UIViewController {
    
    var player: AVPlayer!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension DetailViewController: AVAssetResourceLoaderDelegate {

}



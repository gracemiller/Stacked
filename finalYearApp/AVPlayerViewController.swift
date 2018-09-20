import Foundation
import UIKit
import AVKit

class VideoViewController: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func didEnd() {
        player!.seek(to: kCMTimeZero)
        player!.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player!.play()
    }
    
}



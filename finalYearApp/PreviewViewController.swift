import Foundation
import UIKit

class PreviewViewController: UIViewController {
    
    var image: UIImage! 

    @IBOutlet var photo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image

    }

    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
        
    }
    
}

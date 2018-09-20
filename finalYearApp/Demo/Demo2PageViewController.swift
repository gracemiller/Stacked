import Foundation
import UIKit

protocol DemoDismiss {
    func shouldDismiss()
}

class Demo2ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bulletPoint3: UITextView!
    @IBOutlet var bulletPoint2: UITextView!
    @IBOutlet var bulletPoint1: UITextView!
    
    var image: UIImage!
    var titleText: String!
    var point1: String!
    var point2: String!
    var point3: String!

    
    var delegate: DemoDismiss?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        titleLabel.text = titleText
        bulletPoint1.text = point1
        bulletPoint2.text = point2
        bulletPoint3.text = point3

        
    }

    @IBAction func getStarted(_ sender: Any) {
        delegate?.shouldDismiss()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Get Started" {
            _ = segue.destination as! LoggedInViewController
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}

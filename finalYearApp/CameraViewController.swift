import UIKit
import FirebaseDatabase
import FirebaseStorage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var name:String = ""
    var amount:Float = 0
    
    var ref:DatabaseReference?
    var storage:StorageReference?
    
    var camDidOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        storage = Storage.storage().reference()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if photoImageView.image == nil {
            if self.camDidOpen == true {
                //present(CameraViewController, animated: true, completion: nil)
                //presentingViewController?.dismiss(animated: true)
            } else {
                self.loadCamera()
            }
        }
    }
    
    func loadCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.camDidOpen = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    //takes the picture taken to be displayed
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo:[NSObject : AnyObject]!){
        photoImageView.image = image
        
        self.dismiss(animated: true, completion: nil);
    }
}

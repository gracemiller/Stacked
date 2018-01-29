import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraButton = UIImagePickerController()
            cameraButton.delegate = self
            cameraButton.sourceType = UIImagePickerControllerSourceType.camera;
            
            cameraButton.allowsEditing = false
            self.present(cameraButton, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func photoLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let cameraButton = UIImagePickerController()
            cameraButton.delegate = self
            cameraButton.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            cameraButton.allowsEditing = true
            self.present(cameraButton, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let imageData = UIImageJPEGRepresentation(cameraImage.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        saveNotice()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]) {
        cameraImage.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func saveNotice() {
        
        let alertController = UIAlertController(title: "Image Saved!", message: "Your Image was successfully saved", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

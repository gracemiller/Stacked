import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ImagePreviewViewController: UIViewController {
    
    let ref = Database.database().reference()
    let photoPreview = CapturedImageView()
    
    var image: UIImage!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addSubview(photoPreview)
        photoPreview.saveButton.addTarget(self, action: #selector(save),for: .touchUpInside)
        photoPreview.imagePreviewView.image = image
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    @objc func save() {
        if image != nil {
            let newPost = Post(image: image)
            newPost.save()
            self.dismiss(animated: true, completion: nil)
            
        }
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //dismiss(animated: true, completion: nil)

    }
    
    
    
//    func updateDatabase(post: UIImage) {
//        let uuid = "Grace-Miller"
//        let userRef = ref.child(uuid)
//
//        let dict = [
//            "reps": String.self,
//            "weights": String.self,
//            "sets": String.self,
//            "screenshot": #imageLiteral(resourceName: "Screenshot")
//            ] as [String : Any]
//
//        userRef.setValue(dict)
//    }
    
}


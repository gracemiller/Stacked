import UIKit

class ImagePreviewViewController: UIViewController {
    
    let photoPreview = CapturedImageView()
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoPreview)
        photoPreview.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        photoPreview.saveButton.addTarget(self, action: #selector(save),for: .touchUpInside)
        
        photoPreview.imagePreviewView.image = image
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
}


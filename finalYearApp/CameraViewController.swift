import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseDatabase

class CameraViewController: UIViewController {

    @IBOutlet var selectedImageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var takenImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
  
        }
        
}
//    var captureSession = AVCaptureSession()
//    var backCamera: AVCaptureDevice?
//    var frontCamera: AVCaptureDevice?
//    var currentCamera: AVCaptureDevice?
//
//    var photoOutput: AVCapturePhotoOutput?
//
//    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
//    //var imageUploadManager: ImageUploadManager?
//
//    var image: UIImage?
//
//    @IBOutlet var photo: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        photo.image = self.image
//
//        setupCameraSession()
//        setupDevice()
//        setupRunningCaptureSession()
//
//        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
//
//    }
//
////    @objc func showImagePicker() {
////        let imagePickerController = UIImagePickerController()
////        imagePickerController.delegate = self
////        imagePickerController.allowsEditing = false
////        imagePickerController.sourceType = .camera
////        present(imagePickerController, animated: true, completion: nil)
////
////    }
//
//    func setupCameraSession() {
//        captureSession.sessionPreset = AVCaptureSession.Preset.photo
//    }
//
//    func setupDevice() {
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
//        let devices = deviceDiscoverySession.devices
//
//        for device in devices {
//            if device.position == AVCaptureDevice.Position.back {
//                backCamera = device
//            } else if device.position == AVCaptureDevice.Position.front {
//                frontCamera = device
//            }
//
//        }
//        currentCamera = backCamera
//    }
//
//    func setupRunningCaptureSession() {
//        captureSession.startRunning()
//
//    }
//
//    @IBAction func cameraButton(_ sender: Any) {
//        let settings = AVCapturePhotoSettings()
//        photoOutput?.capturePhoto(with: settings, delegate: self as! AVCapturePhotoCaptureDelegate)
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
//            let cameraButton = UIImagePickerController()
//            cameraButton.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//            cameraButton.sourceType = UIImagePickerControllerSourceType.camera;
//
//            cameraButton.allowsEditing = false
//            self.present(cameraButton, animated: true, completion: nil)
//
//        }
//    }
//
//
//
//    @IBAction func photoLibrary(_ sender: UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let cameraController = UIImagePickerController()
//            cameraController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//            cameraController.sourceType = UIImagePickerControllerSourceType.photoLibrary;
//            cameraController.allowsEditing = true
//            self.present(cameraController, animated: true, completion: nil)
//        }
//    }
//
//
//    @IBAction func cancelButton(_ sender: UIButton) {
//    dismiss(animated: true, completion: nil)
//
//    }
//
//    @IBAction func saveButton(_ sender: UIButton) {
//    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        dismiss(animated: true, completion: nil)
//
//    }
//
//}
//
//
////extension CameraViewController: UIImagePickerControllerDelegate {
////
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
////        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
////        selectedImageView.image = chosenImage
////        picker.dismiss(animated: true, completion: nil)
////    }
////
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        picker.dismiss(animated: true, completion: nil)
////    }
////
////}
//
////extension CameraViewController: UIImagePickerControllerDelegate {
////
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        picker.dismiss(animated: true, completion: nil)
////    }
////
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
////        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
////            picker.dismiss(animated: true, completion: nil)
////
////            imageUploadManager = ImageUploadManager()
////            imageUploadManager?.uploadImage(image, progressBlock: { (percentage) in
////                print(percentage)
////            }, completionBlock: { [weak self] (fileURL, errorMessage) in
////                guard self != nil else {
////                    return
////                }
////
////                print(fileURL!)
////                print(errorMessage!)
////
////            })
////        }
////    }
////
////}
//
//
//
    
}

    extension CameraViewController : UIImagePickerControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.takenImage = image
            self.selectedImageView.image = self.takenImage
            self.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
        
}

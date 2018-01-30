import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?

    //@IBOutlet var cameraImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCameraSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        setupRunningCaptureSession()

    }
    
    func setupCameraSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
            
        }
        currentCamera = backCamera
    }
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
           print(error)
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func setupRunningCaptureSession() {
        captureSession.startRunning()
        
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self as! AVCapturePhotoCaptureDelegate)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraButton = UIImagePickerController()
            cameraButton.delegate = self
            cameraButton.sourceType = UIImagePickerControllerSourceType.camera;
            
            cameraButton.allowsEditing = false
            self.present(cameraButton, animated: true, completion: nil)
            
        }
    }
    
    
    
//    @IBAction func photoLibrary(_ sender: UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let cameraButton = UIImagePickerController()
//            cameraButton.delegate = self
//            cameraButton.sourceType = UIImagePickerControllerSourceType.photoLibrary;
//            cameraButton.allowsEditing = true
//            self.present(cameraButton, animated: true, completion: nil)
//        }
//    }
    
}

//extension ViewController: AVCapturePhotoCaptureDelegate {
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let imageData = photo.fileDataRepresentation() {
//        image = UIImage(data: imageData)
//        performSegue(withIdentifier: "showPhotoSegue", sender: nil)
//        }
//    }
//
//}


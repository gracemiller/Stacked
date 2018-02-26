import UIKit
import AVFoundation
import AVKit

class CustomCameraViewController: UIViewController {
    
    var frame: CGRect = UIScreen.main.bounds    
    
    @objc lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Camer_Button"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.frame.size = CGSize(width: 100, height: 100)
        button.frame.origin = CGPoint(x: frame.midX-50, y: frame.midY+200)
        return button
    }()
    
    var captureSession = AVCaptureSession()
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCaptureSession()
        setupDevices()
        setUpCaptureSessionInput(position: .back)
        setupPreviewLayer()
        startRunningCaptureSession()
        recordButton.addTarget(self, action: #selector(getter: recordButton), for: .touchUpInside)
        
        // Here we used dot notation to implement the handle tap function, to the CameraViewController, we created in the extension at the bottom.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomCameraViewController.handleTap(_:)))
        tapGestureRecognizer.delegate = self as UIGestureRecognizerDelegate
        tapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setButtonsEnabled(_ enabled: Bool) {
        self.recordButton.isEnabled = enabled
    }
    
    private func setUpCaptureSessionInput(position: AVCaptureDevice.Position) {
        switch position {
        case .back:
            currentCamera = backCamera
        case .front:
            currentCamera = frontCamera
        default:
            currentCamera = backCamera
        }
        
        setupInputOutput()
    }
    
    // This is the function that will be called when the take photo button is pressed.
    @objc func takePhoto(){
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
    }
    
    // This function sets up the capture session as well as the photo ouput instance and its settings.
    private func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        photoOutput = AVCapturePhotoOutput()
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        captureSession.addOutput(photoOutput!)
    }
    
    // This function allows you to have the application discover the devices camera(s)
    private func setupDevices(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
    }
    
    private func setupInputOutput(){
        captureSession.beginConfiguration()
        if let currentInput = captureSession.inputs.first {
            captureSession.removeInput(currentInput)
        }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error)
        }
        captureSession.commitConfiguration()
    }
    
    // This function creates a layer in the view that will enable a live feed of what your camera is observing.
    private func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    private func startRunningCaptureSession(){
        captureSession.startRunning()
    }
}

// This extension is used because you need to wait until the photo you took "didFinishProcessing" before you can handle the image.
extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            guard let image = image else { return }
            let previewVC = ImagePreviewViewController(image: image)
            present(previewVC, animated: true, completion: nil)
            
        }
    }
}

// This extension is to enable the double tap gesture to switch between front and back camera.
extension CustomCameraViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
        print("doubletapped")
    }
}


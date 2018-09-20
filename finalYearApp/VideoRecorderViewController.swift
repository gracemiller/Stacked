import UIKit
import AVFoundation
import AVKit

class VideoRecorderViewController: UIViewController {
    
    @IBOutlet weak var cameraButton: UIButton!
    
    lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.high
        return session
    }()
    
    var currentDevice: AVCaptureDevice?
    var videoOutput: AVCaptureMovieFileOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var isRecording = false
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.front)
        backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.back)
        
        // Selecting input device
        if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            currentDevice = device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            currentDevice = device
        }
        
        // Get the input data source
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: currentDevice!) else { return }
        
        // Configure AVCaptureMovieFileOutput
        videoOutput = AVCaptureMovieFileOutput()
        
        // Configure the session with the input and the output devices
        if captureSession.canAddInput(captureDeviceInput) {
            captureSession.addInput(captureDeviceInput)
            if captureSession.canAddOutput(videoOutput!) {
                captureSession.addOutput(videoOutput!)
            } else {
                print("captureSession can't add output")
            }
        } else {
            print("captureSession can't add input")
        }
        
        // Configure camera preview layer
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        
        view.bringSubview(toFront: cameraButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
    }
    
    func captureDevice(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [ .builtInWideAngleCamera, .builtInDualCamera, .builtInTelephotoCamera ], mediaType: AVMediaType.video, position: .unspecified).devices
        
        
        for device in devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    func setupInputOutput() {
        
        guard let input = captureSession.inputs[0] as? AVCaptureDeviceInput else { return }
        
        var newDevice: AVCaptureDevice!
        
        if input.device.position == .back {
            newDevice = captureDevice(with: .front)
        } else {
            newDevice = captureDevice(with: .back)
        }
        
        // Create new capture input
        var deviceInput: AVCaptureDeviceInput!
        do {
            deviceInput = try AVCaptureDeviceInput(device: newDevice)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        captureSession.removeInput(input)
        captureSession.addInput(deviceInput)
        
    }
    
    @IBAction func capture(_ sender: UIButton) {
        if !isRecording {
            isRecording = true
            // Animate camera button to indicate it's recording
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
                self.cameraButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: nil)
            // Configure output path in temporary folder
            let outputPath = NSTemporaryDirectory() + "output.mov"
            let outputFileURL = URL(fileURLWithPath: outputPath)
            videoOutput?.startRecording(to: outputFileURL, recordingDelegate: self)
        } else {
            isRecording = false
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.cameraButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
            cameraButton.layer.removeAllAnimations()
            videoOutput?.stopRecording()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAVPlayer" {
            guard let videoContinerViewContoller = segue.destination as? VideoContainerViewController else { return }
            videoContinerViewContoller.player = AVPlayer(url: sender as! URL)
        }
    }
    
}

extension VideoRecorderViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error != nil { print(error?.localizedDescription ?? "") }
        performSegue(withIdentifier: "ShowAVPlayer", sender: outputFileURL)
    }
}



extension VideoRecorderViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        setupInputOutput()
    }
}

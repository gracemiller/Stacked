import Foundation
import UIKit
import AVFoundation

public class CaptureService: NSObject, AVCaptureFileOutputRecordingDelegate {
	
	public let previewLayer: AVCaptureVideoPreviewLayer
	private(set) public var isRecording: Bool
	
	private let session: AVCaptureSession

	private let position: AVCaptureDevice.Position
	private let quality: AVCaptureSession.Preset
	
	private var videoOutput: AVCaptureMovieFileOutput?
    
    init(position: AVCaptureDevice.Position) {
        self.session = AVCaptureSession()
        self.position = position
        self.quality = .hd1280x720
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.isRecording = false
        
//        let videoPlayer = AVPlayer(URL: url)
//        NotificationCenter.default.addObserver(self, selector: Selector(("playerDidFinishPlaying:")),
//                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: previewLayer.currentItem)

        super.init()

        self.configure()
    }
	
	deinit {
		self.session.stopRunning()
	}
	
	private func configure() {
		self.session.sessionPreset = self.quality

		self.configureVideoInput()
		self.configureAudioInput()
		self.configureOutput()
	}
	
	private func configureVideoInput() {
		guard let videoDevice = self.getVideoCaptureDevice() else { return }
		self.configureInput(captureDevice: videoDevice)
	}
	
	private func configureAudioInput() {
		guard let audioDevice = self.getAudioCaptureDevice() else { return }
		self.configureInput(captureDevice: audioDevice)
	}
	
	private func getVideoCaptureDevice() -> AVCaptureDevice? {
		let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera, .builtInTelephotoCamera],
		                                               mediaType: .video,
		                                               position: self.position)
		return session.devices.filter { $0.hasMediaType(.video) && $0.position == self.position }.first
	}
	
	private func getAudioCaptureDevice() -> AVCaptureDevice? {
		let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInMicrophone],
		                                               mediaType: .audio,
		                                               position: .unspecified)
		return session.devices.filter { $0.hasMediaType(.audio) }.first
	}
	
	private func configureInput(captureDevice: AVCaptureDevice) {
		guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice),
			self.session.canAddInput(captureDeviceInput) else { return }
		self.session.addInput(captureDeviceInput)
	}
	
	private func configureOutput() {
		let videoOutput = AVCaptureMovieFileOutput()
		self.videoOutput = videoOutput
		
		if self.session.canAddOutput(videoOutput) {
			self.session.addOutput(videoOutput)
		}
	}

	public func startPreview() {
		self.session.startRunning()
	}
	
	//Record
	
	public func startRecording(fileURL: URL) {
		guard self.isRecording == false,
			let videoOutput = self.videoOutput else { return }
		
		if let connection = videoOutput.connection(with: AVFoundation.AVMediaType.video) {
			if connection.isVideoOrientationSupported {
    
			}
			if connection.isVideoMirroringSupported {
				connection.isVideoMirrored = self.position == .front
			}
		}
		
		if !self.session.isRunning {
			self.session.startRunning()
		}
		
		self.isRecording = true
		
		try? FileManager.default.removeItem(at: fileURL)
		
		videoOutput.startRecording(to: fileURL, recordingDelegate: self)
	}
	
	public func stopRecording() {
		guard self.isRecording == true else { return }
		
		if let videoOutput = self.videoOutput {
			videoOutput.stopRecording()
		}
		
		self.session.stopRunning()
	}

	public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
		self.isRecording = false
	}
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
    }


}

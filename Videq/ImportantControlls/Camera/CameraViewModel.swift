import SwiftUI
import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCaptureMovieFileOutput()
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    // MARK: Video Recorder Properties
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var previewURL: URL?
    @Published var showPreview: Bool = false
    
    //Top Progress Bar
    @Published var recordedDuration: CFloat = 0
    // YOUR OWN TIMING
    @Published var maxDuration: CGFloat = 20
    
    func checkPermission() {
        print ("checkPermission()...")
        
        // first checking camera has got permission...
        switch AVCaptureDevice.authorizationStatus (for: .video) {
        
        case .authorized:
            self.setUp()
            return
            // Setting Up Session...
        case .notDetermined:
            AVCaptureDevice.requestAccess (for: .video) { (status) in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp() {
        print ("setUp()...")
        
        do {
            self.session.beginConfiguration ( )
            
            let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position : .back)
            let videoInput = try AVCaptureDeviceInput (device: videoDevice!)
            
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioInput = try AVCaptureDeviceInput (device: audioDevice!)
            
            // checking and adding to session .. .
            if self.session.canAddInput(videoInput) && self.session.canAddInput(audioInput)  {
                self.session.addInput(videoInput)
                self.session.addInput(audioInput)
            }
            
            // same for output. ...
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func startRecording() {
        let tempURL = NSTemporaryDirectory() + "\(Date() ).mov"
        output.startRecording(to: URL(fileURLWithPath: tempURL) , recordingDelegate: self)
        
        isRecording = true
    }
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print (error.localizedDescription)
            return
        }
        
        //CREATED SUCCESSFULLY
        print(outputFileURL)
        
        self.recordedURLs.append(outputFileURL)
        
        if recordedURLs.count == 1 {
            self.previewURL = outputFileURL
            return
        }
        
    }
}

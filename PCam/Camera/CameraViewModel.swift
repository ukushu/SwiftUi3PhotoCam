import SwiftUI
import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCaptureMovieFileOutput()
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    
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
            
            let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position : .back)
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
}

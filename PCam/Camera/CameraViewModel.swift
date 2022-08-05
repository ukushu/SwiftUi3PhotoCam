import SwiftUI
import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    @Published var picData = Data(count: 0)
    
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
            // setting configs. ..
            self.session.beginConfiguration ( )
            
            // change for your own...
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position : .back)
            let input = try AVCaptureDeviceInput (device: device!)
            
            // checking and adding to session .. .
            if self.session.canAddInput (input) {
                self.session.addInput (input )
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
    
    func takePhoto () {
        print ("takePhoto()...")
        
        DispatchQueue.global(qos: .background).async {
            print ("try to capture the photo...")
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            print ("captured photo...")
            
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
            }
            
            self.session.stopRunning()
        }
    }
    
    func discardPhoto() {
        print ("discardPhoto()...")
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{ self.isTaken.toggle() }
                
                self.picData = Data(count: 0)
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print ("photoOutput()...")
        
        if error != nil {
            print ("Error happened: \(error!.localizedDescription) | \(error.debugDescription)")
            return
        }
        
        print ("Trying to take pic...")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        self.picData = imageData
        
        print ("pic taken...")
    }
    
    func savePhoto() {
        guard let image = UIImage(data : self.picData) else {
            print ("Failed to get image data....")
            return
        }
        
        // saving Image..
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        print ("saved Successfully...")
        
        discardPhoto()
    }
}

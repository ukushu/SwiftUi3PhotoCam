import Foundation
import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    
    func makeUIView (context: Context ) -> UIView {
        let view = UIView( frame : UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session )
        camera.preview.frame = view.frame
        
        // Your Own Properties. ..
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // starting session
        
        camera.session.startRunning()
        return view
    }
    
    func updateUIView ( _ uiView: UIView, context : Context) { }
}

import Foundation
import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var camera: CameraModel
    
    var body: some View {
        GeometryReader { proxy in
            CameraViewInternal(size: proxy.size)
                .environmentObject(camera)
                .alert(isPresented: $camera.alert) {
                    Alert(title: Text("No Camera or Mic access"))
                }
                .onAppear() {
                    camera.checkPermission()
                }
        }
        
    }
}

struct CameraViewInternal: UIViewRepresentable {
    @EnvironmentObject var camera: CameraModel
    var size: CGSize
    
    func makeUIView (context: Context ) -> UIView {
        let view = UIView( frame : UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session )
        camera.preview.frame.size = size
        
        // Your Own Properties. ..
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // starting session
        
        camera.session.startRunning()
        return view
    }
    
    func updateUIView ( _ uiView: UIView, context : Context) { }
}

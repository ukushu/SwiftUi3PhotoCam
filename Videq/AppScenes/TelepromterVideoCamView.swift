import SwiftUI
import AVFoundation
import Foundation
import Introspect

struct TelepromterVideoCamView: View {
    @StateObject var camera = CameraModel()
    @ObservedObject var telepVm = TeleprompterViewModel(miniMode: true)
    
    var body: some View {
        ZStack {
            CameraView()
                .environmentObject(camera)
            
            VStack {
                TeleprompterView(model: telepVm)
                    .teleprompterMini(bgOpacity: telepVm.bgOpacity)
                
                Spacer()
                
                ZStack {
                    BtnReels()
                        .environmentObject(camera)
                    
                    BtnVideoPreview()
                        .environmentObject(camera)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                        .padding(.trailing)
                }
                .padding(.bottom, 30)
            }
        }
        .overlay{
            if let url = camera.previewURL, camera.showPreview {
                VideoPreview(url: url, showPreview: $camera.showPreview)
                    .transition(.move (edge:.trailing))
            }
        }
        .animation(.easeInOut, value: camera.showPreview)
    }
}

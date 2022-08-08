import SwiftUI
import AVFoundation
import Foundation
import Introspect

struct SceneTelepromterVideoCam: View {
    @StateObject var camera = CameraModel()
    @ObservedObject var telepVm = TeleprompterViewModel(miniMode: true)
    
    var body: some View {
        ZStack {
            CameraView()
                .environmentObject(camera)
            
            VStack {
                TeleprompterView(model: telepVm)
                    .teleprompterMini(bgOpacity: telepVm.bgOpacity, editingMode: telepVm.editMode)
                
                Spacer()
            }
            
            if !telepVm.displaySettings {
                CameraControlsView()
                    .environmentObject(camera)
            }
            
            HeaderBgLine()
            
            BackToMainMenuBtn(confirmationNeeded: camera.recordedURLs.count > 0 || camera.isRecording)
            
            SettingsBtns()
            
            VStack {
                Spacer()
                
                TeleprompterSettingsView(model: telepVm)
            }
        }
        .overlay{
            
        }
        .animation(.easeInOut, value: camera.showPreview)
    }
}

extension SceneTelepromterVideoCam {
    func SettingsBtns() -> some View {
        VStack {
            HStack {
                Spacer()
                
                VideoCamSettingsBtn(displaySettings: $telepVm.displaySettings)
                    .padding(.trailing, 10)
                
                TeleprompterSettingsBtn(displaySettings: $telepVm.displaySettings)
                    .padding(.trailing, 15)
            }
            .padding(.top, 5)
            
            Spacer()
        }
    }
}

import SwiftUI
import AVFoundation

struct VideoCamView: View {
    @Binding var isPhotoMode: Bool
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        ZStack{
            
            VStack {
                HStack {
                    Spacer()
                    BtnPhotoVideoSwitcher(isPhotoMode: $isPhotoMode)
                }
                Spacer()
            }
        }
    }
}

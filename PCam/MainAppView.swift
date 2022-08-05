import SwiftUI
import AVFoundation

struct MainAppView : View {
    @State var photoMode: Bool = false
    
    var body: some View {
        if photoMode {
            PhotoCamView(isPhotoMode: $photoMode)
        } else {
            VideoCamView(isPhotoMode: $photoMode)
        }
    }
}

struct BtnPhotoVideoSwitcher: View {
    @Binding var isPhotoMode: Bool
    
    let size: CGFloat = 40
    
    var body: some View {
        Button( action: { isPhotoMode.toggle() } ) {
            if isPhotoMode {
                Image(systemName: "record.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.red)
                    .frame(width: size)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size)
                    .frame(height: size)
            }
        }
    }
}


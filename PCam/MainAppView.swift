import SwiftUI
import AVFoundation

struct MainAppView : View {
    init() {
        Visualizer.start()
    }
    
    var body: some View {
        VideoCamView()
            .background(Color(red: 0, green: 0, blue: 0.01, opacity: 0.01))
    }
}

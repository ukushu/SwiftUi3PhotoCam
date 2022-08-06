import SwiftUI
import AVFoundation

struct MainAppView : View {
    init() {
        Visualizer.start()
    }
    
    var body: some View {
        VideoCamView()
    }
}

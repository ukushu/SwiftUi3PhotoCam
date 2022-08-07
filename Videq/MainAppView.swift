import SwiftUI
import AVFoundation

struct MainAppView : View {
    init() {
        if let langStr = Locale.current.languageCode {
            Visualizer.start()
            print(langStr)
        }
    }
    
    var body: some View {
        MainMenuView()
    }
}

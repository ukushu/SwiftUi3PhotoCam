import SwiftUI
import AVFoundation

struct MainAppView : View {
    @State var startSceenDisplay = true
    init() {
        Visualizer.start()
    }
    
    var body: some View {
        VStack {
            if startSceenDisplay {
                VStack{
                    Image("StartScreenLogo")
                        .resizable()
                        .scaledToFit()
                }
            } else {
                VideoCamView()
                    .background(Color(red: 0, green: 0, blue: 0.01, opacity: 0.01))
            }
        }
        .transition(.scale)
        .animation(.easeInOut, value: startSceenDisplay)
        .onAppear() { splashScreenDisable() }
    }
}

////////////////////
///HELPERS
////////////////////
extension MainAppView {
    func splashScreenDisable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            withAnimation {
                startSceenDisplay.toggle()
            }
        }
    }
}

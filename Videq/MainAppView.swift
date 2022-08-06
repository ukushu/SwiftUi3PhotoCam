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
                SplashScreenView()
            } else {
                MainMenuView()
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

fileprivate struct SplashScreenView : View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("StartScreenLogo")
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .background(.white)
    }
}

extension MainAppView {
    func splashScreenDisable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            withAnimation {
                startSceenDisplay.toggle()
            }
        }
    }
}

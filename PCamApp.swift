import SwiftUI

@main
struct VideqApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .ignoresSafeArea(.all, edges: [.leading,.trailing, .top])
                .statusBar(hidden: true)
        }
    }
}

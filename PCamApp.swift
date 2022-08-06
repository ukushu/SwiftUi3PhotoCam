import SwiftUI

@main
struct VideqApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .ignoresSafeArea(.all, edges: .all)
                .statusBar(hidden: true)
        }
    }
}

import SwiftUI

@main
struct PCamApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .ignoresSafeArea(.all, edges: .all)
                .statusBar(hidden: true)
        }
    }
}

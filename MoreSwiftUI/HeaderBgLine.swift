import Foundation
import SwiftUI

struct HeaderBgLine: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                }
            }
            .frame(height: 30)
            .background(.thinMaterial)
            
            Spacer()
        }
    }
}

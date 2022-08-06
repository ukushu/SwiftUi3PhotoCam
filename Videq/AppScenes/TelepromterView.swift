//
//  TelepromterView.swift
//  Videq
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import SwiftUI

struct TeleprompterSceneView: View {
    @ObservedObject var model = TeleprompterViewModel(miniMode: false)
    
    var body: some View {
        VStack {
            TeleprompterView(model: model)
                .teleprompterMaxi(height: UIScreen.screenHeight - 200)
            
            TeleprompterSettingsView(model: model, isMini: false)
                .padding(.bottom, 20)
                .frame(height: 200)
        }
    }
}

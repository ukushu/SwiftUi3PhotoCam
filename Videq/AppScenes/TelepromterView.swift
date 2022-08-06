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
        ZStack {
            TeleprompterView(model: model)
                .teleprompterMaxi(height: UIScreen.screenHeight)
            
            VStack {
                Spacer()
                
                TeleprompterSettingsView(model: model, isMini: false)
                    .padding(.bottom, 20)
            }
        }
        .background(Color.black)
    }
}

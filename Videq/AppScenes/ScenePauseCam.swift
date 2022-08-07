//
//  PauseCam.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

struct ScenePauseCam: View {
    @StateObject var camera = CameraModel()
    
    @State var zaglushka = true
    
    var body: some View {
        ZStack {
            CameraView()
                .environmentObject(camera)
            
            HeaderBgLine()
            
            SettingsBtns()
            
            CameraControlsView()
                .environmentObject(camera)
        }
    }
}

extension ScenePauseCam {
    func SettingsBtns() -> some View {
        VStack {
            HStack {
                Spacer()
                
                VideoCamSettingsBtn(displaySettings: $zaglushka)
                    .padding(.trailing, 10)
            }
            .padding(.top, 5)
            
            Spacer()
        }
    }
}

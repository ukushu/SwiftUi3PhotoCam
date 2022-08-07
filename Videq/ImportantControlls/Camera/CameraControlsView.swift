//
//  CameraControlsView.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

struct CameraControlsView: View {
    @EnvironmentObject var camera: CameraModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                BtnReels()
                    .environmentObject(camera)
                
                BtnVideoPreview()
                    .environmentObject(camera)
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .padding(.trailing)
            }
            .padding(.bottom, 30)
        }
    }
}

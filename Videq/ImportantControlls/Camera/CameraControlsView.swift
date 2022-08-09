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
                if !camera.isRecording {
                    Button(action: { camera.switchCamera() } ) { SwitchCameraLabel() }
                    .padding(.trailing, 200)
                }
                
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

struct SwitchCameraLabel: View {
    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath.camera")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 40)
            .foregroundColor(.white)
    }
}

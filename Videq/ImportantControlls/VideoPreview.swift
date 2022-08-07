//
//  VideoPreview.swift
//  PCam
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import AVKit
import SwiftUI

struct VideoPreview: View {
    var url: URL?
    @Binding var showPreview: Bool
    
    var body: some View {
        ZStack{
            if let url = url, showPreview {
                GeometryReader{ proxy in
                    VideoPlayer(player: AVPlayer(url: url))
                        .aspectRatio (contentMode :.fit)
                        .frame (width : proxy.size.width, height : proxy.size.height)
                }
            } else {
                Text("Failed to display preview")
            }
            
            HeaderBgLine()
            
            BackBtn{ showPreview.toggle() }
        }
        .background(Color.black)
    }
}

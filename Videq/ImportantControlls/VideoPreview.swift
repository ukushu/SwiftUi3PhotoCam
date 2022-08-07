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
    var url: URL
    @Binding var showPreview: Bool
    
    var body: some View{
        GeometryReader{proxy in
            VideoPlayer(player : AVPlayer(url: url))
                .aspectRatio (contentMode :.fill)
                .frame (width : proxy.size.width, height : proxy.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(alignment: .topLeading) {
                    BtnBack(showPreview: $showPreview)
                }
        }
    }
}

struct BtnBack: View {
    @Binding var showPreview: Bool
    
    var body: some View {
        Button { showPreview.toggle() } label: {
            Label {
                Text ("Back")
            } icon: {
                Image (systemName : "chevron.left")
                    .foregroundColor(.white)
            }
        }
    }
}

struct BtnBackSmall: View {
    var action: () -> ()
    
    var body: some View {
        Button(action: { action() }) {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.orange)
                .frame(width: 23)
        }
    }
}

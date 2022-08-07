//
//  VideoGrid.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

struct VideoGridView : View {
    let gridCells = 3
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in 1...(gridCells-1) {
                    let vOffset: CGFloat = geometry.size.width / CGFloat(gridCells) * CGFloat(index)
                    path.move(to: CGPoint(x: vOffset, y: 0))
                    path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
                }
                for index in 1...(gridCells-1) {
                    let hOffset: CGFloat = geometry.size.height / CGFloat(gridCells) * CGFloat(index)
                    path.move(to: CGPoint(x: 0, y: hOffset))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
                }
            }
            .stroke()
        }
    }
}

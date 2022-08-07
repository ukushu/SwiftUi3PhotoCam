//
//  HelpButt.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

struct HelpButt<Content: View> : View  {
    @ViewBuilder var content: () -> Content
    
    public init( @ViewBuilder content: @escaping () -> Content ) {
        self.content = content
    }
    
    var body: some View {
        PopoverButt({ Image(systemName: "questionmark.circle.fill") }, content: { content().padding() } )
    }
}

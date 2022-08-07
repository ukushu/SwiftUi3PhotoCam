//
//  PopoverButt.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

public struct PopoverButt<Label: View, Content: View>: View {
    @ViewBuilder var content: () -> Content
    @ViewBuilder var label: () -> Label
    @State var showingPopover = false
    
    public init(@ViewBuilder _ label: @escaping () -> Label,
                @ViewBuilder content: @escaping () -> Content) {
        self.label = label
        self.content = content
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) where Label == EmptyView {
        self.label = { EmptyView() }
        self.content = content
    }
    
    public var body: some View {
        Button(action:{ self.showingPopover.toggle() }, label: label)
            .popover(isPresented: $showingPopover, content: self.content)
    }
}

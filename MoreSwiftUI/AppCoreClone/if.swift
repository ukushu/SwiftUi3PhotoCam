import SwiftUI

// IMPORTANT! Prefer to use standard if else system!

@available(OSX 11.0, *)
public extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

@available(OSX 11.0, *)
public extension View {
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>
              (_ condition: Bool,
               ifTrue trueContent: (Self) -> TrueContent,
               else  falseContent: (Self) -> FalseContent ) -> some View
    {
        if condition {
            trueContent(self)
        } else {
            falseContent(self)
        }
    }
}

///USAGE SAMPLES:
/*
 Text("some Text")
    .if(modifierEnabled) { $0.foregroundColor(.Red) }
 
 Text("some Text")
    .if(modifierEnabled) { $0.foregroundColor(.Red) }
    else:                { $0.background(Color.Blue) }
 */


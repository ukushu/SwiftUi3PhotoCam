import Foundation
import SwiftUI

struct BoundsSlider : View {
    let min: CGFloat
    let max: CGFloat
    
    @Binding var value: CGFloat
    @State var lastValue: CGFloat
    
    init (min: CGFloat, max: CGFloat, value: Binding<CGFloat>) {
        self.min = min
        self.max = max
        _value = value
        _lastValue = State(initialValue: value.wrappedValue)
    }
    
    var body: some View {
        Slider(value: Binding.init(get: { () -> CGFloat in return value },
                                   set: { (newValue) in if true { value = newValue; lastValue = newValue } }), in: min...max)
    }
}

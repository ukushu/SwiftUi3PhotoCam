import SwiftUI
import Combine

fileprivate var cancellables = [String : AnyCancellable] ()

public extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}

// usage:
// @Published(key: "isLogedIn") var isLogedIn = false

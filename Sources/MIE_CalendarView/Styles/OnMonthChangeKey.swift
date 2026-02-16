import SwiftUI

struct OnMonthChangeAction: Sendable {
    let action: @Sendable (Int, Int) -> Void

    func callAsFunction(month: Int, year: Int) {
        action(month, year)
    }
}

struct OnMonthChangeKey: EnvironmentKey {
    static let defaultValue: OnMonthChangeAction? = nil
}

extension EnvironmentValues {
    var onMonthChange: OnMonthChangeAction? {
        get { self[OnMonthChangeKey.self] }
        set { self[OnMonthChangeKey.self] = newValue }
    }
}

public extension View {
    /// Registers a callback that fires when the visible month changes.
    /// - Parameter action: A closure receiving the new `(month, year)`.
    func onMonthChange(_ action: @escaping @Sendable (Int, Int) -> Void) -> some View {
        environment(\.onMonthChange, OnMonthChangeAction(action: action))
    }
}

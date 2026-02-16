import SwiftUI

/// A type-erased wrapper so any ``DayViewStyle`` can be stored in the
/// SwiftUI environment.
struct AnyDayViewStyle: DayViewStyle, @unchecked Sendable {
    private let _makeBody: @Sendable (Configuration) -> AnyView

    init<S: DayViewStyle>(_ style: S) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}

struct DayViewStyleKey: EnvironmentKey {
    static let defaultValue = AnyDayViewStyle(DefaultDayViewStyle())
}

extension EnvironmentValues {
    var dayViewStyle: AnyDayViewStyle {
        get { self[DayViewStyleKey.self] }
        set { self[DayViewStyleKey.self] = newValue }
    }
}

public extension View {
    /// Sets the style for ``DayView`` cells within this view hierarchy.
    func dayViewStyle<S: DayViewStyle>(_ style: S) -> some View {
        environment(\.dayViewStyle, AnyDayViewStyle(style))
    }
}

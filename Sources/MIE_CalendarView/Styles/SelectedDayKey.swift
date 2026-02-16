import SwiftUI

struct SelectedDayKey: EnvironmentKey {
    static let defaultValue: Binding<DateComponents?> = .constant(nil)
}

extension EnvironmentValues {
    var selectedDay: Binding<DateComponents?> {
        get { self[SelectedDayKey.self] }
        set { self[SelectedDayKey.self] = newValue }
    }
}

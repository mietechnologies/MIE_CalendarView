import SwiftUI

struct SelectedDayKey: EnvironmentKey {
    static let defaultValue: Binding<DateComponents?> = .constant(nil)
}

struct DayEventCountsKey: EnvironmentKey {
    static let defaultValue: [DateComponents: Int] = [:]
}

extension EnvironmentValues {
    var selectedDay: Binding<DateComponents?> {
        get { self[SelectedDayKey.self] }
        set { self[SelectedDayKey.self] = newValue }
    }

    var dayEventCounts: [DateComponents: Int] {
        get { self[DayEventCountsKey.self] }
        set { self[DayEventCountsKey.self] = newValue }
    }
}

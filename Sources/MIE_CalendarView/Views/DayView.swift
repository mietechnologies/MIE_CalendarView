import SwiftUI

struct DayView: View {
    let day: Int
    let month: Int
    let year: Int

    @Environment(\.dayViewStyle) private var style

    private var isToday: Bool {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return components.year == year && components.month == month && components.day == day
    }

    var body: some View {
        let configuration = DayViewStyleConfiguration(
            label: DayViewStyleConfiguration.Label(content: AnyView(Text("\(day)"))),
            day: day,
            month: month,
            year: year,
            isToday: isToday
        )
        AnyView(style.makeBody(configuration: configuration))
    }
}

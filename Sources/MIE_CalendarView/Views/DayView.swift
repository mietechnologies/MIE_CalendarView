import SwiftUI

struct DayView: View {
    let day: Int
    let month: Int
    let year: Int

    @Environment(\.dayViewStyle) private var style
    @Environment(\.selectedDay) private var selectedDay

    private var dateComponents: DateComponents {
        DateComponents(year: year, month: month, day: day)
    }

    private var isToday: Bool {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return components.year == year && components.month == month && components.day == day
    }

    private var isSelected: Bool {
        if let selected = selectedDay.wrappedValue {
            return selected.year == year && selected.month == month && selected.day == day
        }
        return isToday
    }

    var body: some View {
        let configuration = DayViewStyleConfiguration(
            label: DayViewStyleConfiguration.Label(content: AnyView(Text("\(day)"))),
            day: day,
            month: month,
            year: year,
            isToday: isToday,
            isSelected: isSelected
        )
        AnyView(style.makeBody(configuration: configuration))
            .contentShape(Rectangle())
            .onTapGesture {
                if isSelected && selectedDay.wrappedValue != nil {
                    selectedDay.wrappedValue = nil
                } else {
                    selectedDay.wrappedValue = dateComponents
                }
            }
    }
}

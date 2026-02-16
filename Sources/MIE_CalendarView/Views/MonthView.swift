import SwiftUI

struct MonthView: View {
    let descriptor: MonthDescriptor

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekdaySymbols = Calendar.current.shortWeekdaySymbols

    private var title: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        var components = DateComponents()
        components.year = descriptor.year
        components.month = descriptor.month
        components.day = 1
        guard let date = Calendar.current.date(from: components) else { return "" }
        return formatter.string(from: date)
    }

    private var daysInMonth: Int {
        CalendarDataSource.daysInMonth(year: descriptor.year, month: descriptor.month)
    }

    private var firstWeekdayOffset: Int {
        CalendarDataSource.firstWeekdayOffset(year: descriptor.year, month: descriptor.month)
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title2.bold())

            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                ForEach(0..<firstWeekdayOffset, id: \.self) { _ in
                    Text("")
                }

                ForEach(1...daysInMonth, id: \.self) { day in
                    DayView(day: day, month: descriptor.month, year: descriptor.year)
                }

                let trailingSpaces = (7 - (firstWeekdayOffset + daysInMonth) % 7) % 7
                ForEach(0..<trailingSpaces, id: \.self) { _ in
                    Text("")
                }
            }
        }
        .padding()
    }
}

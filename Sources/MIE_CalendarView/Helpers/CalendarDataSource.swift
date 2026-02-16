import Foundation

struct MonthDescriptor: Identifiable, Hashable, Sendable {
    let year: Int
    let month: Int

    var id: Int { year * 12 + month }
}

enum CalendarDataSource {
    static func monthRange(around date: Date, yearsBefore: Int = 2, yearsAfter: Int = 2, calendar: Calendar = .current) -> [MonthDescriptor] {
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let centerYear = components.year, components.month != nil else { return [] }

        var months: [MonthDescriptor] = []
        let startYear = centerYear - yearsBefore
        let endYear = centerYear + yearsAfter

        for year in startYear...endYear {
            for month in 1...12 {
                months.append(MonthDescriptor(year: year, month: month))
            }
        }

        return months
    }

    static func daysInMonth(year: Int, month: Int, calendar: Calendar = .current) -> Int {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }
        return range.count
    }

    /// Returns the weekday index (0 = Sunday, 6 = Saturday) of the first day of the month.
    static func firstWeekdayOffset(year: Int, month: Int, calendar: Calendar = .current) -> Int {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        guard let date = calendar.date(from: components) else { return 0 }
        let weekday = calendar.component(.weekday, from: date)
        // Calendar.weekday is 1-based (1 = Sunday), convert to 0-based
        return weekday - 1
    }

    static func monthRange(around date: Date, totalMonths: Int, calendar: Calendar = .current) -> [MonthDescriptor] {
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let centerYear = components.year, let centerMonth = components.month else { return [] }

        let monthsBefore = (totalMonths - 1) / 2
        var months: [MonthDescriptor] = []

        for offset in -monthsBefore ..< (-monthsBefore + totalMonths) {
            var m = centerMonth + offset
            var y = centerYear
            while m < 1 { m += 12; y -= 1 }
            while m > 12 { m -= 12; y += 1 }
            months.append(MonthDescriptor(year: y, month: m))
        }

        return months
    }

    static func currentMonthDescriptor(calendar: Calendar = .current) -> MonthDescriptor {
        let now = Date()
        let components = calendar.dateComponents([.year, .month], from: now)
        return MonthDescriptor(year: components.year!, month: components.month!)
    }
}

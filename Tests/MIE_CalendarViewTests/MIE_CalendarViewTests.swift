import Foundation
import Testing
@testable import MIECalendarView

@Test func daysInMonthForFebruary2026() {
    let days = CalendarDataSource.daysInMonth(year: 2026, month: 2)
    #expect(days == 28)
}

@Test func daysInMonthForLeapYear() {
    let days = CalendarDataSource.daysInMonth(year: 2024, month: 2)
    #expect(days == 29)
}

@Test func daysInMonthForJanuary() {
    let days = CalendarDataSource.daysInMonth(year: 2026, month: 1)
    #expect(days == 31)
}

@Test func firstWeekdayOffsetKnownDate() {
    // February 1, 2026 is a Sunday → offset should be 0
    let offset = CalendarDataSource.firstWeekdayOffset(year: 2026, month: 2)
    #expect(offset == 0)
}

@Test func firstWeekdayOffsetMarch2026() {
    // March 1, 2026 is a Sunday → offset should be 0
    let offset = CalendarDataSource.firstWeekdayOffset(year: 2026, month: 3)
    #expect(offset == 0)
}

@Test func monthRangeCount() {
    let months = CalendarDataSource.monthRange(around: Date(), monthsBefore: 3, monthsAfter: 6)
    #expect(months.count == 10) // 3 before + current + 6 after
}

@Test func monthRangeContainsCurrentMonth() {
    let current = CalendarDataSource.currentMonthDescriptor()
    let months = CalendarDataSource.monthRange(around: Date(), monthsBefore: 0, monthsAfter: 11)
    #expect(months.contains(current))
    #expect(months.first == current)
}

@Test func monthRangeFirstAndLastDescriptors() {
    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.year, .month], from: now)
    let currentYear = components.year!
    let currentMonth = components.month!

    let months = CalendarDataSource.monthRange(around: now, monthsBefore: 2, monthsAfter: 3)

    // First month should be 2 months before current
    var expectedMonth = currentMonth - 2
    var expectedYear = currentYear
    while expectedMonth < 1 { expectedMonth += 12; expectedYear -= 1 }
    #expect(months.first == MonthDescriptor(year: expectedYear, month: expectedMonth))

    // Last month should be 3 months after current
    expectedMonth = currentMonth + 3
    expectedYear = currentYear
    while expectedMonth > 12 { expectedMonth -= 12; expectedYear += 1 }
    #expect(months.last == MonthDescriptor(year: expectedYear, month: expectedMonth))
}

@Test func monthDescriptorIdentity() {
    let a = MonthDescriptor(year: 2026, month: 2)
    let b = MonthDescriptor(year: 2026, month: 2)
    #expect(a == b)
    #expect(a.id == b.id)
}

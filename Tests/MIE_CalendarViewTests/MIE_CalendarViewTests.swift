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
    let months = CalendarDataSource.monthRange(around: Date(), yearsBefore: 2, yearsAfter: 2)
    #expect(months.count == 5 * 12) // 5 years × 12 months
}

@Test func monthRangeContainsCurrentMonth() {
    let current = CalendarDataSource.currentMonthDescriptor()
    let months = CalendarDataSource.monthRange(around: Date())
    #expect(months.contains(current))
}

@Test func monthDescriptorIdentity() {
    let a = MonthDescriptor(year: 2026, month: 2)
    let b = MonthDescriptor(year: 2026, month: 2)
    #expect(a == b)
    #expect(a.id == b.id)
}

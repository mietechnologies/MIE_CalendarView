import SwiftUI

/// A horizontally paging calendar view that defaults to the current month.
public struct CalendarView: View {
    private let months: [MonthDescriptor]
    private let currentMonth: MonthDescriptor
    private let eventCounts: [DateComponents: Int]
    @Binding private var selection: DateComponents?

    /// Creates a calendar view.
    /// - Parameters:
    ///   - monthCount: The total number of months to display, centered on the
    ///     current month. Defaults to `12`.
    ///   - selection: A binding to the currently selected day. Pass `nil` to
    ///     let today appear selected by default.
    ///   - events: An array of events conforming to ``DayEventType``. The
    ///     calendar displays indicators on days that have events.
    public init(
        monthCount: Int = 12,
        selection: Binding<DateComponents?> = .constant(nil),
        events: [any DayEventType] = []
    ) {
        let current = CalendarDataSource.currentMonthDescriptor()
        self.currentMonth = current
        self.months = CalendarDataSource.monthRange(around: Date(), totalMonths: monthCount)
        self._selection = selection

        var counts: [DateComponents: Int] = [:]
        for event in events {
            let key = DateComponents(year: event.date.year, month: event.date.month, day: event.date.day)
            counts[key, default: 0] += 1
        }
        self.eventCounts = counts
    }

    public var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(months) { month in
                    MonthView(descriptor: month)
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .defaultScrollAnchor(.center)
        .scrollPosition(id: .constant(currentMonth.id), anchor: .center)
        .environment(\.selectedDay, $selection)
        .environment(\.dayEventCounts, eventCounts)
    }
}

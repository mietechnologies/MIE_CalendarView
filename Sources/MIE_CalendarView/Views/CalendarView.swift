import SwiftUI

/// A horizontally paging calendar view that defaults to the current month.
public struct CalendarView: View {
    private let months: [MonthDescriptor]
    private let currentMonth: MonthDescriptor

    public init() {
        let current = CalendarDataSource.currentMonthDescriptor()
        self.currentMonth = current
        self.months = CalendarDataSource.monthRange(around: Date())
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
    }

    /// Convenience modifier to set the ``DayViewStyle`` for this calendar.
    public func dayStyle<S: DayViewStyle>(_ style: S) -> some View {
        self.dayViewStyle(style)
    }
}

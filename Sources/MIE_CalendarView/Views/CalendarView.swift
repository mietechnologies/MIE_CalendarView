import SwiftUI

/// A horizontally paging calendar view that defaults to the current month.
public struct CalendarView: View {
    private let months: [MonthDescriptor]
    private let currentMonth: MonthDescriptor
    @Binding private var selection: DateComponents?

    /// Creates a calendar view.
    /// - Parameters:
    ///   - monthCount: The total number of months to display, centered on the
    ///     current month. Defaults to `12`.
    ///   - selection: A binding to the currently selected day. Pass `nil` to
    ///     let today appear selected by default.
    public init(monthCount: Int = 12, selection: Binding<DateComponents?> = .constant(nil)) {
        let current = CalendarDataSource.currentMonthDescriptor()
        self.currentMonth = current
        self.months = CalendarDataSource.monthRange(around: Date(), totalMonths: monthCount)
        self._selection = selection
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
    }

    /// Convenience modifier to set the ``DayViewStyle`` for this calendar.
    public func dayStyle<S: DayViewStyle>(_ style: S) -> some View {
        self.dayViewStyle(style)
    }
}

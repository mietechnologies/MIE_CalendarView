import SwiftUI

/// A horizontally paging calendar view that defaults to the current month.
public struct CalendarView: View {
    private let months: [MonthDescriptor]
    private let currentMonth: MonthDescriptor
    @Binding private var selection: DateComponents?

    /// Creates a calendar view with an external selection binding.
    public init(selection: Binding<DateComponents?>) {
        let current = CalendarDataSource.currentMonthDescriptor()
        self.currentMonth = current
        self.months = CalendarDataSource.monthRange(around: Date())
        self._selection = selection
    }

    /// Creates a calendar view with internal selection state.
    /// Today appears selected by default when no day has been tapped.
    public init() {
        self.init(selection: .constant(nil))
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

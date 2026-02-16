import SwiftUI

/// The data a ``DayViewStyle`` receives to render a day cell.
public struct DayViewStyleConfiguration {
    /// A type-erased label view (defaults to `Text("\(day)"`).
    public struct Label: View {
        let content: AnyView

        public var body: some View { content }
    }

    /// The default label showing the day number.
    public let label: Label

    /// The day of the month (1-based).
    public let day: Int

    /// The month (1–12).
    public let month: Int

    /// The four-digit year.
    public let year: Int

    /// Whether this day is today's date.
    public let isToday: Bool

    /// Whether this day is the currently selected day.
    public let isSelected: Bool

    /// The number of events on this day.
    public let eventCount: Int
}

/// A protocol that defines the appearance of day cells in a ``CalendarView``.
///
/// Conform to this protocol and implement ``makeBody(configuration:)`` to
/// provide a custom look for every day cell. Apply your style with the
/// ``SwiftUICore/View/dayViewStyle(_:)`` modifier.
public protocol DayViewStyle: Sendable {
    /// The view type returned by ``makeBody(configuration:)``.
    associatedtype Body: View

    /// A convenience alias for the configuration type.
    typealias Configuration = DayViewStyleConfiguration

    /// Creates the styled view for a single day cell.
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

/// The default day-view style that matches the built-in appearance
/// (accent-colored circle behind today, bold text for today).
public struct DefaultDayViewStyle: DayViewStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        let isSelected = configuration.isSelected
        let isToday = configuration.isToday

        VStack(spacing: 1) {
            configuration.label
                .font(isSelected || isToday ? .body.bold() : .body)
                .foregroundStyle(
                    isSelected ? Color.white :
                    isToday ? Color.accentColor : .primary
                )
                .frame(maxWidth: .infinity, minHeight: 32)
                .background {
                    if isSelected {
                        Circle()
                            .fill(Color.accentColor)
                    } else if isToday {
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 1.5)
                    }
                }

            if configuration.eventCount > 0 {
                HStack(spacing: 2) {
                    let dotCount = min(configuration.eventCount, 3)
                    ForEach(0..<dotCount, id: \.self) { _ in
                        Circle()
                            .fill(isSelected ? Color.accentColor : Color.secondary)
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
    }
}

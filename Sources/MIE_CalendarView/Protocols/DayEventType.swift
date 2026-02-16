import Foundation

/// A protocol that represents an event associated with a specific day.
///
/// Conform to this protocol to provide event data to a ``CalendarView``.
/// The calendar uses these events to display indicators on days that have
/// scheduled events.
public protocol DayEventType {
    /// The date components (year, month, day) identifying which day this event belongs to.
    var date: DateComponents { get }
}

# MIECalendarView

A lightweight, horizontally paging calendar view for SwiftUI. No external dependencies.

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.2+

## Installation

Add the package to your project via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/mietechnologies/MIE_CalendarView.git", from: "1.0.0")
]
```

Then import in your Swift files:

```swift
import MIECalendarView
```

## Usage

### Basic Calendar

```swift
CalendarView()
```

This displays a calendar starting at the current month with 11 months ahead (12 total). Today is highlighted by default.

### Day Selection

Pass a binding to track the selected day:

```swift
@State private var selectedDate: DateComponents?

CalendarView(selection: $selectedDate)
```

### Month Range

Control how many months before and after the current month are available:

```swift
// 3 months back, 6 months forward (10 months total including current)
CalendarView(monthsBefore: 3, monthsAfter: 6, selection: $selectedDate)

// Current month only
CalendarView(monthsBefore: 0, monthsAfter: 0)
```

### Events

Conform your model to `DayEventType` and pass events to display dot indicators on days:

```swift
struct MyEvent: DayEventType {
    let date: DateComponents
}

let events: [MyEvent] = [
    MyEvent(date: DateComponents(year: 2026, month: 2, day: 15))
]

CalendarView(selection: $selectedDate, events: events)
```

For dynamic event loading, pass a binding instead:

```swift
@State private var events: [any DayEventType] = []

CalendarView(selection: $selectedDate, events: $events)
    .onMonthChange { month, year in
        events = fetchEvents(for: month, year: year)
    }
```

### Month Change Callback

React when the user swipes to a different month:

```swift
CalendarView()
    .onMonthChange { month, year in
        print("Now viewing \(month)/\(year)")
    }
```

### Custom Day Styling

Create a custom style by conforming to `DayViewStyle`:

```swift
struct BorderedDayViewStyle: DayViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 2) {
            configuration.label
                .font(configuration.isToday ? .body.bold() : .body)
                .foregroundStyle(configuration.isSelected ? .white : .primary)

            if configuration.eventCount > 0 {
                HStack(spacing: 2) {
                    ForEach(0..<min(configuration.eventCount, 3), id: \.self) { _ in
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .background {
            if configuration.isSelected {
                RoundedRectangle(cornerRadius: 6).fill(Color.accentColor)
            }
        }
    }
}
```

Apply it with the `.dayViewStyle()` modifier:

```swift
CalendarView(selection: $selectedDate, events: events)
    .dayViewStyle(BorderedDayViewStyle())
```

#### Style Configuration Properties

`DayViewStyleConfiguration` provides the following properties:

| Property | Type | Description |
|---|---|---|
| `label` | `Label` | The default day number view |
| `day` | `Int` | Day of the month (1-based) |
| `month` | `Int` | Month (1-12) |
| `year` | `Int` | Four-digit year |
| `isToday` | `Bool` | Whether this day is today |
| `isSelected` | `Bool` | Whether this day is selected |
| `eventCount` | `Int` | Number of events on this day |

## API Reference

### CalendarView

```swift
// Static events
CalendarView(
    monthsBefore: Int = 0,
    monthsAfter: Int = 11,
    selection: Binding<DateComponents?> = .constant(nil),
    events: [any DayEventType] = []
)

// Binding events
CalendarView(
    monthsBefore: Int = 0,
    monthsAfter: Int = 11,
    selection: Binding<DateComponents?> = .constant(nil),
    events: Binding<[any DayEventType]>
)
```

### View Modifiers

| Modifier | Description |
|---|---|
| `.dayViewStyle(_:)` | Sets a custom `DayViewStyle` for day cells |
| `.onMonthChange(_:)` | Registers a `(Int, Int) -> Void` callback for month changes |

### Protocols

| Protocol | Requirement |
|---|---|
| `DayEventType` | `var date: DateComponents { get }` |
| `DayViewStyle` | `func makeBody(configuration: Configuration) -> some View` |

## License

MIT

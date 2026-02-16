# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Consistent month grid height — all months now render a full 6-row grid, preventing layout jumps when swiping between months with different week counts

## [1.0.0] - 2026.02.15

### Added
- `CalendarView` — horizontally paging calendar centered on the current month
- Configurable `monthCount` parameter to control how many months are available (default `12`)
- Day selection via `Binding<DateComponents?>` with today highlighted by default
- `DayViewStyle` protocol and environment-based styling system for customizing day cells
- `DayViewStyleConfiguration` providing `label`, `day`, `month`, `year`, `isToday`, `isSelected`, and `eventCount`
- `DefaultDayViewStyle` with accent-colored circle for selected/today states
- `.dayViewStyle(_:)` view modifier for applying custom day styles
- `DayEventType` protocol for providing event data to the calendar
- `events` parameter accepting `[any DayEventType]` or `Binding<[any DayEventType]>` for static and dynamic event data
- Default dot indicators (up to 3) below day numbers when events are present
- `.onMonthChange(_:)` view modifier that fires a `(month, year)` callback when the visible month changes
- Self-sizing layout — `CalendarView` constrains to its intrinsic content height
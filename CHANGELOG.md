# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- `events` parameter on `CalendarView` now supports `Binding<[any DayEventType]>` for dynamic event updates
- Existing value-based `events` initializer is preserved for backwards compatibility

### Added
- `DayEventType` protocol for providing event data to the calendar
- `eventCount` property on `DayViewStyleConfiguration` for custom styles to render event indicators
- `events` parameter on `CalendarView` initializer (default `[]`)
- Default dot indicators (up to 3) below day numbers when events are present
- `onMonthChange(_:)` view modifier that fires a callback with `(month, year)` when the visible month changes
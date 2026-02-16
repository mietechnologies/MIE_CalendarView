//
//  ContentView.swift
//  MIE CalendarView Example
//
//  Created by Brett Chapin on 2026.02.15.
//

import SwiftUI
import MIECalendarView

// MARK: - Sample Event

struct SampleEvent: DayEventType {
    let date: DateComponents
}

extension SampleEvent {
    /// Creates sample events for a given month and year.
    static func sampleEvents(month: Int, year: Int) -> [SampleEvent] {
        return [
            SampleEvent(date: DateComponents(year: year, month: month, day: 3)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 3)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 7)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 15)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 15)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 15)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 22)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 22)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 22)),
            SampleEvent(date: DateComponents(year: year, month: month, day: 22)),
        ]
    }

    /// Creates sample events for the current month.
    static func sampleEvents() -> [SampleEvent] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month], from: today)
        return sampleEvents(month: components.month!, year: components.year!)
    }
}

// MARK: - Custom Styles

struct BorderedDayViewStyle: DayViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 2) {
            configuration.label
                .font(configuration.isSelected || configuration.isToday ? .body.bold() : .body)
                .foregroundStyle(configuration.isSelected ? Color.white : .primary)

            if configuration.eventCount > 0 {
                HStack(spacing: 2) {
                    let dotCount = min(configuration.eventCount, 3)
                    ForEach(0..<dotCount, id: \.self) { _ in
                        Circle()
                            .fill(configuration.isSelected ? Color.white : Color.orange)
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .aspectRatio(1, contentMode: .fit)
        .background {
            if configuration.isSelected {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.accentColor)
            } else if configuration.isToday {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.accentColor.opacity(0.2))
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
        }
    }
}

struct MinimalDayViewStyle: DayViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 2) {
            configuration.label
                .font(configuration.isSelected ? .body.bold() : .body)
                .foregroundStyle(configuration.isSelected ? Color.accentColor : .primary)

            if configuration.isSelected {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 16, height: 2)
            } else if configuration.isToday {
                Rectangle()
                    .fill(Color.accentColor.opacity(0.4))
                    .frame(width: 16, height: 2)
            }

            if configuration.eventCount > 0 {
                HStack(spacing: 2) {
                    let dotCount = min(configuration.eventCount, 3)
                    ForEach(0..<dotCount, id: \.self) { _ in
                        Circle()
                            .fill(Color.accentColor.opacity(0.6))
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 32)
    }
}

// MARK: - Style Picker

enum StyleOption: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case bordered = "Bordered"
    case minimal = "Minimal"

    var id: String { rawValue }
}

// MARK: - ContentView

struct ContentView: View {
    @State private var selectedStyle: StyleOption = .default
    @State private var selectedDate: DateComponents?
    @State private var visibleMonth: String = ""

    var body: some View {
        VStack {
            Picker("Style", selection: $selectedStyle) {
                ForEach(StyleOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Spacer()

            styledCalendar()
                .onMonthChange { month, year in
                    visibleMonth = "\(month)/\(year)"
                    sampleEvents = SampleEvent.sampleEvents(month: month, year: year)
                }
            
            Spacer()

            if !visibleMonth.isEmpty {
                Text("Viewing: \(visibleMonth)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            if let selected = selectedDate {
                Text("Selected: \(selected.month!)/\(selected.day!)/\(selected.year!)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            } else {
                Text("No selection (today is highlighted)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @State private var sampleEvents: [any DayEventType] = SampleEvent.sampleEvents()

    @ViewBuilder
    private func styledCalendar() -> some View {
        switch selectedStyle {
        case .default:
            CalendarView(monthCount: 1, selection: $selectedDate, events: $sampleEvents)
                .dayViewStyle(DefaultDayViewStyle())
        case .bordered:
            CalendarView(selection: $selectedDate, events: $sampleEvents)
                .dayViewStyle(BorderedDayViewStyle())
        case .minimal:
            CalendarView(selection: $selectedDate, events: $sampleEvents)
                .dayViewStyle(MinimalDayViewStyle())
        }
    }
}

#Preview {
    ContentView()
}

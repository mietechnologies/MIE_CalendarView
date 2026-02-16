//
//  ContentView.swift
//  MIE CalendarView Example
//
//  Created by Brett Chapin on 2026.02.15.
//

import SwiftUI
import MIECalendarView

// MARK: - Custom Styles

struct BorderedDayViewStyle: DayViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(configuration.isSelected || configuration.isToday ? .body.bold() : .body)
            .foregroundStyle(configuration.isSelected ? Color.white : .primary)
            .frame(maxWidth: .infinity, minHeight: 32)
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

    var body: some View {
        VStack {
            Picker("Style", selection: $selectedStyle) {
                ForEach(StyleOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            styledCalendar()

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

    @ViewBuilder
    private func styledCalendar() -> some View {
        switch selectedStyle {
        case .default:
            CalendarView(selection: $selectedDate)
                .dayViewStyle(DefaultDayViewStyle())
        case .bordered:
            CalendarView(selection: $selectedDate)
                .dayViewStyle(BorderedDayViewStyle())
        case .minimal:
            CalendarView(selection: $selectedDate)
                .dayViewStyle(MinimalDayViewStyle())
        }
    }
}

#Preview {
    ContentView()
}

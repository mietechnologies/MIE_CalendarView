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
            .font(configuration.isToday ? .body.bold() : .body)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, minHeight: 32)
            .background {
                if configuration.isToday {
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
                .font(.body)
                .foregroundStyle(.primary)

            if configuration.isToday {
                Rectangle()
                    .fill(Color.accentColor)
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
        }
    }

    @ViewBuilder
    private func styledCalendar() -> some View {
        switch selectedStyle {
        case .default:
            CalendarView()
                .dayViewStyle(DefaultDayViewStyle())
        case .bordered:
            CalendarView()
                .dayViewStyle(BorderedDayViewStyle())
        case .minimal:
            CalendarView()
                .dayViewStyle(MinimalDayViewStyle())
        }
    }
}

#Preview {
    ContentView()
}

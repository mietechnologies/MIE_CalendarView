# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MIE_CalendarView is a Swift Package Manager library providing a calendar view component. The project is owned by mietechnologies and uses Swift 6.2+ with no external dependencies.

## Build Commands

```bash
# Build the package
swift build

# Run all tests
swift test

# Run a single test by name
swift test --filter MIE_CalendarViewTests.testFunctionName
```

## Architecture

- **Package type:** Single-product SPM library (`MIE_CalendarView`)
- **Source:** `Sources/MIE_CalendarView/`
- **Tests:** `Tests/MIE_CalendarViewTests/` — uses the Swift Testing framework (`@Test`, `#expect`), not XCTest
- **No external dependencies**

## Conventions

- Swift 6.2+ strict concurrency (the package uses `swift-tools-version: 6.2`)
- Changelog follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format with [Semantic Versioning](https://semver.org/spec/v2.0.0.html) — update `CHANGELOG.md` when making notable changes

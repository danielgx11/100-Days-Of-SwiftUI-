//
//  ContentView.swift
//  ChallengeI-UnitConversions
//
//  Created by Daniel Gomes on 18/05/21.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties
    @State private var value: String = ""
    @State private var typeOfValue: Int = 0
    @State private var convertToType: Int = 0
    private let convertionsTypes: [String] = ["Seconds", "Hours", "Days", "Years"]
    private let secondsInAnHour: Double = 3600
    private let secondsInADay: Double = 3600 * 24
    private let secondsInAYear: Double = (3600 * 24) * 365
    private let daysOnAnYear: Double = 365
    private let hoursInADay: Double = 24
    private let hoursInAnYear: Double = 8760
    private var result: Double {
        let type = convertionsTypes[convertToType]
        switch type {
        case "Hours":
            return handleHours()
        case "Days":
            return handleDays()
        case "Years":
            return handleYears()
        default:
            return handleSeconds()
        }
        
    }

    // MARK: - Life Cycle
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Value to convert")) {
                    TextField("Value", text: $value)
                }
                
                Section(header: Text("Value unit is...")) {
                    Picker("Type", selection: $typeOfValue) {
                        ForEach( 0 ..< convertionsTypes.count) {
                            Text("\(self.convertionsTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to...")) {
                    Picker("Type", selection: $convertToType) {
                        ForEach( 0 ..< convertionsTypes.count) {
                            Text("\(self.convertionsTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(result, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Time Convertions")
        }
    }
}

// MARK: - Methods
extension ContentView {

    private func handleSeconds() -> Double {
        let typeValue = convertionsTypes[typeOfValue]
        switch typeValue {
        case "Hours":
            return (value.toDouble ?? 0.0) * secondsInAnHour
        case "Days":
            return (value.toDouble ?? 0.0) * secondsInADay
        case "Years":
            return (value.toDouble ?? 0.0) * secondsInAYear
        default:
            return value.toDouble ?? 0.0
        }
    }

    private func handleHours() -> Double {
        let typeValue = convertionsTypes[typeOfValue]
        switch typeValue {
        case "Seconds":
            return (value.toDouble ?? 0.0) / secondsInAnHour
        case "Days":
            return (value.toDouble ?? 0.0) * hoursInADay
        case "Years":
            return (value.toDouble ?? 0.0) / hoursInAnYear
        default:
            return value.toDouble ?? 0.0
        }
    }

    private func handleDays() -> Double {
        let typeValue = convertionsTypes[typeOfValue]
        switch typeValue {
        case "Seconds":
            return (value.toDouble ?? 0.0) / secondsInADay
        case "Hours":
            return (value.toDouble ?? 0.0) / hoursInADay
        case "Years":
            return (value.toDouble ?? 0.0) / daysOnAnYear
        default:
            return value.toDouble ?? 0.0
        }
    }

    private func handleYears() -> Double {
        let typeValue = convertionsTypes[typeOfValue]
        switch typeValue {
        case "Seconds":
            return (value.toDouble ?? 0.0) / secondsInAYear
        case "Hours":
            return (value.toDouble ?? 0.0) / (hoursInADay * 365)
        case "Days":
            return (value.toDouble ?? 0.0) / daysOnAnYear
        default:
            return value.toDouble ?? 0.0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

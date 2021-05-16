//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Gomes on 16/05/21.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage =  2
    private let tipPercentages = [10, 15, 20, 25, 0]
    private var total: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection

        return orderAmount + tipValue
    }
    private var totalPerPerson: Double {
        let peopleCount = Double(Double(numberOfPeople) ?? 1 + 2)
        let amountPerPerson = total / peopleCount

        return amountPerPerson
    }

    // MARK: - Life Cycle
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach( 0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount for the check")) {
                    Text("\(total, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by Bruce Gilmour on 2021-06-23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = peopleCount != 0 ? totalAmount / peopleCount : 0

        return amountPerPerson
    }

    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = tipSelection / 100 * orderAmount
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Check amount")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Number of people")) {
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .primary)
                        .fontWeight(tipPercentages[tipPercentage] == 0 ? .bold : .regular)
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
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

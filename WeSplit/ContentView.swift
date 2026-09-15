//
//  ContentView.swift
//  WeSplit
//
//  Created by Shiva G on 11/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numOfPeople = 0
    @State private var tipPercentage = 5
    
    @FocusState private var amountFocus: Bool
    
    var totalAmount: Double {
        let tipAmount = amount / 100 * Double(tipPercentage)
        
        return amount + tipAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numOfPeople + 2)
                
        let perPersonAmount = totalAmount / peopleCount
        
        return perPersonAmount
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocus)
                }
                
                Section {
                    Picker("Pick number of people", selection: $numOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Enter Tip percentage", selection: $tipPercentage) {
                        ForEach (0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount including tip") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if (amountFocus) {
                    Button ("Done") {
                        amountFocus.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

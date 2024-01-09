//
//  ContentView.swift
//  UnitConverter
//
//  Created by Khoa D. Vo on 1/9/24.
//

import SwiftUI

struct ContentView: View {
    let typeOfUnits = [
        "Temperature": ["Celsius", "Fahrenheit", "Kelvin"],
        "Length": ["Meters", "Kilometers", "Feet", "Miles"],
        "Time": ["Seconds", "Minutes", "Hours", "Days"],
        "Volume": ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    ]
    
    @State private var selectedUnit = "Temperature"
    @State private var selectedInput = ""
    @State private var selectedOutput = ""
    @State private var inputAmount = 0.0
    @State private var outputAmount = 0.0
    
    private var result: Double {
        switch selectedUnit {
        case "Temperature":
            print("")
            return convertTemperature().value
        case "Length":
            print("")
            return 0.0
        case "Time":
            print("")
            return 0.0
        case "Volumn":
            print("")
            return 0.0
        default:
            return 0.0
        }
    }
    
    func convertTemperature() -> Measurement<UnitTemperature> {
        var input: Measurement<UnitTemperature>
        var output: Measurement<UnitTemperature>
        
        if selectedInput == "Celsius" { input = Measurement(value: inputAmount, unit: UnitTemperature.celsius) }
        else if selectedInput == "Fahrenheit" { input = Measurement(value: inputAmount, unit: UnitTemperature.fahrenheit) }
        else { input = Measurement(value: inputAmount, unit: UnitTemperature.kelvin) }
        
        if selectedOutput == "Celsius" { output = input.converted(to: UnitTemperature.celsius) }
        else if selectedOutput == "Fahrenheit" { output = input.converted(to: UnitTemperature.fahrenheit) }
        else { output = input.converted(to: UnitTemperature.kelvin) }
        
        return output
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Convert", selection: $selectedUnit) {
                        ForEach(typeOfUnits.keys.sorted(by: >), id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Input") {
                    TextField("Input", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("From") {
                    Picker("From", selection: $selectedInput) {
                        ForEach(typeOfUnits[selectedUnit]!, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("To") {
                    
                    Picker("To", selection: $selectedOutput) {
                        ForEach(typeOfUnits[selectedUnit]!, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Text((selectedInput.isEmpty || selectedOutput.isEmpty) ? "Please select input and output units" : String(result.formatted()))
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

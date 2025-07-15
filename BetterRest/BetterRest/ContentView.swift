//
//  ContentView.swift
//  BetterRest
//
//  Created by Pranav on 10/07/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var hoursSleep:Double = 8
    @State private var coffeeIntake:Int = 1
    @State private var wakeUpTime = Date.now
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    @State private var wakeUp = ContentView.defaultWakeTime

    
    var body: some View {
        NavigationStack{
            Form {
                
                VStack(alignment: .leading, spacing: 0){
                    Text("When do wanna wake up")
                    
                    DatePicker(
                        "Wake up Time",
                        selection: $wakeUpTime,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired hours of sleep")
                    Stepper(
                        "Hours \(hoursSleep.formatted())",
                        value: $hoursSleep,
                        in: 4...12,
                        step: 0.25
                        
                    )
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffee intake")
                    Stepper("^[\(coffeeIntake) cup](inflect: true)",
                            value: $coffeeIntake,
                            in: 1...20)

                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            }message: {
                Text(alertMessage)
            }
            .padding()
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate",action: calcBedTime)
            }
        }
      
    }
    
    func calcBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents(
                [.hour,.minute],
                from: wakeUpTime
            )
            
            let hours = (components.hour ?? 0) * 60 * 60
            let mins = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hours+mins),
                estimatedSleep: hoursSleep,
                coffee: Double(coffeeIntake)
            )
            
            let sleepTime = wakeUpTime - prediction.actualSleep

            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
       
    }
   
}

#Preview {
    ContentView()
}

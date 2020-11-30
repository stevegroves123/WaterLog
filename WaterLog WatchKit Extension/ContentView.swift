//
//  ContentView.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 06/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI
import HealthKit
//import UIKit

struct ContentView: View {
    @State var waterValue = 0
    @State var waterTotal = 0
    @State var values = [0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000]
    
    struct customButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: 120, height: 65, alignment: .center)
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(15.0)
                .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
        }
    }
    
    var body: some View {
        VStack{
            Button(action:
                {
                    if self.waterValue > 0
                        {
                        self.writeWater()
                        }
                    self.readWater()
            }) {
                    HStack {
                        chooseWaterValue(waterValue: $waterValue, values: $values)
                            .padding(.all)
                    }
            }.buttonStyle(customButtonStyle())
            
            VStack {
                Text("Today's Water")
                HStack {
                   Text("\(self.waterTotal)")
                    .foregroundColor(.blue)
                    .font(.title)
                Text("ml")
                    .font(.body)
                }
            }
        }.onAppear(perform: { self.checkHK() })
    }
    
    // check for access to HealthKit then read any existing water value
    func checkHK() {
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            let healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .dietaryWater)!])
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success { print("It went wrong") }
            }
            self.readWater()
        }
    }
    
    // query to read all water values for today (23:00hrs) to make waterTotal the sum
    func readWater() {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
            print("Unable to read the water")
            return
        }
        
        let calender = NSCalendar.current
        let components = calender.dateComponents([.year, .month, .day], from: Date())
        
        guard let startDate = calender.date(from: components) else {
            fatalError("*** Unable to create a start date ***")
        }
        
        guard let endDate = calender.date(byAdding: .day, value: 1, to: startDate) else {
            fatalError("--- Unable to create an end date ---")
        }
        
        let todaysWater = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options:[])
        let waterQuery = HKSampleQuery(sampleType: waterType,
                                       predicate: todaysWater,
                                       limit: Int(HKObjectQueryNoLimit),
                                       sortDescriptors: nil) { (query, results, error) in

                guard error == nil,
                    let quantityWaterSamples = results as? [HKQuantitySample] else {
                        print("Something went wrong: \(String(describing: error))")
                        return
                        }
                                        self.waterTotal = Int(quantityWaterSamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.literUnit(with: .milli)) })
                                        DispatchQueue.main.async {
                                        }
            }
        HKHealthStore().execute(waterQuery)
    }
    
    // function to write the chosen waterValue
    func writeWater() {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
            print("Sample type not available")
            return
        }
        
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: Double(values[waterValue]))
        let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: Date(), end: Date())

        HKHealthStore().save(waterQuantitySample) { (success, error) in
            print("HK write finished - success: \(success); error: \(String(describing: error))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

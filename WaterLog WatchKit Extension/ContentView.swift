//
//  ContentView.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 06/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State var waterValue = 1.0
    @State var waterDrankToday = 0
    @State var waterTotal = 0
    
    var body: some View {
        VStack{
//            readWater()
            Text("Water to add")
            chooseWaterValue(waterValue: self.$waterValue)
            Button(action:
                {
                    self.writeWater()
                    self.readWater()
                    
                }){
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color.black)
                            .font(.headline)
                        Text("water")
                            .foregroundColor(Color.black)
                    }
            }
                .background(Color.gray)
                .cornerRadius(15)
                .padding()
            Spacer()
            Text("Total Water")
            Text("\(self.waterTotal)")
                .foregroundColor(.blue)
                .font(.title)
            Spacer()
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
    
    // query to read all water vales for the past 24 hrs and make waterTotal the sum
    func readWater() {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
            print("Unable to read the water")
            return
        }
        
        let todaysWater = HKQuery.predicateForSamples(withStart: (Date()-86400), end: Date(), options: .strictEndDate)
        let waterQuery = HKSampleQuery(sampleType: waterType,predicate: todaysWater, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
                (query, sample, error) in
            
                guard error == nil,
                    let quantityWaterSamples = sample as? [HKQuantitySample] else {
                      print("Something went wrong: \(String(describing: error))")
                        return
            }
            self.waterTotal = Int(quantityWaterSamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.literUnit(with: .milli)) })
            print("read water - ok")
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
        
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: Double(Int(waterValue)*100))
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

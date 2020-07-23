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
    
    var body: some View {
        VStack{
            Text("Water to add")
            chooseWaterValue(waterValue: self.$waterValue)
            Button(action:
                {
                    self.waterDrankToday = self.waterDrankToday + Int(self.waterValue);
                    self.writeWater()
                }){
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("water")
                    }
            }
                .background(Color.gray)
                .cornerRadius(15)
                .padding()
            Spacer()
            Text("Total Water")
            Text("\(self.waterDrankToday*100)")
                .foregroundColor(.blue)
                .font(.title)
// added to reset the values - could be used for new day/new week
                .onTapGesture(count: 2, perform: {
                    self.waterDrankToday = 0
                    self.waterValue = 1.0
                })
            Spacer()
        }.onAppear(perform: { self.checkHK() })
    }
    
    func checkHK() {
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            let healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .dietaryWater)!])
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success { print("It went wrong") }
            }
        }
    }
    
    func writeWater() {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
            print("Sample type not available")
            return
        }
        
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: Double(Int(waterValue)*100))
        let today = Date()
        let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: today, end: today)
        
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

//
//  ContentView.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 06/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var waterValue = 1.0
    @State var waterDrankToday = 0
    
    var body: some View {
        VStack{
            Text("Water to add")
            chooseWaterValue(waterValue: self.$waterValue)
            Button(action:
                {
                    self.waterDrankToday = self.waterDrankToday + Int(self.waterValue)
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
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

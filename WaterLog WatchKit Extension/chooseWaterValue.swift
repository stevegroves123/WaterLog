//
//  chooseWaterValue.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 07/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI

struct chooseWaterValue: View {
    @Binding var waterValue: Int
    @Binding var values: Array<Int>
    
            var body: some View {
                VStack {
                    Picker(selection: $waterValue, label: Text("Water")) {
                        ForEach(0 ..< values.count) { index in
                            Text("\(self.values[index])")
                                .font(.title)
                                .foregroundColor(Color.blue)
                        }
                    }
                }.frame(width: 100, height: 50)
        }
}

struct chooseWaterValue_Previews: PreviewProvider {
    static var previews: some View {
        chooseWaterValue(waterValue: .constant(0), values: .constant([0]))
    }
}


//
//  chooseWaterValue.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 07/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI

struct chooseWaterValue: View {
    @Binding var waterValue: Double
    
    var body: some View {
        VStack {
            Text("\(Int(waterValue)*100)")
            }
            .focusable(true)
            .digitalCrownRotation($waterValue, from: 1, through: 10, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
    }
}

struct chooseWaterValue_Previews: PreviewProvider {
    static var previews: some View {
        chooseWaterValue(waterValue: .constant(1.0))
    }
}

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
            Text("\(Int(waterValue)*10)")
                .font(.headline)
            }
            .focusable(true)
            .digitalCrownRotation($waterValue, from: 0, through: 100, by: 5, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
    }
}

struct chooseWaterValue_Previews: PreviewProvider {
    static var previews: some View {
        chooseWaterValue(waterValue: .constant(5.0))
    }
}

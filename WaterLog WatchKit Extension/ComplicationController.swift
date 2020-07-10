//
//  ComplicationController.swift
//  WaterLog WatchKit Extension
//
//  Created by steve groves on 07/07/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import Foundation
import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {

func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([])
}

func getCurrentTimelineEntry(
    for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void)
{
    let entry: CLKComplicationTimelineEntry
 
    switch complication.family {
    case .modularSmall:
//        let template = CLKComplicationTemplateModularSmallStackText()
//        template.line1TextProvider = CLKSimpleTextProvider(text: "+W")
//        template.line2TextProvider = CLKSimpleTextProvider(text: "TW")
        let template = CLKComplicationTemplateModularSmallSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
        entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
 
    case .circularSmall:
//        let template = CLKComplicationTemplateCircularSmallStackText()
//        template.line1TextProvider = CLKSimpleTextProvider(text: "+W")
//        template.line2TextProvider = CLKSimpleTextProvider(text: "TW")
        let template = CLKComplicationTemplateCircularSmallSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
        entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
 
    default:
        preconditionFailure("Complication family not supported")
    }
 
    handler(entry)
}

    func getLocalizableSampleTemplate(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationTemplate?) -> Void)
    {
        switch complication.family {
        case .modularSmall:
//            let template = CLKComplicationTemplateModularSmallStackText()
//            template.line1TextProvider = CLKSimpleTextProvider(text: "+W")
//            template.line2TextProvider = CLKSimpleTextProvider(text: "TW")
              let template = CLKComplicationTemplateModularSmallSimpleImage()
              template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
            handler(template)
     
        case .circularSmall:
//            let template = CLKComplicationTemplateCircularSmallStackText()
//            template.line1TextProvider = CLKSimpleTextProvider(text: "+W")
//            template.line2TextProvider = CLKSimpleTextProvider(text: "TW")
            let template = CLKComplicationTemplateCircularSmallSimpleImage()
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
            handler(template)
     
        default:
            preconditionFailure("Complication family not supported")
        }
    }
}

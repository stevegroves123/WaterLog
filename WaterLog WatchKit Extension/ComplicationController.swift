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
        let template = CLKComplicationTemplateModularSmallSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
        entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
 
    case .circularSmall:
        let template = CLKComplicationTemplateCircularSmallSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
        entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
 
    case .extraLarge:
        let template = CLKComplicationTemplateExtraLargeSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Extra Large")!)
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
              let template = CLKComplicationTemplateModularSmallSimpleImage()
              template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
            handler(template)
     
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleImage()
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
            handler(template)
     
        case .modularLarge:
            handler(nil)
        case .utilitarianSmall:
            handler(nil)
        case .utilitarianSmallFlat:
            handler(nil)
        case .utilitarianLarge:
            handler(nil)
            
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeSimpleImage()
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Extra Large")!)
            handler(template)
            
        case .graphicCorner:
            handler(nil)
        case .graphicBezel:
            handler(nil)
        case .graphicCircular:
            handler(nil)
        case .graphicRectangular:
            handler(nil)
        case .graphicExtraLarge:
            handler(nil)
        @unknown default:
            handler(nil)
        }
    }
}

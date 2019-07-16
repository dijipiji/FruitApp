//
//  EventLogger.swift
//  FruitApp
//
//  Created by Jamie Lemon on 16/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class EventLogger: NSObject {

    var startDate:Date?
    var endDate:Date?
    
    private func getMillisecondsBetweenDates() -> Int {
        
        if startDate != nil && endDate != nil {
            let secondDiff:TimeInterval = endDate!.timeIntervalSince(startDate!)
            let millisecondDiff:Int = Int(secondDiff * 1000)
            return millisecondDiff
        }
        
        return 0
        
    }
    
    func sendLoadEvent() {
        let milliseconds:Int = getMillisecondsBetweenDates()
        
        if milliseconds == 0 {
            sendErrorEvent(errorDescription:"Load event has no start date & end date, or there is no time difference between dates")
        } else {
            Service.sendStats(event:Service.StatType.LOAD, data:milliseconds, callback:{ (data, error) -> Void in
                
            })
        }
        
    }
    
    func sendDisplayEvent() {
        let milliseconds:Int = getMillisecondsBetweenDates()
        
        if milliseconds == 0 {
            sendErrorEvent(errorDescription:"Display event has no start date & end date, or there is no time difference between dates")
        } else {
            Service.sendStats(event:Service.StatType.DISPLAY, data:milliseconds, callback:{ (data, error) -> Void in
                
            })
        }
        
    }
    
    func sendErrorEvent(errorDescription:String) {
        Service.sendStats(event:Service.StatType.ERROR, data:errorDescription, callback:{ (data, error) -> Void in
            
        })
    }
    
}

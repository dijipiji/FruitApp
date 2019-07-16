//
//  CurrencyPrinter.swift
//  FruitApp
//
//  Created by Jamie Lemon on 16/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class CurrencyPrinter: NSObject {

    
    class func getPrintablePoundsAndPence(price:(pounds:Int, pence:Int)) -> String {
        
        var pencePrintable:String = "\(price.pence)"
        
        if price.pence < 10 {
            pencePrintable = "0"+pencePrintable
        }
        
        return "£\(price.pounds).\(pencePrintable)"
        
    }
}

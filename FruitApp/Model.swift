//
//  Model.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

typealias FruitEntity = (type:String, price:(pounds:Int, pence:Int)?, kgWeight:Double?)

class Model: NSObject {
    
    
    func dataToJSON(_ data:Data) -> [String : Any]? {
  
        do {
            let json:[String : Any]? = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            
            return json
        } catch {
            return nil
        }
        
    }

    func parseJSONData(_ json:[String : Any]) -> [FruitEntity]? {
        
        print("--->Model.parseJSONData")
        
        let list:[Any?] = json["fruit"] as! [Any?]
        
        let items:[FruitEntity]? = list.map { (item) -> FruitEntity in
            
            let itemUnwrapped:[String:Any] = item! as! [String:Any]
            let type:String = itemUnwrapped["type"] as! String? ?? "unknown"
            
            let price:(pounds:Int, pence:Int)? = penceToPoundsAndPence(itemUnwrapped["price"] as! Int?)
            let kgs:Double? = gramsToKiloGrams(itemUnwrapped["weight"] as! Int?)
  
            return FruitEntity(type:type, price:price, kgWeight:kgs)
            
        }
        
        return items
        
    }
    
    func penceToPoundsAndPence(_ pence:Int?) -> (pounds:Int, pence:Int)? {

        guard let pence:Int = pence else {
            return nil
        }
        
        let pounds:Int = Int(floor(Double(pence)/100))
        let remainingPence:Int = pence - (pounds*100)
        
        return (pounds:pounds, pence:remainingPence)
    
    }
    
    func gramsToKiloGrams(_ grams:Int?) -> Double? {
        
        guard let grams:Int = grams else {
            return nil
        }
        
        let kgs:Double = Double(grams)/1000
        
        return kgs
        
    }
    
}

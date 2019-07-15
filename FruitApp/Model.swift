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

    
    
    func parseJSONData(_ data:[String : Any]) -> [FruitEntity]? {
        
        let list:[Any?] = data["fruit"] as! [Any?]
        
        //print("parseJSONData, list=\(list)")
        
        let items:[FruitEntity]? = list.map { (item) -> FruitEntity in
            
            let itemUnwrapped:[String:Any] = item! as! [String:Any]
            let type:String = itemUnwrapped["type"] as! String? ?? "unknown"
            
            let price:(pounds:Int, pence:Int)? = penceToPoundsAndPence(itemUnwrapped["price"] as! Int?)
            let grammes:Int? = itemUnwrapped["weight"] as! Int?
            
            print("type=\(type)")
            print("price=\(price)")
            return FruitEntity(type:type, price:price, kgWeight:0.5)
            
        }
        
        
        return items
        
        
    }
    
    
   
    func penceToPoundsAndPence(_ pence:Int?) -> (pounds:Int, pence:Int)? {

        guard let pence:Int = pence else {
            return nil
        }
        
        let pounds:Int = Int(floor(Float(pence)/100))
        let remainingPence:Int = pence - (pounds*100)
        
        return (pounds:pounds, pence:remainingPence)
        
    }
    
}

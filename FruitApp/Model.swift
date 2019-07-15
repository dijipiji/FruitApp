//
//  Model.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

typealias FruitEntity = (type:String, price:(pounds:Int, pence:Int), kgWeight:Double)

class Model: NSObject {

    
    
    func parseJSONData(_ data:[String : Any]) -> [FruitEntity]? {
        
        let list:[Any?] = data["fruit"] as! [Any?]
        
        //print("parseJSONData, list=\(list)")
        
        let items:[FruitEntity]? = list.map { (item) -> FruitEntity in
            
            let itemUnwrapped:[String:Any] = item! as! [String:Any]
            let type:String = itemUnwrapped["type"] as! String? ?? "unknown"
            let price:Int? = itemUnwrapped["price"] as! Int?
            let grammes:Int? = itemUnwrapped["price"] as! Int?
            
            print("type=\(type)")
            return FruitEntity(type:type, price:(pounds:1, pence:99), kgWeight:0.5)
            
        }
        
        
        return nil
        
        
    }
}

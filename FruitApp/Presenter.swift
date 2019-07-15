//
//  Presenter.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class Presenter: NSObject {

    let model:Model = Model()
    var ownerVC:ResultsView?
    
    
    func getData(query:String = Service.baseURL,
                 callback:@escaping (Data?, Error?) -> Void) -> Bool {
        
        let validURL:Bool = Service.getJSONData(query:query, callback: { (data, error) -> Void in
            callback(data, error)
        })
        
        return validURL
    }
    
    
    func presentData(_ data:Data?, _ error:Error?) -> [FruitEntity]? {
     
        guard let data:Data = data else {
            return nil
        }
     
        if data.count == 0 || error != nil {
     
            DispatchQueue.main.async {
                self.searchComplete()
            }
     
            return nil
        }
        
        let items:[FruitEntity]? = model.parseJSONData(model.dataToJSON(data)!)
     
        DispatchQueue.main.async {
            self.searchComplete(items)
        }
     
        return items
     
    }
    
    
    func searchComplete(_ items:[FruitEntity]? = nil) {
        guard let ownerVC = ownerVC else {
            return
        }
        
        ownerVC.finishLoading()
        
        if items == nil {
            ownerVC.renderNoResults()
        } else {
            ownerVC.renderResults(items)
        }
    }
    

    func attachVC(_ vc:ResultsView) {
        ownerVC = vc
    }
    

    func detachVC() {
        ownerVC = nil
    }
    
    
}

/**
 *
 */
protocol ResultsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func renderNoResults()
    func renderResults(_ items:[FruitEntity]?)
}

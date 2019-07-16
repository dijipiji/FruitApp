//
//  Presenter.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class Presenter: NSObject {

    fileprivate let model:Model = Model()
    fileprivate let eventLogger:EventLogger = EventLogger()
    public var ownerVC:ResultsView?
    
    func getData(query:String = Service.baseURL,
                 callback:@escaping (Data?, Error?) -> Void) -> Bool {
        
        print("--->Presenter.getData")
        
        eventLogger.startDate = Date()
        
        if ownerVC != nil {
            ownerVC!.startLoading()
        }
        
        let validURL:Bool = Service.getJSONData(query:query, callback: { (data, error) -> Void in
            callback(data, error)
        })
        
        return validURL
    }
    
    
    func presentData(_ data:Data?, _ error:Error?) -> [FruitEntity]? {
     
        print("--->Presenter.presentData")
        
        guard let data:Data = data else {
            return nil
        }
     
        if data.count == 0 || error != nil {
     
            DispatchQueue.main.async {
                self.dataReady()
            }
     
            return nil
        }
        
        let items:[FruitEntity]? = model.parseJSONData(model.dataToJSON(data)!)
     
        DispatchQueue.main.async {
            self.dataReady(items)
        }
     
        return items
     
    }
    
    
    func dataReady(_ items:[FruitEntity]? = nil) {
        print("--->Presenter.dataReady")
        eventLogger.endDate = Date()
        eventLogger.sendLoadEvent()
        
        // forcing a small delay because loads can be so quick you don't get a sense that the activity spinner was even animating
        _ = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(presentResults (_ :)), userInfo: items, repeats: false)
        
    }
    
    @objc func presentResults(_ timer:Timer) {
        
        let items:[FruitEntity]? = timer.userInfo as? [FruitEntity]
        
        guard let ownerVC = ownerVC else {
            return
        }
        
        ownerVC.finishLoading()
        
        print("--->Presenter.presentResults")
        
        if items == nil {
            ownerVC.renderNoResults()
        } else {
            ownerVC.renderResults(items!)
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
    func renderResults(_ items:[FruitEntity])
}

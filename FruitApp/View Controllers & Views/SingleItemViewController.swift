//
//  SingleItemViewController.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class SingleItemViewController: BaseViewController {
    
    public var item:FruitEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SINGLE_ITEM_TITLE".localized()
        self.view.backgroundColor = StyleSheet.cellBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        render()
    }
    
    override func viewDidLayoutSubviews() {
        renderComplete()
    }
    
    override func render() {

        // Guard unwrap to ensure we have an item available to render
        guard let item:FruitEntity = item else {
            eventLogger.sendErrorEvent(errorDescription:"SingleItemViewController:\(#function) line:\(#line), there is no item to render")
            return
        }
        
        super.render()
        
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
        
        var baseFontSize:CGFloat = self.view.frame.size.width / 8
        
        if self.view.frame.size.width > self.view.frame.size.height {
            baseFontSize = self.view.frame.size.height / 8
        }
        
        let titleLabel:UILabel = UILabel(frame:CGRect(x:0,y:80,
                                                 width:self.view.frame.size.width,
                                                 height:baseFontSize*2))
        titleLabel.font = .systemFont(ofSize: baseFontSize, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = StyleSheet.textColor
        titleLabel.text = item.type
        
        self.view.addSubview(titleLabel)
        
        
        let priceLabel:UILabel = UILabel(frame:CGRect(x:0,y:titleLabel.frame.origin.y+titleLabel.frame.size.height,
                                                 width:self.view.frame.size.width,
                                                 height:baseFontSize*2))
        priceLabel.font = .systemFont(ofSize: baseFontSize-10.0, weight: .regular)
        priceLabel.textAlignment = .center
        priceLabel.textColor = StyleSheet.textColor
        
        var priceText:String = ""
        if item.price == nil {
            priceText = "PRICE_UNKNOWN".localized()
        } else {
            priceText = CurrencyPrinter.getPrintablePoundsAndPence(price:item.price!)
        }
        
        priceLabel.text = priceText
        
        self.view.addSubview(priceLabel)
        
        
        let weightLabel:UILabel = UILabel(frame:CGRect(x:0,y:priceLabel.frame.origin.y+priceLabel.frame.size.height,
                                                 width:self.view.frame.size.width,
                                                 height:baseFontSize*2))
        weightLabel.font = .systemFont(ofSize: baseFontSize-15.0, weight: .regular)
        weightLabel.textAlignment = .center
        weightLabel.textColor = StyleSheet.textColor
        
        var weightText:String = ""
        if item.kgWeight == nil {
            weightText = "WEIGHT_UNKNOWN".localized()
        } else {
            weightText = "\(item.kgWeight!) \("KILOGRAM_UNIT".localized())"
        }
        
        weightLabel.text = weightText
        
        self.view.addSubview(weightLabel)
  
    }

}

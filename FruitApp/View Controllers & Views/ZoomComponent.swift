//
//  ZoomComponent.swift
//  FruitApp
//
//  Created by Jamie Lemon on 17/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class ZoomComponent: UIView {

    func render(parentVC:ListViewController) {
        backgroundColor = StyleSheet.barBackgroundColor

        let sq:CGFloat = frame.size.width
        
        let zoomIn:UIButton = UIButton(frame:CGRect(x:0,
                                                    y:0,
                                                    width:sq,
                                                    height:sq))
        
        zoomIn.addTarget(parentVC, action: #selector(ListViewController.zoom(_:)), for: .touchUpInside)
        zoomIn.tag = -1
        zoomIn.setTitle("+", for: .normal)
        zoomIn.setTitleColor(StyleSheet.textColor, for: .normal)
        addSubview(zoomIn)
        
        let zoomOut:UIButton = UIButton(frame:CGRect(x:0,
                                                     y:sq,
                                                     width:sq,
                                                     height:sq))
        
        zoomOut.addTarget(parentVC, action: #selector(ListViewController.zoom(_:)), for: .touchUpInside)
        zoomOut.tag = 1
        zoomOut.setTitle("-", for: .normal)
        zoomOut.setTitleColor(StyleSheet.textColor, for: .normal)
        addSubview(zoomOut)
    }
}

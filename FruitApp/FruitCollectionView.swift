//
//  FruitCollectionView.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit


class MyCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
}


class FruitCollectionView: UICollectionView,
                           UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    
    
    var _items:[FruitEntity] = []
    

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        //let sq:CGFloat = self.frame.size.width/3
        
        //return Int(floor(self.frame.size.width/sq))
        
        
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("_items.count=\(_items.count)")
        return Int(ceil(Double(_items.count)/3))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell

        //cell.frame.size = CGSize(width:self.frame.size.width/3, height:cell.frame.size.height)
        cell.textLabel.text = "sec:\(indexPath.section), row:\(indexPath.row)"
        return cell
        

    }
    
    /*
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 100 * 3
        let totalSpacingWidth = 5 * (3 - 1)
        
        let leftInset = (self.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }*/
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sq:CGFloat = floor(self.frame.size.width/3)
        
        print("sq=\(sq)")
        
        return CGSize(width:sq,height:sq)
    }
    

}

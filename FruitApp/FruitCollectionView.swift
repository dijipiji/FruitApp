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
    
    fileprivate var columnNumber:Int = 3
    public var items:[[FruitEntity]] = []
    
    /**
     * The items need to be stored in a double array structure to match the row/column data referencing
     */
    func setItemsForCollectionFlowLayout(_ items:[FruitEntity]) {
        _ = items.enumerated().map { [unowned self] (index, item) in

            if index%columnNumber == 0 {
                self.items.append([])
            }
            
            self.items[self.items.count-1].append(item)

        }
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return columnNumber
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        
        cell.backgroundColor = StyleSheet.cellBackgroundColor
        cell.textLabel.textColor = StyleSheet.white
        cell.textLabel.text = items[indexPath.section][indexPath.row].type
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let collectionViewFlowLayout:UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            let sq:CGFloat = floor(self.frame.size.width/3)
            return CGSize(width:sq,height:sq)
        }
        
        let sq:CGFloat = floor(self.frame.size.width/3)-(collectionViewFlowLayout.sectionInset.left+collectionViewFlowLayout.sectionInset.right)
        return CGSize(width:sq,height:sq)
    }
    

}

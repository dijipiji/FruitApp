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
    
    @IBOutlet weak var listViewController:ListViewController?
    
    fileprivate var columnNumber:Int = 3
    fileprivate let minColumnNumber:Int = 1
    fileprivate let maxColumnNumber:Int = 9
    
    public var flatListOfItems:[FruitEntity] = []
    fileprivate var items:[[FruitEntity]] = []
    
    func modifyColumnNumber(_ num:Int) {
        columnNumber += num
        
        if columnNumber > maxColumnNumber {
            columnNumber = maxColumnNumber
        } else if columnNumber < minColumnNumber {
            columnNumber = minColumnNumber
        }
    }
    
    /**
     * The items need to be stored in a double array structure to match the row/column data referencing,
     * we also store a flat list of items for later use by the zoom component when we re-render content
     */
    func setItemsForCollectionFlowLayout(_ items:[FruitEntity]) {
        
        flatListOfItems = items
        
        self.items = []
        
        _ = items.enumerated().map { [unowned self] (index, item) in

            if index%columnNumber == 0 {
                self.items.append([])
            }
            
            self.items[self.items.count-1].append(item)

        }
    }
    
    func updateCellDisplay() {
        self.visibleCells.forEach { cell in
            guard let cell = cell as? MyCell else {
                return
            }
            
            cell.textLabel.font = getTitleFont()
            
        }
    }
    
    func getTitleFont() -> UIFont {
        let sq:CGFloat = floor(self.frame.size.width/CGFloat(columnNumber))
        return .systemFont(ofSize: sq/6, weight: .regular)
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
        
        cell.isHidden = false
        cell.backgroundColor = StyleSheet.cellBackgroundColor
        cell.textLabel.textColor = StyleSheet.textColor
        cell.textLabel.font = getTitleFont()
        
        if indexPath.row < items[indexPath.section].count {
            cell.textLabel.text = items[indexPath.section][indexPath.row].type
        } else {
            cell.isHidden = true
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:SingleItemViewController = SingleItemViewController()
        vc.eventLogger.startDate = Date()
        vc.item = items[indexPath.section][indexPath.row]
        self.listViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let collectionViewFlowLayout:UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            let sq:CGFloat = floor(self.frame.size.width/CGFloat(columnNumber))
            return CGSize(width:sq,height:sq)
        }
        
        let sq:CGFloat = floor(self.frame.size.width/CGFloat(columnNumber))-(collectionViewFlowLayout.sectionInset.left+collectionViewFlowLayout.sectionInset.right)
        return CGSize(width:sq,height:sq)
    }
    

}

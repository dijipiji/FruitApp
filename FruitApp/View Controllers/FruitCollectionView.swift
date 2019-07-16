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
    fileprivate var items:[[FruitEntity]] = []
    
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
        vc.item = items[indexPath.section][indexPath.row]
        vc.render()
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

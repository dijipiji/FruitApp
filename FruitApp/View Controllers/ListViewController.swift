//
//  ListViewController.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {
    
    
    @IBOutlet weak var activitySpinner:UIActivityIndicatorView?
    @IBOutlet weak var collectionView:FruitCollectionView?
    
    fileprivate let presenter:Presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Fruits"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload(_:)))
        presenter.attachVC(self)
        
        render()
    }
    
    @objc func reload(_ btn:UIBarButtonItem) {
        render()
    }
    
    /**
     * First we purge any displayed view and then add them back on to the hierarchy
     */
    override func render() {

        super.render()
        
        eventLogger.startDate = Date()
        
        collectionView?.collectionViewLayout.invalidateLayout()
        activitySpinner?.frame = self.view.frame

        _ = presenter.getData(callback:{ (data, error) -> Void in
            _ = self.presenter.presentData(data,error)
        })
    }
    
}


/**
 *
 */
extension ListViewController: ResultsViewController {
    
    
    // MARK: - Protocol methods
    /**
     *
     */
    func startLoading() {
        collectionView?.isHidden = true
        activitySpinner?.isHidden = false
        activitySpinner?.startAnimating()
    }
    
    /**
     *
     */
    func finishLoading() {
        collectionView?.isHidden = false
        activitySpinner?.stopAnimating()
        activitySpinner?.isHidden = true
    }
    
    /**
     *
     */
    func renderNoResults() {
        let lbl:UILabel = UILabel(frame: CGRect(x:0,y:0,
                                                width:self.view.frame.size.width,
                                                height:self.view.frame.size.height))
        lbl.textColor = .white
        lbl.text = "There are no results available"
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
        
        renderComplete()
    }
    
    /**
     *
     */
    func renderResults(_ items:[FruitEntity]) {
        
        collectionView?.frame = self.view.frame
        collectionView?.setItemsForCollectionFlowLayout(items)
        collectionView?.dataSource = collectionView
        collectionView?.delegate = collectionView
        
        // this ensures that cached cells also update their display on an orientation change
        collectionView?.updateCellDisplay()
        
        renderComplete()
     
    }
    

}

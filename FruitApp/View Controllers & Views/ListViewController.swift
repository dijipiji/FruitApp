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
        
        self.navigationItem.title = "LIST_TITLE".localized()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload(_:)))
        presenter.attachVC(self)
        
        render()
    }
    
    override func render() {
        
        super.render()
        
        for v in self.view.subviews {
            // we re-create and add these subviews everytime we render, so ensure to remove them if they already exist
            if v is UILabel {
                v.removeFromSuperview()
            }
            
            if v is ZoomComponent {
                v.removeFromSuperview()
            }
        }
        
        if Reachability.isConnectedToNetwork() {
            eventLogger.startDate = Date()
            
            collectionView?.collectionViewLayout.invalidateLayout()
            activitySpinner?.frame = self.view.frame
            
            _ = presenter.getData(callback:{ (data, error) -> Void in
                _ = self.presenter.presentData(data,error)
            })
        } else {
            let uiAlertVC:UIAlertController = UIAlertController(title:"NO_NETWORK_TITLE".localized(),
                                                                message:"NO_NETWORK".localized(),
                                                                preferredStyle: UIAlertController.Style.alert)
            let action:UIAlertAction = UIAlertAction(title:"OKAY".localized(),
                                                     style:UIAlertAction.Style.default,
                                                     handler:{ (myAlertAction: UIAlertAction!) in self.render() })
            
            uiAlertVC.addAction(action)
            self.present(uiAlertVC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Button actions
    
    @objc func reload(_ btn:UIBarButtonItem) {
        render()
    }
    
    @objc func zoom(_ btn:UIButton) {
        
        eventLogger.startDate = Date()
        
        guard let collectionView:FruitCollectionView = collectionView else {
            eventLogger.sendErrorEvent(errorDescription:"ListViewController:\(#function) line:\(#line), there is no collectionView linked in your Storyboard")
            return
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.modifyColumnNumber(btn.tag)
        collectionView.setItemsForCollectionFlowLayout(collectionView.flatListOfItems)
        collectionView.updateCellDisplay()
        collectionView.reloadData()
        
        collectionView.alpha = 0.8
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            collectionView.alpha = 1
        }, completion: {
            (value: Bool) in
            
            self.eventLogger.endDate = Date()
            self.eventLogger.sendDisplayEvent()
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
        lbl.text = "NO_RESULTS".localized()
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
        
        renderComplete()
    }
    
    /**
     *
     */
    func renderResults(_ items:[FruitEntity]) {
        
        guard let collectionView:FruitCollectionView = collectionView else {
            eventLogger.sendErrorEvent(errorDescription:"ListViewController:\(#function) line:\(#line), there is no collectionView linked in your Storyboard")
            return
        }
        
        collectionView.frame = self.view.frame
        collectionView.setItemsForCollectionFlowLayout(items)
        collectionView.dataSource = collectionView
        collectionView.delegate = collectionView
        
        // this ensures that cached cells also update their display on an orientation change
        collectionView.updateCellDisplay()
        
        let zoomComponent:ZoomComponent = ZoomComponent(frame:CGRect(x:self.view.frame.size.width-50,
                                                                     y:self.view.frame.size.height-150,
                                                                     width:50,height:100))
        self.view.addSubview(zoomComponent)
        zoomComponent.render(parentVC:self)

        renderComplete()
     
    }
    
    
}

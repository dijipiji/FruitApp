//
//  ListViewController.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    
    @IBOutlet weak var activitySpinner:UIActivityIndicatorView?
    let presenter:Presenter = Presenter()
    
    let scrollView:UIScrollView = UIScrollView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Fruits"
        presenter.attachVC(self)
        
        _ = presenter.getData(callback:{ (data, error) -> Void in
            _ = self.presenter.presentData(data,error)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func itemPressed(_ btn:UIButton) {
        let vc:SingleItemViewController = SingleItemViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}


/**
 *
 */
extension ListViewController: ResultsView {
    
    // MARK: - Protocol methods
    /**
     *
     */
    func startLoading() {
        activitySpinner?.startAnimating()
    }
    
    /**
     *
     */
    func finishLoading() {
        activitySpinner?.stopAnimating()
        activitySpinner?.removeFromSuperview()
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
    }
    
    /**
     *
     */
    func renderResults(_ items:[FruitEntity]?) {
        
        guard var items:[FruitEntity] = items else {
            renderNoResults()
            return
        }
        
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = UIColor(hexString: "#222222")
        self.view.addSubview(scrollView)
        
    }

}




//
//  HomeViewController.swift
//  Nummy
//
//  Created by Martin Chibwe on 11/9/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var segmentView: UIView!
    let segmentedControl = UISegmentedControl()
    let buttonBar = UIView()
    var forYouView: UIView!
    var exploreView: UIView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.segmentedControl.superview == nil{
            setupSegmentControl()
        }
    }
    
    //MARK: - object to switch segement selection
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl)  {

        self.setupViewSwitcher(selectedSegmentIndex: self.segmentedControl.selectedSegmentIndex)
    }
    //MARK: - Setup segment control
    
    func setupSegmentControl()  {
        
        // Do any additional setup after loading the view.
        
        segmentedControl.insertSegment(withTitle: "For You", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Explore", at: 1, animated: true)
//        segmentedControl.insertSegment(withTitle: "One", at: 2, animated: true)
        segmentedControl.selectedSegmentIndex  = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        
        
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: UIColor.orange
            ], for: .selected)
        
        view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: segmentView.topAnchor).isActive = true
        // Constrain the segmented control width to be equal to the container view width
        segmentedControl.widthAnchor.constraint(equalTo: segmentView.widthAnchor).isActive = true
        // Constraining the height of the segmented control to an arbitrarily chosen value
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        segmentView.addSubview(buttonBar)
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.bottomAnchor.constraint(equalTo: segmentView.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.widthAnchor.constraint(equalToConstant: (self.segmentView.frame.width/CGFloat(segmentedControl.numberOfSegments))).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        self.setupViewSwitcher(selectedSegmentIndex: segmentedControl.selectedSegmentIndex)
    }
    
    //MARK: - Setup custom view
    func setupViewSwitcher(selectedSegmentIndex: Int )  {
        forYouView = ForYouViewController().view
        exploreView = ExploreViewController().view

        UIView.animate(withDuration: 0.3) {
           self.buttonBar.frame.origin.x = ((self.segmentView.frame.width/CGFloat(self.segmentedControl.numberOfSegments))*CGFloat(selectedSegmentIndex))
        }

        func bringView(view:UIView){
            self.view.addSubview(view)
            self.buttonBar.backgroundColor = selectedSegmentIndex == 0 ? exploreView.backgroundColor:forYouView.backgroundColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: self.segmentView.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.view.bringSubview(toFront: view)
        }
        if selectedSegmentIndex == 0 {
            self.exploreView.removeFromSuperview()
        }else{
            self.forYouView.removeFromSuperview()
        }
        
        bringView(view: selectedSegmentIndex == 0 ? self.forYouView : self.exploreView)

    }
    


}



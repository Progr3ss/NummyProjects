//
//  HomeViewController.swift
//  Nummy
//
//  Created by Martin Chibwe on 11/9/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var segmentView: UIView!
    let segmentedControl = UISegmentedControl()
    let buttonBar = UIView()
    var forYouView: UIView!
    var exploreView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupSegmentControl()
//        setupViewSwitcher()
    }
    
    //MARK: - object to switch segement selection
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl)  {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
            self.setupViewSwitcher(selectedSegmentIndex: self.segmentedControl.selectedSegmentIndex)
            
        }
        
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
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
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
        buttonBar.backgroundColor = UIColor.orange
        segmentView.addSubview(buttonBar)
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
        
        
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        print("selected \(segmentedControl.selectedSegmentIndex)")
    }
    
    //MARK: - Setup custom view
    func setupViewSwitcher(selectedSegmentIndex: Int )  {
        forYouView = ForYouViewController().view
        exploreView = ExploreViewController().view
        viewContainer.addSubview(forYouView)
        
//        print("selected \(segmentedControl.selectedSegmentIndex)")
        print("segementTest \(selectedSegmentIndex)")
        if selectedSegmentIndex == 1 {
//            forYouView.topAnchor
//            viewContainer.topAnchor
            forYouView.topAnchor.constraint(equalTo: segmentView.topAnchor).isActive = true
            forYouView.widthAnchor.constraint(equalTo: segmentView.widthAnchor).isActive = true
            forYouView.translatesAutoresizingMaskIntoConstraints = false
//            forYouView.backgroundColor = UIColor.orange
//            segmentView.addSubview(buttonBar)
            // Constrain the top of the button bar to the bottom of the segmented control
            forYouView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
            forYouView.heightAnchor.constraint(equalToConstant: 5).isActive = true
            // Constrain the button bar to the left side of the segmented control
            forYouView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
            // Constrain the button bar to the width of the segmented control divided by the number of segments
//            buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
            
            
            
            
            
            
            
//             segmentedControl.topAnchor.constraint(equalTo: segmentView.topAnchor).isActive = true
            viewContainer.bringSubview(toFront: forYouView)
        }

    }
    


}



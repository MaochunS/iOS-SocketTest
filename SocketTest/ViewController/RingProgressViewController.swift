//
//  RingProgressViewController.swift
//  APPCommon
//
//  Created by maochun on 2020/7/23.
//  Copyright © 2020 maochun. All rights reserved.
//

import UIKit

class RingProgressViewController: UIViewController {
    
    lazy var spinner: SpinnerView = {
        let theView = SpinnerView()
        theView.Style = .None
        theView.innerFillColor = .clear //UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
        theView.outerFillColor = .clear //UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
        theView.outerStrokeColor = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
        theView.innerStrokeColor = UIColor(red: 0x4f/0xFF, green: 0x23/0xFF, blue: 0x59/0xFF, alpha: 1)
        theView.backgroundColor = .clear
        theView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(theView)
        theView.labelText = "Loading..."
        
        NSLayoutConstraint.activate([
            
            theView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
            theView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            theView.widthAnchor.constraint(equalToConstant: 100),
            theView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        
        return theView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.spinner.startAnimating()
    }
    
}

//
//  ViewController.swift
//  ZoomableImageViewSample
//
//  Created by Saber Hossain on 27/7/19.
//  Copyright © 2019 Saber Hossain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var scrollView: ZoomableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.setImage(image: UIImage(named: "landscape"), animate: false)
    }
   
}


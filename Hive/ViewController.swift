//
//  ViewController.swift
//  Hive
//
//  Created by Daniel Tomlinson on 28/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import UIKit
import Honeycomb
import Result
import CoreLocation

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestAlwaysAuthorization()
    }
    
}


//
//  LocationController.swift
//  Hive
//
//  Created by  Danielle Lancashireon 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import Foundation
import CoreLocation
import Result

/**
*  Encapsulate the CoreLocation stack and provide simple location update callbacks.
*/
public final class LocationManager {
    
    /**
    Start monitoring the users location.
    
    :param: callback
    */
    public func startMonitoringLocation(callback: (Result<Bool, NSError>) -> ()) {
        
    }
    
    public func stopMonitoringLocation() {
        
    }
}
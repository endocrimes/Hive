//
//  APIController.swift
//  Hive
//
//  Created by  Danielle Lancashireon 30/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import Foundation
import Foursquare_iOS_API

public struct APIController {
    public func launchAuthenticationFlow() {
        let fsq = BZFoursquare(clientID: "CL4EPEEF5TX4MXVKL3SPOV2YFGIY0GGEXYGPLY3YP3VRHVOC", callbackURL: "hiveapp://authentication")
        fsq.startAuthorization()
    }
    
    public init() {
        
    }
}
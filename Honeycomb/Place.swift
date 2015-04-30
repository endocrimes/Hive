//
//  Place.swift
//  Hive
//
//  Created by Danielle Lancashire on 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import Foundation

public struct Place {
    public let title: String
    public let distance: String
    public let identifier: String = "DemoIdentifier"
    
    public init(title: String, distance: String) {
        self.title = title
        self.distance = distance
    }
}

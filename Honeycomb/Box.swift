//
//  Box.swift
//  Hive
//
//  Created by Daniel Tomlinson on 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import Foundation

/// The infamous Box Hack.
public final class Box<A> {
    public let unBox : () -> A
    
    public init(_ x : A) {
        unBox = { x }
    }
}

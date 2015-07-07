//
//  PlaceDetailInterfaceController.swift
//  Hive
//
//  Created by Danielle Lancashire on 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import WatchKit
import Honeycomb


class PlaceDetailInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let box = context as? Box<Place> {
            let place = box.unBox()
            
            setTitle(place.title)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

//
//  NearbyInterfaceController.swift
//  Hive
//
//  Created by  Danielle Lancashireon 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import WatchKit
import Honeycomb


class NearbyInterfaceController: WKInterfaceController {
    @IBOutlet weak var placeTable: WKInterfaceTable?
    var data: [Place] = [Place(title: "BBC Henry Wood House", distance: "0.0km"), Place(title: "Starbucks", distance: "0.1km")]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        reloadTable()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("DetailController", context: Box(data[rowIndex]))
    }
    
    func reloadTable() {
        placeTable?.setNumberOfRows(data.count, withRowType: "PlaceRow")
        
        for (index, place) in enumerate(data) {
            if let row = placeTable?.rowControllerAtIndex(index) as? PlaceRow {
                row.title = place.title
                row.detail = place.distance
                
                row.updateUI()
            }
        }
    }
}
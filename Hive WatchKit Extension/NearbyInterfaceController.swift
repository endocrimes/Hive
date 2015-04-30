//
//  NearbyInterfaceController.swift
//  Hive
//
//  Created by Danielle Lancashire on 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import WatchKit
import Honeycomb
import CoreLocation
import Result

class NearbyInterfaceController: WKInterfaceController {
    private let locationController: LocationManager = LocationManager()

    @IBOutlet weak var placeTable: WKInterfaceTable?
    var data: [Place] = [Place(title: "BBC Henry Wood House", distance: "0.0km"), Place(title: "Starbucks", distance: "0.1km")]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        reloadData()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("DetailController", context: Box(data[rowIndex]))
    }
    
    func reloadData() {
        CLLocationManager().requestWhenInUseAuthorization()
        
        locationController.requestCurrentLocationWithCompletion { result in
            if let location = result.value {
                dispatch_async(dispatch_get_main_queue()) {
                    self.reloadTable()
                }
            }
            else if let error = result.error {
                dispatch_async(dispatch_get_main_queue()) {
                    self.pushControllerWithName("AlertController", context: error)
                }
            }
        }
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
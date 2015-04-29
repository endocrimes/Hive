//
//  PlaceRow.swift
//  Hive
//
//  Created by  Danielle Lancashireon 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import WatchKit

class PlaceRow: NSObject {
    @IBOutlet weak var titleLabel: WKInterfaceLabel?
    @IBOutlet weak var detailLabel: WKInterfaceLabel?
    
    var title: String = ""
    var detail: String = ""
    
    func updateUI() {
        titleLabel?.setText(title)
        detailLabel?.setText(detail)
    }
}

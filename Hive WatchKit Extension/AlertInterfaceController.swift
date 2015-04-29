//
//  AlertInterfaceController.swift
//  Hive
//
//  Created by  Danielle Lancashireon 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import WatchKit
import Foundation


class AlertInterfaceController: WKInterfaceController {
    @IBOutlet weak var messageLabel: WKInterfaceLabel?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let message = context as? String {
            messageLabel?.setText(message)
        }
    }
}

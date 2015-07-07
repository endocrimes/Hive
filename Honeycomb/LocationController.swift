//
//  LocationController.swift
//  Hive
//
//  Created by Danielle Lancashire on 29/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import Foundation
import CoreLocation
import Result

private func dispatch_timer_create(interval: Int64, queue: dispatch_queue_t, block: dispatch_block_t) -> dispatch_source_t {
    var timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)!;
    let intervalInNsec: Int64 = interval * Int64(NSEC_PER_SEC)
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW as dispatch_time_t, intervalInNsec), UInt64(intervalInNsec), (1 * NSEC_PER_SEC) / 10)
    dispatch_source_set_event_handler(timer, block)
    dispatch_resume(timer)
    
    return timer
}

/**
*  Encapsulate the CoreLocation stack and provide simple location update callbacks.
*/
public final class LocationManager: NSObject, CLLocationManagerDelegate {
    public typealias CompletionType = Result<CLLocation, String> -> ()
    
    // MARK: - Private properties
    
    private let maximumWaitTimeInSeconds: Int64 = 10
    private let minimumWaitTimeInSeconds: Int64 = 2
    private let locationManager: CLLocationManager = CLLocationManager()
    private let timerQueue: dispatch_queue_t = dispatch_queue_create("Honeycomb.Private.Timer", nil)
    
    private var minimumWaitTimer: dispatch_source_t?
    private var maximumWaitTimer: dispatch_source_t?
    private var minimumWaitTimeReached: Bool = false
    private var maximumWaitTimeReached: Bool = false
    private var locationSettled: Bool = false
    private var completion: CompletionType?
    
    // MARK: - Public Interface
    
    public var responseQueue: dispatch_queue_t = dispatch_queue_create("Honeycomb.LocationManager", nil)
    
    /**
    Requests a users current location and fires a completion closure once it has
    established that an accurate location has been found, or that an error has occured.
    
    :param: completion A closure executed when the manager succeeds or fails.
    */
    public func requestCurrentLocationWithCompletion(completion: CompletionType) {
        cleanup()
        
        self.locationManager.delegate = self
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if (authorizationStatus != .AuthorizedAlways) {
            self.locationManager.requestAlwaysAuthorization()
            completion(Result(error: "Unauthorized \(authorizationStatus)"))
            return
        }
        
        self.completion = completion
        
        self.locationManager.startUpdatingLocation()
        
        minimumWaitTimer = dispatch_timer_create(minimumWaitTimeInSeconds, timerQueue) { [weak self] in
            self?.minimumWaitTimeReached = true
            if let timer = self?.minimumWaitTimer {
                dispatch_source_cancel(timer)
            }
        }
        
        maximumWaitTimer = dispatch_timer_create(maximumWaitTimeInSeconds, timerQueue) { [weak self] in
            if let timer = self?.maximumWaitTimer {
                dispatch_source_cancel(timer)
            }
        }
    }
    
    /**
    Create a new LocationManager.
    */
    public override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
    }
    
    // MARK: - Private
    
    /**
    Once all location crtiera has been met, take the current location and return it to the callee.
    */
    private func settleUponCurrentLocation() {
        // If we've already settled upon a location, don't fire again
        if (locationSettled) {
            return
        }
        
        // Location settled upon!
        locationSettled = true
        
        completion?(Result(value: self.locationManager.location));
        
        cleanup()
    }
    
    /**
    Reset the state of the location manager.
    */
    private func cleanup() {
        self.locationManager.stopUpdatingLocation()
        if let timer = self.minimumWaitTimer {
            dispatch_source_cancel(timer)
        }
        if let timer = self.maximumWaitTimer {
            dispatch_source_cancel(timer)
        }
        self.minimumWaitTimeReached = false
        self.maximumWaitTimeReached = false
        self.completion = nil
    }
    
    // MARK: CLLocationManagerDelegate
    
    public func locationManager(manager: CLLocationManager?, didUpdateToLocation newLocation: CLLocation?, fromLocation oldLocation: CLLocation?) {
        
        // If accuracy greater than 100 meters, it's too inaccurate
        if newLocation?.horizontalAccuracy > 100 && newLocation?.verticalAccuracy > 100 {
            return
        }
        
        // If location is older than 10 seconds, it's probably an old location getting re-reported
        var locationTimeIntervalSinceNow = abs(newLocation?.timestamp.timeIntervalSinceNow ?? 9999999)
        if (locationTimeIntervalSinceNow > 10) {
            return
        }
        
        // If we haven't exceeded our min wait time, it's probably still too inaccurate
        if (!minimumWaitTimeReached) {
            return
        }
        
        self.settleUponCurrentLocation()
    }
}
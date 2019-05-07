//
//  PermissionManager+Location.swift
//  PermissionManager
//
//  Created by Shivank Agarwal on 07/05/19.
//  Copyright © 2019 Shivank Agarwal. All rights reserved.
//

import UIKit
import CoreLocation

extension PermissionManager{
    
    func initLocation() {
        DispatchQueue.main.async {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            self.locationManager.startMonitoringSignificantLocationChanges()
            self.locationManager.distanceFilter = 0
            self.locationManager.requestWhenInUseAuthorization()
            self.locationAuthorizationStatus()
        }
    }
    
    func locationAuthorizationStatus() {
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            self.locationDelegate?.requirePermission(.permissionTypeLocation)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .restricted:
            self.locationDelegate?.requirePermission(.permissionTypeLocation)
        case .denied:
            self.locationDelegate?.requirePermission(.permissionTypeLocation)
        }
    }
}

extension PermissionManager: CLLocationManagerDelegate{
    
    //MARK- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationDelegate?.didUpdateLocations(locations, manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationDelegate?.didFailWithError(error, manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        self.locationDelegate?.didDetermineState(state, _region: region, manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationDelegate?.didChangeAuthorizationStatus(status, manager)
    }
}

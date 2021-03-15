//
//  LocationUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/16.
//

import UIKit
import CoreLocation

/**
 * LocationUtil.swift
 *
 * @description 위치정보 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
import Foundation
import CoreLocation
import Combine

class LocationUtil: NSObject, ObservableObject {
    
    let TAG: String = "[LocationUtil]" // 디버그 태그
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationUtil: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)
    }
}

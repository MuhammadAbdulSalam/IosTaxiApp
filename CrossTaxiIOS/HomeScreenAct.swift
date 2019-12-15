//
//  HomeScreenAct.swift
//  CrossTaxiIOS
//
//  Created by madbulsa on 08/12/2019.
//  Copyright © 2019 madbulsa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleMaps


class HomeScreenAct : UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapNew: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        //Map settings
        let camera = GMSCameraPosition.camera(withLatitude: -33.86,
                                              longitude: 151.20, zoom: 13.0)
        self.mapNew.animate(to: camera)
        self.mapNew.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapNew
        
        //Location Settings
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
  
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.mapNew?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
}

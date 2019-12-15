//
//  AutoLocation.swift
//  CrossTaxiIOS
//
//  Created by madbulsa on 15/12/2019.
//  Copyright © 2019 madbulsa. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps


class AutoLocation: UITableViewController {
    
    var placeIDArray = [String]()
    var resultsArray = [String]()
    var primaryAddressArray = [String]()
    var searchResults = [String]()
    var searhPlacesName = [String]()
    

    @IBOutlet weak var searchLoc: UITextField!
    
  
    @IBAction func startSearch(_ sender: Any) {
        let search: String = self.searchLoc.text ?? "newVal"
        placeAutocomplete(text_input: search)

    }
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view
        
       }

    //function for autocomplete
    func placeAutocomplete(text_input: String) {
    let filter = GMSAutocompleteFilter()
    let placesClient = GMSPlacesClient()
    filter.type = .establishment
    //geo bounds set for bengaluru region
    let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 13.001356, longitude: 75.174399), coordinate: CLLocationCoordinate2D(latitude: 13.343668, longitude: 80.272055))


    placesClient.autocompleteQuery(text_input, bounds: bounds, filter: nil) { (results, error) -> Void in
    self.placeIDArray.removeAll() //array that stores the place ID
    self.resultsArray.removeAll() // array that stores the results obtained
    self.primaryAddressArray.removeAll() //array storing the primary address of the place.
    if let error = error {
    print("Autocomplete error \(error)")
    return
    }
    if let results = results {
    for result in results {
    self.primaryAddressArray.append(result.attributedPrimaryText.string)
    //print("primary text: \(result.attributedPrimaryText.string)")
    //print("Result \(result.attributedFullText) with placeID \(String(describing: result.placeID!))")
    self.resultsArray.append(result.attributedFullText.string)
    self.primaryAddressArray.append(result.attributedPrimaryText.string)
        self.placeIDArray.append(result.placeID)
    }
    }
    self.searchResults = self.resultsArray
    self.searhPlacesName = self.primaryAddressArray
    self.tableView.reloadData()
    }
    }
    

}

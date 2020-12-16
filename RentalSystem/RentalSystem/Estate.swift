//
//  Estate.swift
//  RentalSystem
//
//  Created by apple on 2020/11/16.
//

import Foundation
import MapKit
class Estate:NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let location: CLLocation
    init(
           
           title: String,
           coordinate: CLLocationCoordinate2D,
        location:CLLocation
       ) {
           
           self.title = title
           self.coordinate = coordinate
        self.location = location
       }
       
}

extension Estate{
    static let appartmentEstate:[Estate] = [
        Estate(title: "Festival City", coordinate: CLLocationCoordinate2D(latitude: 22.34013, longitude: 114.186191),location:CLLocation(latitude: 22.34013, longitude: 114.186191)),
        Estate(title: "Whampoa Garden", coordinate: CLLocationCoordinate2D(latitude: 22.3077, longitude: 114.201731),location:CLLocation(latitude: 22.3077, longitude: 114.201731)),
        Estate(title: "LOHAS Park", coordinate: CLLocationCoordinate2D(latitude: 22.297886, longitude: 114.284308),location:CLLocation(latitude: 22.297886, longitude: 114.284308)),
        Estate(title: "City One Shatin", coordinate: CLLocationCoordinate2D(latitude: 22.389986, longitude: 114.215466),location:CLLocation(latitude: 22.389986, longitude: 114.215466)),
        Estate(title: "Laguna City", coordinate: CLLocationCoordinate2D(latitude: 22.309595, longitude: 114.239176),location:CLLocation(latitude: 22.309595, longitude: 114.239176)),
        Estate(title: "South Horizons", coordinate: CLLocationCoordinate2D(latitude: 22.246643, longitude: 114.159201),location:CLLocation(latitude: 22.246643, longitude: 114.159201))
       
    
    
    
    ]
}

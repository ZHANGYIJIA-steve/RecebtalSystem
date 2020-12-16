//
//  estate.swift
//  RentalSystem
//
//  Created by apple on 2020/11/13.
//

import Foundation
struct Apartment: Codable{
    let property_title: String
    let image_URL: String
    let estate: String
    let bedrooms: Int
    let gross_area:Int
    let expected_tenants:Int
    let rent:Int
    let id:Int
 
    
}
extension Apartment{
    static let sampleData: [Apartment] = [
        Apartment(property_title: "balabala", image_URL: "balabala", estate: "balabalahei", bedrooms: 2, gross_area: 20, expected_tenants: 30, rent: 40,id:1),
        Apartment(property_title: "kulakula", image_URL: "kulakula", estate: "kulakulakua", bedrooms: 3, gross_area: 100, expected_tenants: 2, rent: 70,id:2)
    ]
}

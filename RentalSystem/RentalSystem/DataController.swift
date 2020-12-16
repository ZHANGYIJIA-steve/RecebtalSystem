//
//  DataController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/14.
//

import Foundation
import CoreData

class DataController {
    
    var persistentContainer: NSPersistentContainer
    var shouldSeedDatabase: Bool = false
    let networkController = NetworkController()
    var apartments: [Apartments] = []
    
    init(completion: @escaping () -> ()) {
        // Check if the database exists
            do {
                let databaseUrl =
                    try FileManager.default.url(for: .applicationSupportDirectory,
                                                in: .userDomainMask, appropriateFor: nil,
                                                create: false).appendingPathComponent("ApartmentModel.sqlite")
                
                shouldSeedDatabase = !FileManager.default.fileExists(atPath: databaseUrl.path)
            } catch {
                shouldSeedDatabase = true
            }
        
        persistentContainer = NSPersistentContainer(name: "ApartmentModel")
        persistentContainer.loadPersistentStores { (description, error) in
            
            if let error = error {
                fatalError("Core Data stack could not be loaded. \(error)")
            }
            
            // Called once initialization of Core Data stack is complete
            DispatchQueue.main.async {
                        if (self.shouldSeedDatabase) {
                            self.seedData()
                        }
                        completion()
                    }
        }
    }
    private func seedData() {
        networkController.fetchApartments(completionHandler:
            { (apartments) in
                DispatchQueue.main.async {[self] in
                    self.persistentContainer.performBackgroundTask { (managedObjectContext) in
                        apartments.forEach{(apartment)in
                            let apartmentManagedObject = ApartmentManagedObject(context: managedObjectContext)
                            apartmentManagedObject.bedrooms=Int16(apartment.bedrooms)
                            apartmentManagedObject.estate=apartment.estate
                            apartmentManagedObject.expected_tenants=Int16(apartment.expected_tenants)
                            apartmentManagedObject.gross_area=Int16(apartment.gross_area)
                            apartmentManagedObject.id=Int32(apartment.id)
                            apartmentManagedObject.image_URL=apartment.image_URL
                            apartmentManagedObject.property_title=apartment.property_title
                            apartmentManagedObject.rent=Int32(apartment.rent)
                            do{
                                try managedObjectContext.save()
                            }catch{
                                print("Could not save \(error)")
                            }
                        }
                    }
                }
            }){ (error) in
            DispatchQueue.main.async {
                print("Error")
            }
        }
    }
   
//    private func seedData() {
//        networkController.fetchApartments(completionHandler:
//            { (apartments) in
//                DispatchQueue.main.async {
//                    self.apartments = apartments
//                    
//                }
//        }) { (error) in
//            DispatchQueue.main.async {
//                self.apartments = []
//               
//            }
//        }
//        print("!!!!!!!!!!!!!!!!!!!!")
//        
//        print(apartments.count)
//        apartments.forEach{(apartment) in
//            print(apartment.bedrooms)
//            print(apartment.estate)
//            print(apartment.property_title)
//        }
//         
//        persistentContainer.performBackgroundTask { (managedObjectContext) in
//            self.apartments.forEach { (apartment) in
//                  let apartmentManagedObject = ApartmentManagedObject(context: managedObjectContext)
//              apartmentManagedObject.bedrooms=Int16(apartment.bedrooms)
//              apartmentManagedObject.estate=apartment.estate
//              apartmentManagedObject.expected_tenants=Int16(apartment.expected_tenants)
//              apartmentManagedObject.gross_area=Int16(apartment.gross_area)
//              apartmentManagedObject.id=Int32(apartment.id)
//              apartmentManagedObject.image_URL=apartment.image_URL
//              apartmentManagedObject.property_title=apartment.property_title
//              apartmentManagedObject.rent=Int32(apartment.rent)
//            }
//            // Loop through all sample data and add to the database
////          Apartment.sampleData.forEach { (apartment) in
////                let apartmentManagedObject = ApartmentManagedObject(context: managedObjectContext)
////            apartmentManagedObject.bedrooms=Int16(apartment.bedrooms)
////            apartmentManagedObject.estate=apartment.estate
////            apartmentManagedObject.expected_tenants=Int16(apartment.expected_tenants)
////            apartmentManagedObject.gross_area=Int16(apartment.gross_area)
////            apartmentManagedObject.id=Int32(apartment.id)
////            apartmentManagedObject.image_URL=apartment.image_URL
////            apartmentManagedObject.property_title=apartment.property_title
////            apartmentManagedObject.rent=Int32(apartment.rent)
//            
////            }
//            
//            do {
//                try managedObjectContext.save()
//            } catch {
//                print("Could not save managed object context. \(error)")
//            }
//        }
//    }
}

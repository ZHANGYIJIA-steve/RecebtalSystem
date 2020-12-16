//
//  MapViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/16.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let campusLocation = CLLocation(latitude: 22.33787, longitude: 114.18131)
    var Uestate: String?
    var estates: [Estate] = []

    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estates = Estate.appartmentEstate.filter { $0.title == Uestate }
        for estate in estates{
            mapview.setCenterLocation(estate.location)
       
            mapview.addAnnotation(estate)
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
private extension MKMapView {
    
    func setCenterLocation(_ location: CLLocation,
                           regionRadius: CLLocationDistance = 500) {
        
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
    
}

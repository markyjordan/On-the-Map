//
//  MapViewVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/20/20.
//

import UIKit
import MapKit

class MapViewVC: UIViewController, MKMapViewDelegate {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locations = [String: Any]()
    var annotations = [MKPointAnnotation]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    // MARK: - MKMapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

}

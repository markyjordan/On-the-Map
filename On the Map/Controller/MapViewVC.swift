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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var locations = [StudentLocation]()
    var annotations = [MKPointAnnotation]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getMapData()
    }
    
    
    // MARK: - User Interface
    
    @IBAction func logout(_ sender: Any) {
        self.activityIndicatorView.startAnimating()
        
        UdacityClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    @IBAction func refreshMapData(_ sender: Any) {
        getMapData()
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
        
    }
    
    
    // MARK: - Helpers
    
    func getMapData() {
        self.activityIndicatorView.startAnimating()
        self.mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        
        UdacityClient.getStudentLocations { (locations, error) in
            self.locations = locations

            
            for student in self.locations {
    
                let lat = CLLocationDegrees(student.latitude as! Double)
                let long = CLLocationDegrees(student.longitude as! Double)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let first = student.firstName
                let last = student.lastName
                let mediaURL = student.mediaURL
                
                // create the annotation and set the coordinate, title and subtitle properties
                // finally, add it to the global array of map annotations
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                self.annotations.append(annotation)
            }
            
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.annotations)
                self.activityIndicatorView.stopAnimating()
            }
        }
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle {
                openURL(toOpen ?? "")
            }
        }
    }

}

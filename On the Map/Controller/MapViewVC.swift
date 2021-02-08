 //
//  MapViewVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/20/20.
//

import UIKit
import MapKit

class MapViewVC: UIViewController, MKMapViewDelegate {

    //  MARK: - Outlets/Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var refreshMap: UIBarButtonItem!
    @IBOutlet weak var addLocation: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var locations = [StudentLocation]()
    var annotations = [MKPointAnnotation]()
    
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  set the map view delegate
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getMapData()
    }
    
    
    //  MARK: - Navigation
    
    @IBAction func logout(_ sender: Any) {
        setActivityIndicator(true)
        
        UdacityNetworkClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                self.setActivityIndicator(false)
            }
        }
    }
    

    //  MARK: - User Interface
    
    @IBAction func refreshMapData(_ sender: Any) {
        getMapData()
    }
    
    
    //  MARK: - Helpers
    
    private func getMapData() {
        setActivityIndicator(true)
        self.mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        
        UdacityNetworkClient.getStudentLocations { (locations, error) in
            self.locations = locations
            
            for student in self.locations {
                let lat = CLLocationDegrees(student.latitude)
                let long = CLLocationDegrees(student.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let first = student.firstName
                let last = student.lastName
                let mediaURL = student.mediaURL
                
                //  create the annotation and set the coordinate, title and subtitle properties
                //  finally, add it to the global array of map annotations
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                self.annotations.append(annotation)
            }
            
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.annotations)
                self.setActivityIndicator(false)
            }
        }
    }
    
    //  set activity indicator view state
    private func setActivityIndicator(_ fetchingData: Bool) {
        if fetchingData {
            DispatchQueue.main.async {
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
        
        //  enable/disable UI views
        DispatchQueue.main.async {
            self.refreshMap.isEnabled = !fetchingData
            self.addLocation.isEnabled = !fetchingData
        }
    }
    
    
    //  MARK: - MKMapViewDelegate Methods
    
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

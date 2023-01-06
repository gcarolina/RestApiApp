//  MapVC.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit
import MapKit

final class MapVC: UIViewController {
    var address: Address?
    var pin: MapMarker!
    
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = address?.city, let street = address?.street else { return }
        self.navigationItem.title = "\(street), \(city)"
        
        guard let lat = Double(address?.geo?.lat ?? ""), let lng = Double(address?.geo?.lng ?? "") else { return }
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        mapView.centerToLocation(initialLocation)
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        pin = MapMarker(title: "\(address?.street ?? "")", subtitle: "\(address?.city ?? "")", coordinate: location)
        mapView.addAnnotation(pin)
        
    }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

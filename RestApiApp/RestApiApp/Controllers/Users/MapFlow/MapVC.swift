//  MapVC.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit
import MapKit

final class MapVC: UIViewController, MKMapViewDelegate {
//    var address: Address?
    var user: User?
    
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = user?.address?.city, let street = user?.address?.street else { return }
        self.navigationItem.title = "\(street), \(city)"
        
        guard let lat = Double(user?.address?.geo?.lat ?? ""), let lng = Double(user?.address?.geo?.lng ?? "") else { return }
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        mapView.centerToLocation(initialLocation)
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let pin = MapMarker(coordinate: location, title: "\(user?.company?.name ?? "")", subtitle: "\(user?.address?.street ?? "")")
        mapView.addAnnotation(pin)
        self.mapView.delegate = self
    }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

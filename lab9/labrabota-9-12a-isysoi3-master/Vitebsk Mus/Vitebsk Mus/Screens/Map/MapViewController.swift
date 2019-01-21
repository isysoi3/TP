//
//  ViewController.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/4/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
import CoreData

class MapViewController: UIViewController {

    private var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var statusBarLabel: UILabel!
    private var cites: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        
        locationManager = CLLocationManager()
        mapView = MKMapView()
        
        confiqureSubviews()
        
        view.addSubview(statusBarLabel)
        view.addSubview(mapView)
        
        confiqureConstraints()
        setupData()
    }
    
    private func initData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CityInfo>(entityName: "CityInfo")
        do
        {
            let tmp = try context.fetch(fetchRequest)
            cites = tmp as [NSManagedObject]
            print(cites.count)
        }
        catch let error as NSError
        {
            print("Data loading error: \(error)")
        }
    }
    
    private func confiqureSubviews() {
        statusBarLabel = UILabel()
        statusBarLabel.backgroundColor = .white
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    private func confiqureConstraints() {
        statusBarLabel.snp.makeConstraints { make in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(topLayoutGuide.snp.bottom)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setupData() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            for item in cites {
                let title = item.value(forKey: "name") as! String
                let locationLatitude = item.value(forKey: "locationLatitude") as! Double
                let locationLongitude = item.value(forKey: "locationLongitude") as! Double
                
                let coordinate = CLLocationCoordinate2DMake(locationLongitude, locationLatitude)
                let regionRadius = 100.0
                
                let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                             longitude: coordinate.longitude),
                                              radius: regionRadius,
                                              identifier: title)
                
                locationManager.startMonitoring(for: region)
                
                let museumAnnotation = MKPointAnnotation()
                museumAnnotation.coordinate = coordinate
                museumAnnotation.title = "\(title)"
                mapView.addAnnotation(museumAnnotation)
        
                let circle = MKCircle(center: coordinate, radius: regionRadius)
                mapView.add(circle)
            }
        }
        else {
            print("System can't track regions")
        }
    }
    
}


extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if let annotation = view.annotation,
            let title = annotation.title! {
            let vc = MuseumsViewController(name: title)
            present(vc, animated: true)
        }
        
        
    }
}

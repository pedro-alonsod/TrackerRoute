//
//  ConductoresViewController.swift
//  TrackerRoute
//
//  Created by Nora Hilda De los Reyes on 03/03/16.
//  Copyright © 2016 pedro alonso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ConductoresViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var usuarioLabel: UILabel!
    @IBOutlet weak var mapaDeLlegada: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //mapForRoute.showsUserLocation = true
        
        
        //faster loading of map
        mapaDeLlegada.delegate = self
        //---//
        //let spanX = 0.001
        //let spanY = 0.001
        
        // Create a region using the user's location, and the zoo.
        //var newRegion = MKCoordinateRegion(center: mapForRoute.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        // set the map to the new region
        //mapForRoute.setRegion(newRegion, animated: false)
        
        mapaDeLlegada.showsUserLocation = true
        
        mapaDeLlegada.showsBuildings = true
        
        // set initial location in Honolulu
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let locationMty = CLLocation(latitude: 25.68661, longitude: -100.31611)
        //let locationInitial = CLLocation(latitude: mapForRoute.userLocation.coordinate.latitude, longitude: mapForRoute.userLocation.coordinate.longitude)
        
        //centerMapOnLocation(initialLocation)
        
        centerMapOnLocation(locationMty)
        //centerMapOnLocation(locationInitial)
        // timestamp
        
        /*
        let locationForPin: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.68661, longitude: -100.31611)
        
        var anotation = MKPointAnnotation()
        anotation.coordinate = locationForPin
        anotation.title = "Conductor Pedro"
        anotation.subtitle = "LLego a las \(printTimestamp())"
        mapForRoute.addAnnotation(anotation)
        */
        
        //print(printTimestamp())
        
        //print(arrayOfNames.removeFirst())
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        //mapaDeLlegada.addGestureRecognizer(longPress)
        
        usuarioLabel.text = userName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapaDeLlegada)
        var newCoord:CLLocationCoordinate2D = mapaDeLlegada.convertPoint(touchPoint, toCoordinateFromView: self.mapaDeLlegada)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "Teminado"
        newAnotation.subtitle = "He llegado"
        mapaDeLlegada.addAnnotation(newAnotation)
        
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapaDeLlegada.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        mapaDeLlegada.showsUserLocation = (status == .AuthorizedAlways)
        
    }

    @IBAction func terminadoTapped(sender: UIButton) {
     
        let locationMty = CLLocation(latitude: 25.68661, longitude: -100.31611)
        //let locationInitial = CLLocation(latitude: mapForRoute.userLocation.coordinate.latitude, longitude: mapForRoute.userLocation.coordinate.longitude)
        
        //centerMapOnLocation(initialLocation)
        
        centerMapOnLocation(locationMty)
        
        var newCoord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(25.67802, -100.28792)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "Teminado"
        newAnotation.subtitle = "He llegado"
        mapaDeLlegada.addAnnotation(newAnotation)
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MapForPlacesViewController.swift
//  TrackerRoute
//
//  Created by Nora Hilda De los Reyes on 02/03/16.
//  Copyright © 2016 pedro alonso. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapForPlacesViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate {

    @IBOutlet weak var driversTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var sentText: String!
    var timer: NSTimer = NSTimer()
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapForRoute: MKMapView!
    
    var arrayOfLatitudes: [Double] = []
    var arrayOfOfLongitudes: [Double] = []
    var arrayOfNames: [String] = []
    
    var cell: UITableViewCell!
    
    var timeStamp: String!
    
    var arrayDeLlegadas: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        arrayOfLatitudes.append(25.67802)
        arrayOfLatitudes.append(25.67586)
        arrayOfLatitudes.append(25.66967)
        arrayOfLatitudes.append(25.66472)
        arrayOfLatitudes.append(25.65133)
        arrayOfLatitudes.append(25.66994)
        arrayOfLatitudes.append(25.67330)
        arrayOfLatitudes.append(25.68878)
        arrayOfLatitudes.append(25.64815)
        
        arrayOfOfLongitudes.append(-100.28792)
        arrayOfOfLongitudes.append(-100.30539)
        arrayOfOfLongitudes.append(-100.32534)
        arrayOfOfLongitudes.append(-100.33032)
        arrayOfOfLongitudes.append(-100.33659)
        arrayOfOfLongitudes.append(-100.34071)
        arrayOfOfLongitudes.append(-100.34229)
        arrayOfOfLongitudes.append(-100.35023)
        arrayOfOfLongitudes.append(-100.29011)
        
        arrayOfNames.append("Pedro")
        arrayOfNames.append("Pablo")
        arrayOfNames.append("Juan")
        arrayOfNames.append("Aldo")
        arrayOfNames.append("Roerto")
        arrayOfNames.append("Alex")
        arrayOfNames.append("Ricardo")
        arrayOfNames.append("Andres")
        arrayOfNames.append("Sergio")
        //
        
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "fireTimer:", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        titleLabel.text = sentText
        
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
        mapForRoute.delegate = self
        //---//
        //let spanX = 0.001
        //let spanY = 0.001
        
        // Create a region using the user's location, and the zoo.
        //var newRegion = MKCoordinateRegion(center: mapForRoute.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        // set the map to the new region
        //mapForRoute.setRegion(newRegion, animated: false)

        mapForRoute.showsUserLocation = true
        
        mapForRoute.showsBuildings = true
        
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

        print(printTimestamp())
        
        //print(arrayOfNames.removeFirst())
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        //mapForRoute.addGestureRecognizer(longPress)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func printTimestamp() -> String {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        print(timestamp)
        
        return timestamp
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapForRoute)
        var newCoord:CLLocationCoordinate2D = mapForRoute.convertPoint(touchPoint, toCoordinateFromView: self.mapForRoute)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "New Location"
        newAnotation.subtitle = "New Subtitle"
        mapForRoute.addAnnotation(newAnotation)
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       
        mapForRoute.showsUserLocation = (status == .AuthorizedAlways)
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapForRoute.setRegion(coordinateRegion, animated: true)
    }

    func fireTimer(timer: NSTimer) {
       
        
        if !arrayOfNames.isEmpty && !arrayOfOfLongitudes.isEmpty && !arrayOfLatitudes.isEmpty {
            
            let locationForPin: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: arrayOfLatitudes[0], longitude: arrayOfOfLongitudes[0])
            
            var anotation = MKPointAnnotation()
            anotation.coordinate = locationForPin
            anotation.title = "Conductor \(arrayOfNames[0])"
            timeStamp = printTimestamp()
            anotation.subtitle = "LLego en \(timeStamp)"
            mapForRoute.addAnnotation(anotation)
            
            var name = arrayOfNames.removeFirst()
            
            arrayDeLlegadas.append("\(name) llegada \(timeStamp)")
            
            let alert: UIAlertController = UIAlertController(title: "Llegada", message: "Conductor \(name) ha llegado a su destino en \(timeStamp).", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            let locationOfDrop: CLLocation = CLLocation(latitude: arrayOfLatitudes.removeFirst(), longitude: arrayOfOfLongitudes.removeFirst())
            centerMapOnLocation(locationOfDrop)
            
            driversTableView.reloadData()
            
            //
            //cell.textLabel?.text = "\(arrayOfNames[0]) \(timeStamp)"
            
            
        }
        //print("x")
    }
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDeLlegadas.count
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Conductores"
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("DriversDoneCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(arrayDeLlegadas[indexPath.row])"
        //print("\(arrayOfNames[indexPath.row])")
            
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Locations
    
    /*place    lat      long
    
    fundidora 25.67802	-100.28792
    finsol    25.67586	-100.30539
    La purisima 25.66967	-100.32534
    Centro Convex 25.66472	-100.33032
    Deportivo  25.65133	-100.33659
    Hospital 25.66994	-100.34071
    Obispado 25.67330	-100.34229
    H. Uni.  25.68878	-100.35023
    Tec      25.64815	-100.29011

    
    */

    @IBAction func salirTapped(sender: UIButton) {
        
        locationManager.stopUpdatingLocation()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

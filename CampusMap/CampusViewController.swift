//
//  CampusViewController.swift
//  CampusMap
//
//  Created by Chun on 2018/11/26.
//  Copyright © 2018 Nemoworks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CampusViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var myLocation: CLLocation?
    
    var campus = Campus(filename: "Campus")
    var selectedOptions : [MapOptionsType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置权限
        if (CLLocationManager.authorizationStatus() == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        // 开启定位服务
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        // 精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 显示用户小蓝点
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        // 范围
        let latDelta = campus.overlayTopLeftCoordinate.latitude - campus.overlayBottomRightCoordinate.latitude
        let span = MKCoordinateSpan.init(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion.init(center: campus.midCoordinate, span: span)
        mapView.region = region
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? MapOptionsViewController)?.selectedOptions = selectedOptions
    }
    
    
    // MARK: Helper methods
    func loadSelectedOptions() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)

        for option in selectedOptions {
            switch (option) {
            //case .mapPOIs:
            //    self.addPOIs()
            case .mapBoundary:
                self.addBoundary()
            case .mapPOICanteen: // "餐厅"
                self.addPOIs(poiType: .canteen)
            case .mapPOISchoolBuilding: // "教学楼/系楼"
                self.addPOIs(poiType: .schoolBuilding)
            case .mapPOILibrary: // "图书馆"
                self.addPOIs(poiType: .library)
            case .mapPOIDormitory: // "宿舍"
                self.addPOIs(poiType: .dormitory)
            case .mapPOIShop: // "超市"
                self.addPOIs(poiType: .shop)
            case .mapPOIHospital: // "医院"
                self.addPOIs(poiType: .hospital)
            case .mapPOISport: // "运动场/体育馆"
                self.addPOIs(poiType: .sport)
            case .mapPOIDelivery: // "快递点"
                self.addPOIs(poiType: .delivery)
            case .mapPOIBank: // "银行"
                self.addPOIs(poiType: .bank)
            case .mapPOITheatre: // "剧场"
                self.addPOIs(poiType: .theatre)
            case .mapPOICoffee: // "咖啡厅"
                self.addPOIs(poiType: .coffee)
            case .mapPOIPrint: // "打印店"
                self.addPOIs(poiType: .print)
            case .mapPOIMountain: // "山丘"
                self.addPOIs(poiType: .mountain)
            }
        }
    }
    
    @IBAction func closeOptions(_ exitSegue: UIStoryboardSegue) {
        guard let vc = exitSegue.source as? MapOptionsViewController else { return }
        selectedOptions = vc.selectedOptions
        loadSelectedOptions()
    }
    
    
    //    func addOverlay() {
    //        let overlay = ParkMapOverlay(park: park)
    //        mapView.addOverlay(overlay)
    //    }
    //
    
    func addBoundary() {
        mapView.addOverlay(MKPolygon(coordinates: campus.boundary, count: campus.boundary.count))
    }
    
    func addPOIs(poiType: POIType) {
        guard let pois = Campus.plist("CampusPOI") as? [[String : String]] else { return }
        
        for poi in pois {
            let coordinate = Campus.parseCoord(dict: poi, fieldName: "location")
            let title = poi["name"] ?? ""
            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
            let type = POIType(rawValue: typeRawValue) ?? .misc
            if (poiType == type) {
                let subtitle = poi["subtitle"] ?? ""
                let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
                mapView.addAnnotation(annotation)
            }
        }
    }
    func addPOICanteen() {
        
    }
    func addPOISchoolBuilding() {
        
    }
    func addPOILibrary() {
        
    }
    func addPOIDormitory() {
        
    }
    func addPOIShop() {
        
    }
    func addPOIHospital() {
        
    }
    func addPOISport() {
        
    }
    func addPOIDelivery() {
        
    }
    func addPOIBank() {
        
    }
    func addPOITheatre() {
        
    }
    func addPOICoffee() {
        
    }
    func addPOIPrint() {
        
    }
    func addPOIMountain() {
        
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
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


// MARK: - MKMapViewDelegate
extension CampusViewController: MKMapViewDelegate {
    // 每刷新用户位置
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        myLocation = userLocation.location
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.green
            return lineView
        } else if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.blue
            polygonView.lineWidth = CGFloat(3.0)
            return polygonView
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 由于当前位置也是annotation的一种，需要检测以防止其小蓝点标识被覆盖
        if annotation.coordinate.latitude == myLocation?.coordinate.latitude
        && annotation.coordinate.longitude == myLocation?.coordinate.longitude {
            return nil
        }
        let annotationView = POIAnnotationView(annotation: annotation, reuseIdentifier: "POI")
        annotationView.canShowCallout = true
        return annotationView
    }
}

extension CampusViewController: CLLocationManagerDelegate {
    // 位置改变时回调方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    // 方向改变时回调方法
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    }
}

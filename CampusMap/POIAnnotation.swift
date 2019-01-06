//
//  POIAnnotation.swift
//  CampusMap
//
//  Created by Chun on 2018/11/27.
//  Copyright © 2018 Nemoworks. All rights reserved.
//

import UIKit
import MapKit

enum POIType: Int {
    case misc = 0
    case canteen
    case schoolBuilding
    case library
    case dormitory
    case shop
    case hospital
    case sport
    case delivery
    case bank
    case theatre
    case coffee
    case print
    case mountain
    
    func image() -> UIImage {
        switch self {
        case .misc:
            return #imageLiteral(resourceName: "star")
        case .canteen:
            return #imageLiteral(resourceName: "1canteen")
        case .schoolBuilding:
            return #imageLiteral(resourceName: "2schoolBuilding")
        case .library:
            return #imageLiteral(resourceName: "3library")
        case .dormitory:
            return #imageLiteral(resourceName: "4dormitory")
        case .shop:
            return #imageLiteral(resourceName: "5shop")
        case .hospital:
            return #imageLiteral(resourceName: "6hospital")
        case .sport:
            return #imageLiteral(resourceName: "7sport")
        case .delivery:
            return #imageLiteral(resourceName: "8delivery")
        case .bank:
            return #imageLiteral(resourceName: "9bank")
        case .theatre:
            return #imageLiteral(resourceName: "10theatre")
        case .coffee:
            return #imageLiteral(resourceName: "11coffee")
        case .print:
            return #imageLiteral(resourceName: "12print")
        case .mountain:
            return #imageLiteral(resourceName: "13moutain")
        }
    }
}

class POIAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: POIType
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: POIType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

//
//  MapOptionsViewController.swift
//  CampusMap
//
//  Created by Chun on 2018/11/27.
//  Copyright © 2018 Nemoworks. All rights reserved.
//

import UIKit


enum MapOptionsType: Int {
    case mapBoundary = 0
    //case mapPOIs
    case mapPOICanteen
    case mapPOISchoolBuilding
    case mapPOILibrary
    case mapPOIDormitory
    case mapPOIShop
    case mapPOIHospital
    case mapPOISport
    case mapPOIDelivery
    case mapPOIBank
    case mapPOITheatre
    case mapPOICoffee
    case mapPOIPrint
    case mapPOIMountain
    
    func displayName() -> String {
        switch (self) {
        case .mapBoundary: return "校园边界"
        //case .mapPOIs: return "兴趣点"
        case .mapPOICanteen: return "餐厅"
        case .mapPOISchoolBuilding: return "教学楼/系楼"
        case .mapPOILibrary: return "图书馆"
        case .mapPOIDormitory: return "宿舍"
        case .mapPOIShop: return "超市"
        case .mapPOIHospital: return "医院"
        case .mapPOISport: return "运动场/体育馆"
        case .mapPOIDelivery: return "快递点"
        case .mapPOIBank: return "银行"
        case .mapPOITheatre: return "剧场"
        case .mapPOICoffee: return "咖啡厅"
        case .mapPOIPrint: return "打印店"
        case .mapPOIMountain: return "山丘"
        }
    }
}

class MapOptionsViewController: UIViewController {

    var selectedOptions = [MapOptionsType]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


// MARK: - UITableViewDataSource
extension MapOptionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell")!
        
        if let mapOptionsType = MapOptionsType(rawValue: indexPath.row) {
            cell.textLabel!.text = mapOptionsType.displayName()
            cell.accessoryType = selectedOptions.contains(mapOptionsType) ? .checkmark : .none
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MapOptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let mapOptionsType = MapOptionsType(rawValue: indexPath.row) else { return }
        
        if (cell.accessoryType == .checkmark) {
            // Remove option
            selectedOptions = selectedOptions.filter { $0 != mapOptionsType}
            cell.accessoryType = .none
        } else {
            // Add option
            selectedOptions += [mapOptionsType]
            cell.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  ViewController.swift
//  iBeaconTest
//
//  Created by Yu-J.Cheng on 2018/4/20.
//  Copyright © 2018年 YuChienCheng. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let uuidString = "替換這裡變成需要的"
    let identifier = "替換這裡變成需要的"

    @IBOutlet var statusLabel: UILabel!
    var locationManager: CLLocationManager!
    var myRegion: CLBeaconRegion!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        myRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: uuidString)!, identifier: identifier)
    }

}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            manager.startMonitoring(for: myRegion)
            manager.startRangingBeacons(in: myRegion)
        }


        for region in manager.monitoredRegions {
            print(manager.monitoredRegions.count)
            print(region)
        }
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {

        if (beacons.count > 0){
            if let nearstBeacon = beacons.first{
                print("proximityUUID: \(nearstBeacon.proximityUUID)")
                var proximity = ""

                switch nearstBeacon.proximity {
                case CLProximity.immediate:
                    proximity = "Very close"

                case CLProximity.near:
                    proximity = "Near"

                case CLProximity.far:
                    proximity = "Far"

                default:
                    proximity = "unknow"
                }

                statusLabel.text = "Proximity: \(proximity)\n Accuracy: \(nearstBeacon.accuracy) meter \n RSSI: \(nearstBeacon.rssi)"
                view.backgroundColor = UIColor.red
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }


    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }


    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print(error.localizedDescription)
    }

}

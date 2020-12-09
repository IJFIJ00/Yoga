//
//  TableViewController.swift
//  Yoga
//
//  Created by Дмитрий on 08.12.2020.
//

import UIKit
import WatchConnectivity

class TableViewController: UITableViewController, WCSessionDelegate {
    
    struct lissions {
        var name: String
        var time: TimeInterval
        var image: String
        
        static func getLessions() -> [lessions] {
            return [
                lessions(name: "Журавль", time: 15.0, image: "juravl"),
                lessions(name: "Лотус", time: 13.0, image: "lotus")
            ]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = lessions.getLessions()[indexPath.row].name
        let time = lessions.getLessions()[indexPath.row].time
        do {
            let message = ["name": name, "time": time] as [String : Any]
            try wcSession.updateApplicationContext(message)
        } catch {
            print(error.localizedDescription)
        }
        
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
        }
        
        var wcSession: WCSession! = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            wcSession = WCSession.default
            wcSession.delegate = self
            wcSession.activate()
            
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return lessions.getLessions().count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rowTable", for: indexPath) as! TableViewCell
            
            cell.picture.image = UIImage(named: lessions.getLessions()[indexPath.row].image)
            cell.title.text = lessions.getLessions()[indexPath.row].name
            
            return cell
        }
        
    }
    
}

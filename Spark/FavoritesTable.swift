//
//  FavoritesTable.swift
//  Spark
//
//  Created by Sunrose Billing on 2016-11-10.
//  Copyright © 2016 Sunrose. All rights reserved.
//

import Foundation
import UIKit

class FavoritesTable: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var TableView: UITableView!
    
    var data: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)),name:NSNotification.Name(rawValue: "load"), object: nil)
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "Favorites")
        
        let defaults = UserDefaults.standard
        if let list = defaults.array(forKey: "favorites") {
            data = NSMutableArray.init(array: list)
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.TableView.dequeueReusableCell(withIdentifier: "Favorites")!
        cell.textLabel?.text = String(describing: data[indexPath.row])
        cell.textLabel?.textColor = hexStringToUIColor(hex: "#5C8399")
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(deleteTapped))
        doubletap.numberOfTapsRequired = 2
        
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(doubletap)
        
        return cell
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func loadList(notification: NSNotification){
        let defaults = UserDefaults.standard
        if let list = defaults.array(forKey: "favorites") {
            data = NSMutableArray.init(array: list)
        }
        self.TableView.reloadData()
    }
    
    func deleteTapped(sender: UITapGestureRecognizer){
        let cell: UITableViewCell = sender.view as! UITableViewCell
        
        let indexPath: IndexPath = TableView.indexPath(for: cell)!
        print (data[indexPath.row])
        data.removeObject(at: indexPath.row)
        print (data)
        TableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        
        let defaults = UserDefaults.standard
        if var list = defaults.array(forKey: "favorites") {
            list.remove(at:findIndex(array: list as NSArray,item: (cell.textLabel?.text)!))
            defaults.set(list, forKey: "favorites")
        }
    }
    
    func findIndex(array: NSArray, item: String) -> Int {
        for i in 0..<array.count {
            if String(describing: array[i]) == item {
                return i
            }
        }
        return 0
    }
}

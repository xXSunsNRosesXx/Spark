//
//  MoreInfo.swift
//  Spark
//
//  Created by Ezra Kirsh on 2016-11-12.
//  Copyright © 2016 Sunrose. All rights reserved.
//

import Foundation
import UIKit

class MoreInfo: UITableViewController {
    
    @IBOutlet weak var header1: UILabel!
    @IBOutlet weak var header2: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    
    var option1 = ""
    var option2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        if let options = defaults.array(forKey: "currentInfo") {
            option1 = options[0] as! String
            option2 = (options[1] as! String).capitalized
            
            header1.text = option1
            header2.text = option2
            
            let path = Bundle.main.path(forResource: option1, ofType: "txt")
            let text = try? NSString(contentsOfFile: path! as String, encoding: String.Encoding.utf8.rawValue)
            
            var firstFeatures: NSMutableArray = []
            text?.enumerateLines({ (line, stop) -> () in
                firstFeatures.add(line)
            })
            
            let secondPath = Bundle.main.path(forResource: option1, ofType: "txt")
            let secondText = try? NSString(contentsOfFile: path! as String, encoding: String.Encoding.utf8.rawValue)
            
            var secondFeatures: NSMutableArray = []
            text?.enumerateLines({ (line, stop) -> () in
                secondFeatures.add(line)
            })
        }
    }
}

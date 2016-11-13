//
//  MoreInfo.swift
//  Spark
//
//  Created by Sunrose Billing and Ezra Kirsh.
//  Copyright © 2016 Sunrose Billing and Ezra Kirsh. All rights reserved.
//

import Foundation
import UIKit

class MoreInfo: UIViewController {
    
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
            
            let path = Bundle.main.path(forResource: "Vine", ofType: "txt")
            let text = try? NSString(contentsOfFile: path! as String, encoding: String.Encoding.utf8.rawValue)
            
            var firstFeatures: NSMutableArray = []
            text?.enumerateLines({ (line, stop) -> () in
                firstFeatures.add(line)
            })
            
            let secondPath = Bundle.main.path(forResource: "Pets", ofType: "txt")
            let secondText = try? NSString(contentsOfFile: secondPath! as String, encoding: String.Encoding.utf8.rawValue)
            
            var secondFeatures: NSMutableArray = []
            secondText?.enumerateLines({ (line, stop) -> () in
                secondFeatures.add(line)
            })
            
            label1.text = String(describing: firstFeatures[0])
            label2.text = String(describing: firstFeatures[1])
            label3.text = String(describing: firstFeatures[2])
            label4.text = String(describing: secondFeatures[0])
            label5.text = String(describing: secondFeatures[1])
            label6.text = String(describing: secondFeatures[2])
        }
    }
}

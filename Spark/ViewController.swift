//
//  ViewController.swift
//  Spark
//
//  Created by Sunrose Billing and Ezra Kirsh.
//  Copyright © 2016 Sunrose Billing and Ezra Kirsh. All rights reserved.
//  Github is cool.

import UIKit

class ViewController: UIViewController {

    var apps = ["Tinder", "Vine", "Twitter", "Uber", "Instagram", "Foursquare", "Spotify", "Travel app", "Craigslist", "Candy Crush", "Snapchat", "Videochat", "Camera App", "Periscope", "Soundcloud", "Netflix", "News app", "Yelp"]
    var ideas = ["pets", "streaming", "cooks", "students", "journalists", "accountants", "teachers", "janitors", "parents", "reading news", "pet owners", "teens", "artists", "children", "singers", "waiters", "collectors", "travellers", "bloggers", "doctors"]
    
    @IBOutlet weak var InspireMe: UIButton!
    
    @IBOutlet weak var ideaLabel: UILabel!
    
    @IBAction func favoritesClicked(_ sender: Any) {
        self.slideMenuController()?.openRight()
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        ideaLabel.text = apps[Int(arc4random() % 18)] + " for " + ideas[Int(arc4random() % 20)]

        ideaLabel.text = apps[Int(arc4random() % 18)] + " for " + ideas[Int(arc4random() % 20)]
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ideaLabel.text = apps[Int(arc4random() % 18)] + " for " + ideas[Int(arc4random() % 20)]

        ideaLabel.text = apps[Int(arc4random() % 18)] + " for " + ideas[Int(arc4random() % 20)]

        InspireMe.layer.cornerRadius = 20
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(tap))
        doubletap.numberOfTapsRequired = 2
        
        ideaLabel.isUserInteractionEnabled = true
        ideaLabel.addGestureRecognizer(doubletap)
    }
    
    func tap(){
        let defaults = UserDefaults.standard
        if var list = defaults.array(forKey: "favorites") {
            list.insert(ideaLabel.text, at: 0)
            print(list)
            defaults.set(list, forKey: "favorites")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        else{
            var backup = [ideaLabel.text]
            defaults.set(backup, forKey: "favorites")
        }
        self.slideMenuController()?.openRight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


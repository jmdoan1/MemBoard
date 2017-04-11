//
//  ViewController.swift
//  MemBoard
//
//  Created by Justin Doan on 4/9/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var `switch`: UISwitch!
    
    
    let defaults = UserDefaults(suiteName: "group.com.justindoan.MemBoard")!
    let defaultSavedWordsKey = "SAVED_WORDS"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = defaults.value(forKey: defaultSavedWordsKey)
        
        if list != nil {
            print(list as! [String])
        }
        
        let end = defaults.value(forKey: "end")
        
        if end != nil {
            let toEnd = end as! Bool
            if toEnd {
                self.switch.isOn = true
            }
        }
        
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if self.switch.isOn {
            defaults.set(true, forKey: "end")
        } else {
            defaults.set(false, forKey: "end")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


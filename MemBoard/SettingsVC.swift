//
//  SettingsVC.swift
//  MemBoard
//
//  Created by Justin Doan on 4/9/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit
import QuickTableViewController

class SettingsVC: UIViewController {
    
    @IBOutlet var `switch`: UISwitch!
    @IBOutlet var tvCustom: UITextView!
    
    let defaults = UserDefaults(suiteName: "group.com.justindoan.MemBoard")!
    let defaultSavedWordsKey = "SAVED_WORDS"
    
    var savedWords: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "BG1"))
        
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
        
        for view in self.view.subviews as [UIView] {
            if let label = view as? UILabel {
                label.textColor = UIColor.white
            } else if let button = view as? UIButton {
                button.setTitleColor(UIColor.white, for: .normal)
            } else if let textView = view as? UITextView {
                //textView.textColor = UIColor.white
                textView.layer.cornerRadius = 10
                if textView.tag == 1 {
                    textView.textColor = UIColor.white
                    textView.text = "MemBoard was created by Justin Doan\nwww.JustinDoan.com"
                }
            } else if let subView = view as? UIView {
                for sub in subView.subviews {
                    if let subLabel = sub as? UILabel {
                        subLabel.textColor = UIColor.white
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //pull saved strings from user defaults if they exist
        let words = defaults.value(forKey: defaultSavedWordsKey)
        
        if words != nil {
            savedWords = words as! [String]
        }
        
    }
    
    @IBAction func addText(_ sender: Any) {
        
        guard let addition = tvCustom.text else {
            return
        }
        
        let end = defaults.value(forKey: "end")
        
        if end != nil {
            let toEnd = end as! Bool
            if toEnd {
                //inserts text at end
                savedWords.append(addition)
            } else {
                //inserts text to top of list
                savedWords.insert(addition, at: 0)
            }
        } else {
            //inserts text to top of list
            savedWords.insert(addition, at: 0)
        }
        
        //save new array to user defaults
        defaults.set(savedWords, forKey: defaultSavedWordsKey)
        
        tvCustom.text = "Text successfully added!"
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


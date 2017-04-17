//
//  InstructionsVC.swift
//  MemBoard
//
//  Created by Justin Doan on 4/12/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "BG1"))
        
        textView.textColor = UIColor.white
        
        textView.text = "How to use MemBoard\n\n1. Go to Settings -> General -> Keyboard -> Keyboards -> Add New Keyboard -> select MemBoard\n\n2. Using the regular keyboard, whatever you want to add\n\n3. Switch to the MemBoard keyboard\n\n4. Press the \"+\" button\n\n5. Going forward, you can tap on the saved text to add it wherever you are typing\n\n6. Swipe left to delete\n\n7. Choose your keyboard settings in the app"
        
        textView.addConstraint(NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: view.frame.width - 20))
        
        textView.sizeToFit()
        
        scrollView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 8))
        
        scrollView.sizeToFit()
        
        textView.isUserInteractionEnabled = false
        
        for view in self.view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

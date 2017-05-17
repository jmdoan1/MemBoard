//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Justin Doan on 4/9/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDelegate , UITableViewDataSource {
    
    let defaults = UserDefaults(suiteName: "group.com.justindoan.MemBoard")!
    let defaultSavedWordsKey = "SAVED_WORDS"
    
    var savedWords: [String] = ["How to:", "1. Type with the regular keyboard", "2. Come back to MemBoard", "3. Hit \"+\"", "4. See that it is added to the list", "5. Tap the saved text", "6. See it added to the field", "7. Swipe left to delete", "8. Configure settings in the app"]
    var tableView: UITableView!
    
    var lastType: UIKeyboardType!

    //default button added when taget is added, commenting out but leaving for reference
    //@IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        
        //default button added when taget is added, commenting out but leaving for reference
        /*
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //pull saved strings from user defaults if they exist
        let words = defaults.value(forKey: defaultSavedWordsKey)
        
        if words != nil {
            savedWords = words as! [String]
        }
        
        let type = textDocumentProxy.keyboardType!
        
        if lastType == nil || lastType != type {
            setUp(type: type)
        }
        
        
        
    }
    
    func setUp(type: UIKeyboardType) {
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        if type == .numberPad || type == .decimalPad {
            let numbersView = UIView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 50))
            numbersView.backgroundColor = .gray
            
            let svMain = UIStackView(frame: numbersView.frame)
            svMain.axis = .vertical
            svMain.distribution = .fillEqually
            svMain.alignment = .fill
            svMain.spacing = 1
            
            var numbers = [["1","2","3"],["4","5","6"],["7","8","9"],[".","0",""]]
            
            if type == .numberPad {
                numbers[3][0] = ""
            }
            
            for arr in numbers {
                let newStackView = UIStackView()
                newStackView.axis = .horizontal
                newStackView.distribution = .fillEqually
                newStackView.alignment = .fill
                newStackView.spacing = 1
                
                for num in arr {
                    let newButton = UIButton()
                    newButton.setTitle(num, for: .normal)
                    if num != "" {
                        newButton.backgroundColor = UIColor.white
                    }
                    //newButton.setTitleColor(buttonTextColor, for: .normal)
                    //newButton.layer.cornerRadius = buttonCornerRadius
                    newButton.addTarget(self, action: #selector(KeyboardViewController.numberButton(sender:)), for: .touchUpInside)
                    
                    newStackView.addArrangedSubview(newButton)
                }
                
                svMain.addArrangedSubview(newStackView)
            }
            
            numbersView.addSubview(svMain)
            view.addSubview(numbersView)
            
        } else {
            //add tableview
            
            tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 55))
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.separatorStyle = .none
            
            self.view.addSubview(tableView)
        }
        
        //add additional view to bottom of keyboard
        let bottomView = UIView(frame: CGRect(x: 0, y: displayHeight - 50, width: displayWidth, height: 50))
        bottomView.backgroundColor = UIColor.white
        
        let stackViewMain = UIStackView(frame: CGRect(x: 5, y: 5, width: bottomView.frame.width - 10, height: bottomView.frame.height - 10))
        stackViewMain.axis = .horizontal
        stackViewMain.distribution = .fillEqually
        stackViewMain.alignment = .fill
        stackViewMain.spacing = 5
        
        let buttonBackgroundColor = UIColor.gray
        let buttonTextColor = UIColor.white
        let buttonCornerRadius = CGFloat(5)
        
        let btnNext = UIButton()
        btnNext.setTitle("\u{2328}", for: .normal)
        btnNext.backgroundColor = buttonBackgroundColor
        btnNext.setTitleColor(buttonTextColor, for: .normal)
        btnNext.layer.cornerRadius = buttonCornerRadius
        btnNext.addTarget(self, action: #selector(KeyboardViewController.nextKeyboard), for: .touchUpInside)
        //stackView.addArrangedSubview(btnNext)
        
        let btnAdd = UIButton()
        btnAdd.setTitle("+", for: .normal)
        btnAdd.backgroundColor = buttonBackgroundColor
        btnAdd.setTitleColor(buttonTextColor, for: .normal)
        btnAdd.layer.cornerRadius = buttonCornerRadius
        btnAdd.addTarget(self, action: #selector(KeyboardViewController.addString), for: .touchUpInside)
        
        let stackViewLeft = UIStackView(arrangedSubviews: [btnNext, btnAdd])
        stackViewLeft.axis = .horizontal
        stackViewLeft.distribution = .fillEqually
        stackViewLeft.alignment = .fill
        stackViewLeft.spacing = 5
        
        stackViewMain.addArrangedSubview(stackViewLeft)
        
        let btnSpace = UIButton()
        btnSpace.setTitle("space", for: .normal)
        btnSpace.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        btnSpace.backgroundColor = buttonBackgroundColor
        btnSpace.setTitleColor(buttonTextColor, for: .normal)
        btnSpace.layer.cornerRadius = buttonCornerRadius
        btnSpace.addTarget(self, action: #selector(KeyboardViewController.spaceBar), for: .touchUpInside)
        
        stackViewMain.addArrangedSubview(btnSpace)
        
        let btnDelete = UIButton()
        btnDelete.setTitle("⌫", for: .normal)
        btnDelete.backgroundColor = buttonBackgroundColor
        btnDelete.setTitleColor(buttonTextColor, for: .normal)
        btnDelete.layer.cornerRadius = buttonCornerRadius
        btnDelete.addTarget(self, action: #selector(KeyboardViewController.backSpace), for: .touchUpInside)
        
        let btnNewLine = UIButton()
        btnNewLine.setTitle("↵", for: .normal)
        btnNewLine.backgroundColor = buttonBackgroundColor
        btnNewLine.setTitleColor(buttonTextColor, for: .normal)
        btnNewLine.layer.cornerRadius = buttonCornerRadius
        btnNewLine.addTarget(self, action: #selector(KeyboardViewController.newLine), for: .touchUpInside)
        
        let stackViewRight = UIStackView(arrangedSubviews: [btnDelete, btnNewLine])
        stackViewRight.axis = .horizontal
        stackViewRight.distribution = .fillEqually
        stackViewRight.alignment = .fill
        stackViewRight.spacing = 5
        
        stackViewMain.addArrangedSubview(stackViewRight)
        
        
        bottomView.addSubview(stackViewMain)
        
        self.view.addSubview(bottomView)
    }
    
    func addString() {
        //pulls text already in textField
        let addition = textDocumentProxy.documentContextBeforeInput ?? ""
        
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
        
        tableView.reloadData()
    }
    
    func spaceBar() {
        textDocumentProxy.insertText(" ")
    }
    
    func newLine() {
        textDocumentProxy.insertText("\n")
    }
    
    func nextKeyboard() {
        //Switch to next keyboard
        self.advanceToNextInputMode()
    }
    
    func backSpace() {
        textDocumentProxy.deleteBackward()
    }
    
    func numberButton(sender: UIButton) {
        textDocumentProxy.insertText(sender.currentTitle!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(savedWords[indexPath.row])"
        cell.textLabel!.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //adds text from selected cell to the textField
        self.textDocumentProxy.insertText(savedWords[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //save new array to user defaults
            defaults.set(savedWords, forKey: defaultSavedWordsKey)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        let type = textDocumentProxy.keyboardType!
        
        if lastType == nil || lastType != type {
            setUp(type: type)
        }
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        
        //default button added when taget is added, commenting out but leaving for reference
        /*
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
        */
    }

}

//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Justin Doan on 4/9/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDelegate , UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    let defaultSavedWordsKey = "SAVED_WORDS"
    
    var savedWords: [String] = []
    var tableView: UITableView!

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
        
        
        //add tableview
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 55))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
        
        //add additional view to bottom of keyboard
        let bottomView = UIView(frame: CGRect(x: 0, y: displayHeight - 50, width: displayWidth, height: 50))
        bottomView.backgroundColor = UIColor.white
        
        let stackView = UIStackView(frame: CGRect(x: 5, y: 5, width: bottomView.frame.width - 10, height: bottomView.frame.height - 10))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        let btnNext = UIButton()
        btnNext.backgroundColor = UIColor.lightGray
        btnNext.setTitle("Next Keyboard", for: .normal)
        btnNext.addTarget(self, action: #selector(KeyboardViewController.nextKeyboard), for: .touchUpInside)
        stackView.addArrangedSubview(btnNext)
        
        let btnAdd = UIButton()
        btnAdd.setTitle("Add To List", for: .normal)
        btnAdd.backgroundColor = UIColor.lightGray
        btnAdd.addTarget(self, action: #selector(KeyboardViewController.addString), for: .touchUpInside)
        stackView.addArrangedSubview(btnAdd)
        
        bottomView.addSubview(stackView)
        
        self.view.addSubview(bottomView)
        
    }
    
    func addString() {
        //pulls text already in textField
        let addition = textDocumentProxy.documentContextBeforeInput ?? ""
        
        //inserts text to top of list
        savedWords.insert(addition, at: 0)
        
        //save new array to user defaults
        defaults.set(savedWords, forKey: defaultSavedWordsKey)
        
        tableView.reloadData()
    }
    
    func nextKeyboard() {
        //Switch to next keyboard
        self.advanceToNextInputMode()
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

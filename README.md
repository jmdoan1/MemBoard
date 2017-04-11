![alt tag](http://i.imgur.com/pQTWBEe.png)

# MemBoard

A custom iOS keyboard written in Swift 3.1

# How it works

1. Go to Settings -> General -> Keyboard -> Keyboards -> Add New Keyboard -> select MemBoard
2. Using the regular keyboard, add text to whatever textfield you have selected (or the iMessage field)
3. Switch to the MemBoard keyboard
4. Press "Add to list"
5. Going forward, you can tap on the saved text to add it wherever you are typing
6. Swipe left to delete
7. Choose your keyboard settings in the app

# How to communicate between the app target and the keyboard target

1. For each target, go to capabilities and turn on App groups
2. When you do it for the first target, add a new group called "group.com.company.app" - essentially just your current app identifier with "group." in front of it
3. When you do it for the second target, the group you created in step 2 will be available to select.
4. Instead of using UserDefaults.standard, use, UserDefaults(suiteName: "group.com.company.app")
5. Now both the app and the keyboard are saving data to and pulling data from the same place



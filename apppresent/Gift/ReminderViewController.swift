//
//  ReminderViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 04/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var everyMonthSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    static func create() -> ReminderViewController {
        return UIStoryboard(name: "Reminder", bundle: nil).instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
        
    }
    
    
    var user: UserData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        saveButton.addTarget(self, action: #selector(saveReminder), for: .touchUpInside)
    }
    
    @objc func saveReminder() {
        if everyMonthSwitch.isOn {
            addNotificationEveryMonth()
        }
    }
    
    func addNotificationEveryMonth() {
        //getting the notification trigger
        //it will be called after 5 seconds
        guard let dateRaw = user?.birthday else { return }
        let date = Date(dateString: dateRaw, format: "dd/MM/yyyy")
        // every month -> 1 mont, 2 mons before birthday -> notify that
        let dayOfBirth = date.day
        let monthOfBirth = date.month
        
        let today = Date()
        let thisMonth = today.month
        let thisDay = today.day
        
        
        for i in thisMonth ... monthOfBirth {
            // thismonth: 5 march
            // birthday month: 4 may
            // -> notify 2 time:
            
            if i < monthOfBirth {
                // mar => 3, notify after 3 secs
                // apr -> 4,  notify after 4 secs
                //guard let triggerDate = Date.dateFrom(year: today.year, month: i, day: dayOfBirth, hour: 8, minute: 30, second: 0) else { continue }

                let triggerDate = today.addingTimeInterval(Double(i * 5))
                saveNotifcation(on: triggerDate)
            } else if i == monthOfBirth && thisDay < dayOfBirth {
                let triggerDate = today.addingTimeInterval(Double(i * 5))
                saveNotifcation(on: triggerDate)
            }
            
            // thanks, can I use that logic to send a notification on their birthday as well so i == month and thisDay == day?
            // you can match 2 dates, no need use this. for instanc: today.day == birhtday.day &&
            
        }
        
    }
    
    func saveNotifcation(on date: Date) {
        //guard let name = user?.fullname else { return }
        let name = "Jack"
        let content = UNMutableNotificationContent()
        
        content.title = "Birthday Reminder"
        content.subtitle = "Your friend birthday \(name) is coming"
        content.body = "Prepare your gift"
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: String(date.timeIntervalSince1970), content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    

}

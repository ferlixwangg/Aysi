//
//  NotificationController.swift
//  Aysi
//
//  Created by Cason Kang on 26/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

//
//  NotificationController.swift
//  notificationTest
//
//  Created by Cason Kang on 14/08/18.
//  Copyright © 2018 Cason Kang. All rights reserved.
//

import Foundation
import UserNotifications
import AudioToolbox
import AVFoundation
import NotificationCenter

class NotificationController {
    
    var titleArr: [String] = []
    let contentArr: [String] = [
        "Minggu ke-1",
        "Minggu ke-2",
        "Minggu ke-3",
        "Minggu ke-4",
        "Bulan ke-2",
        "Bulan ke-3",
        "Bulan ke-4",
        "Bulan ke-5",
        "Bulan ke-6"
    ]
    var notifDate: [Date] = []
    
    func setContentNotifs(oriDay: Date, babyName: String){
        notifDate.removeAll()
        titleArr.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let date = formatter.string(from: oriDay)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: oriDay)
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: oriDay)
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let bDay = formatter.date(from: "\(year)/\(month)/\(date) 20:00")
        
        var counter = 7
        //        var counter = 5
        for i in 1...4 {
            var timeInterval1 = DateComponents()
            timeInterval1.day = counter
            timeInterval1.minute = 5
            let futureDate1 = Calendar.current.date(byAdding: timeInterval1, to: bDay!)
            notifDate.append(futureDate1!)
            titleArr.append("Minggu ke-\(i) \(babyName)")
            counter+=7
            //            counter+=5
        }
        
        for i in 2...6 {
            var timeInterval2 = DateComponents()
            timeInterval2.month = i
            //            timeInterval2.second = 15
            //            timeInterval2.minute = 3
            let futureDate2 = Calendar.current.date(byAdding: timeInterval2, to: bDay!)
            notifDate.append(futureDate2!)
            titleArr.append("Bulan ke-\(i) \(babyName)")
        }
        print(notifDate)
        //creating notifications
        for i in 0...8{
            mainNotification(cTitle: titleArr[i], cBody: contentArr[i], notifNum: i, notifTrigger: notifDate[i])
        }
    }
    //Remove chart notifications
    func removeChartNotifs() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["chartNotification"])
    }

    //Remove all content notifications
    func removeContentNotifs() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["contentNotif1", "contentNotif2", "contentNotif3", "contentNotif4", "contentNotif5", "contentNotif6", "contentNotif7", "contentNotif8", "contentNotif9"])
    }
    //Remove all call notifications on weekends
    func removeCallNotifsWeekends() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["callNotification1", "callNotification7"])
    }
    //Remove all call notifications on weekdays
    func removeVallNotifsWeekdays() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["callNotification2", "callNotification3", "callNotification4", "callNotification5", "callNotification6"])
    }
    
    
    //main notification for contents
    func mainNotification(cTitle: String, cBody: String, notifNum: Int, notifTrigger: Date){
        
        let content = UNMutableNotificationContent()
        
        content.title = cTitle
        content.body = cBody
        content.sound = UNNotificationSound.default()
        //Trigger
        let a = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .timeZone, .calendar], from: notifTrigger)
        print(a)
        let trigger = UNCalendarNotificationTrigger(dateMatching: a, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "contentNotif\(notifNum+1)", content: content, trigger: trigger)
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("contentNotif\(notifNum+1) failed")
            } else {
                print("contentNotif\(notifNum+1) Success")
            }
        }
    }
    
    //setting call notifications
    func setCallNotifications(days: [Int], hour: Int, minute: Int, year: Int, babyName: String) {
        for i in 0...days.count-1{
            repeatingCallNotification(at: createDate(weekday: days[i], hour: hour, minute: minute, year: year), babyName: babyName, day: days[i])
        }
    }
    
    func createDate(weekday: Int, hour: Int, minute: Int, year: Int)->Date{
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        components.year = year
        components.weekday = weekday // sunday = 1 ... saturday = 7
        components.weekdayOrdinal = 10
        components.timeZone = .current
        
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)!
    }
    
    //Schedule Notification with weekly bases identifier callNotificationX. X=The day the notification is scheduled (sunday = 1 ... saturday = 7)
    func repeatingCallNotification(at date: Date, babyName: String, day: Int) {
        
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Sudah telfon si belahan hati belum?"
        content.body = "Jangan lupa telfon istri anda. Beberapa menit waktu anda menanyakan keadaan istri bisa membantu dan membuat istri senang!"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "callNotification\(day)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("callNotification\(day) failed")
            } else {
                print("callNotification\(day) Success")
                print(triggerWeekly)
            }
        }
    }
    
    func repeatingChartNotification(at date: Date, babyName: String) {
        
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "fill chart"
        content.body = babyName
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "chartNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("chartNotification failed")
            } else {
                print("chartNotification Success")
                print(triggerWeekly)
            }
        }
    }
    
    func demoNotif(babyName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Bulan ke-3 \(babyName)"
        content.body = "\(babyName) sudah memasuki bulan ketiga! Ini hal-hal yang anda perlu tau!"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "notify-test"
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest.init(identifier: "demoNotif", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}



//
//  LocalNotificationService.swift
//  Navigation
//
//  Created by kubmakk on 4/11/25.
//

import Foundation
import UserNotifications

class LocalNotificationService {
    private let center = UNUserNotificationCenter.current()
    
    func registerForLatestUptadatesIfPossible() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) {[weak self] granted, error in
            if let error = error {
                print("Ошибка запроса уведомления \(error.localizedDescription)")
            }
            
            if granted {
                self?.scheduleDailyNotification()
            } else {
                print("Разрение отклонено")
            }
        }
        
        
    }
    private func scheduleDailyNotification(){
        let content = UNMutableNotificationContent()
        content.title = "VK"
        content.body = "Посмотрите последние обнолвения"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let identifier = "dailyLatestUpdates"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Уведомление не добавилось причина \(error.localizedDescription)")
            } else {
                print("Уведомление будет в указанное время")
            }
            
        }
    }
}

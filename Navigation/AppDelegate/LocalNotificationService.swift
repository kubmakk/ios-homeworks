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
    }
}

//
//  PlantViewModel.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
//View Model
//حطو نفس الداتا بس خلوها ببلش لازم ابحث كيف نسويها
import Foundation
import SwiftUI
import UserNotifications

@Observable //SwiftUI تراقب أي تغيير في بيانات هذا الكلاس وتحدث الواجهات تلقائياً بمجرد إضافة نبتة أو تعديلها
class PlantViewModel {
    var plants: [Plant] = []//تحفظ جميع النباتات الي يدخلها اليوزر
    var hasLaunchedBefore: Bool = false
    
    // 1. حساب عدد النباتات الي سقاها اليوم عشان يظهر بالبروقرس فيو
    var wateredCount: Int {
        plants.filter { $0.isWateredToday }.count
    }
    
    var totalPlantsCount: Int {
        plants.count
    }
    
    // 2. إضافة نبتة جديدة
    func addPlant(name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        let newPlant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
        
        // إذا كانت كل النباتات السابقة مكتملة وتم إضافة نبتة جديدة، هل تحذف القديمة وتبدأ من جديد؟
        if !plants.isEmpty && wateredCount == totalPlantsCount {
            plants.removeAll() // مسح القديم لتكون القائمة نظيفة وتبدأ بالنبتة الجديدة فقط
        }
        
        plants.append(newPlant)
        scheduleNotification(for: newPlant)
    }
    
    // 3. تعديل نبتة موجودة
    func updatePlant(_ plant: Plant, name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDays = wateringDays
            plants[index].waterAmount = waterAmount
        }
    }
    
    // 4. حذف نبتة
    func deletePlant(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }
    
    func deleteSpecificPlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
    
    // 5.  تغيير حالة السقي من ترو ل فولس والعكس
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWateredToday.toggle()
        }
    }
    
    // 6. Local Notifications
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant (\(plant.name)) 🌿"
        content.sound = .default
        
        // إشعار يتم تفعيله بعد 10 ثوانٍ كمثال تجريبي (أو يمكن ربطه بأيام السقي)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

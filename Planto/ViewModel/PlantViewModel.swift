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
    
//    // 4. حذف نبتة
//    func deletePlant(at offsets: IndexSet) {
//        plants.remove(atOffsets: offsets)
//    }
//    
//    func deleteSpecificPlant(_ plant: Plant) {
//        plants.removeAll { $0.id == plant.id }
//    }
//    
//    // 5.  تغيير حالة السقي من ترو ل فولس والعكس
//    func toggleWatered(for plant: Plant) {
//        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
//            plants[index].isWateredToday.toggle()
//        }
//    }
//    
//    func lightIcon(for lightType: String) -> String {
//            switch lightType {
//            case "Full Sun": return "sun.max"
//            case "Partial Sun": return "sun.haze"
//            case "Low Light": return "moon"
//            default: return "sun.max"
//            }
//        }
    // أضيفي هذه الدالة داخل PlantViewModel لإلغاء إشعار النبتة المحذوفة
    func cancelNotification(for plant: Plant) {
        let identifier = plant.id.uuidString
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("🗑️ Cancelled notification for plant: \(plant.name)")
    }

    // تعديل دوال الحذف لتستدعي إلغاء الإشعار:
    func deletePlant(at offsets: IndexSet) {
        for index in offsets {
            let plant = plants[index]
            cancelNotification(for: plant)
        }
        plants.remove(atOffsets: offsets)
    }

    func deleteSpecificPlant(_ plant: Plant) {
        cancelNotification(for: plant)
        plants.removeAll { $0.id == plant.id }
    }

    // دالة تبديل حالة السقي مع دعم الأنيميشن
    func toggleWatered(for plant: Plant) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants[index].isWateredToday.toggle()
            }
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

//    func scheduleNotification(for plant: Plant) {
//        let content = UNMutableNotificationContent()
//        content.title = "Planto 🌱"
//        content.body = "Hey! Let's water your plant \(plant.name)"
//        content.sound = .default
//        
//        // إشعار تجريبي بعد 10 ثوانٍ (يمكنك تغييره لاحقاً ليناسب أيام السقي)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//        
//        // استخدام معرف فريد خاص بالنبتة
//        let identifier = plant.id.uuidString
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("❌ Error scheduling notification: \(error.localizedDescription)")
//            } else {
//                print("✅ Successfully scheduled notification for plant: \(plant.name)")
//            }
//        }
//    }
    
    // دالة لتحويل نص أيام السقي إلى ثوانٍ للـ Notification Trigger
    func timeInterval(for wateringOption: String) -> TimeInterval {
        switch wateringOption {
        case "Every day":
            return 24 * 60 * 60       // ثواني يوم كامل (24 ساعة)
        case "Every 2 days":
            return 2 * 24 * 60 * 60   // يومين
        case "Every 3 days":
            return 3 * 24 * 60 * 60   // 3 أيام
        case "Once a week", "Every 7 days":
            return 7 * 24 * 60 * 60   // أسبوع
        case "Every 10 days":
            return 10 * 24 * 60 * 60  // 10 أيام
        case "Every 2 weeks":
            return 14 * 24 * 60 * 60  // أسبوعين
        default:
            return 24 * 60 * 60       // افتراضياً كل يوم لو صار خطأ بال النص
        }
    }
    
    func scheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto 🌱"
        content.body = "Hey! Let's water your plant \(plant.name)"
        content.sound = .default
         
        // حساب الفاصل الزمني بناءً على اختيار المستخدم
        let interval = timeInterval(for: plant.wateringDays)
         
        // استخدام التريغر مع تفعيل التكرار (repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
         
        let identifier = plant.id.uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
         
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Successfully scheduled repeating notification for plant: \(plant.name) every \(plant.wateringDays)")
            }
        }
    }
}

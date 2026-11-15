//
//  Plant.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
//هيكل البيانات - model
// كانوا مخلينها @state
//import Foundation
//
//struct Plant: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var room: String          // مثل: Bedroom, Kitchen, Living Room ...
//    var light: String         // مثل: Full Sun, Partial Sun, Low Light ...
//    var wateringDays: String  // مثل: Every day, Every 2 days ...
//    var waterAmount: String   // مثل: 20-50 ml, 50-100 ml ...
//    var isWateredToday: Bool = false // هل سُقيت اليوم أم لا (للتحقق من الـ Checkmark)
//}

import Foundation

// تعريف الـ Enums لضمان نمذجة بيانات صحيحة (Data Modeling)
enum LightType: String, Codable, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"
    
    var iconName: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.haze"
        case .lowLight: return "moon"
        }
    }
}

enum RoomType: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String        // نخليه String أو نقدر نربطه بـ RoomType
    var light: String       // نخليه String أو LightType حسب رغبتك، وبنخليه متوافق مع الفيو
    var wateringDays: String
    var waterAmount: String
    var isWateredToday: Bool = false
}

//
//  Plant.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
//هيكل البيانات - model
// كانوا مخلينها @state
import Foundation

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String          // مثل: Bedroom, Kitchen, Living Room ...
    var light: String         // مثل: Full Sun, Partial Sun, Low Light ...
    var wateringDays: String  // مثل: Every day, Every 2 days ...
    var waterAmount: String   // مثل: 20-50 ml, 50-100 ml ...
    var isWateredToday: Bool = false // هل سُقيت اليوم أم لا (للتحقق من الـ Checkmark)
}

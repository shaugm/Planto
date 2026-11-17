//
//  Plant.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
//Model

import Foundation

// Defines the available light conditions for plants.
enum LightType: String, Codable, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"
    // Returns the SF Symbol associated with each light condition.
    var iconName: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.haze"
        case .lowLight: return "moon"
        }
    }
}
// Defines the available locations where plants can be placed.
enum RoomType: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

// Defines the available watering frequencies.
enum WateringFrequency: String, Codable, CaseIterable {
    case everyDay = "Every day"
    case everyTwoDays = "Every 2 days"
    case everyThreeDays = "Every 3 days"
    case onceAWeek = "Once a week"
    case everyTenDays = "Every 10 days"
    case everyTwoWeeks = "Every 2 weeks"
    // Converts the selected watering frequency into seconds for notifications.
    var timeInterval: TimeInterval {
        switch self {
        case .everyDay: return 1 * 24 * 60 * 60
        case .everyTwoDays: return 2 * 24 * 60 * 60
        case .everyThreeDays: return 3 * 24 * 60 * 60
        case .onceAWeek: return 7 * 24 * 60 * 60
        case .everyTenDays: return 10 * 24 * 60 * 60
        case .everyTwoWeeks: return 14 * 24 * 60 * 60
        }
    }
}
// Represents a plant and its care information.
struct Plant: Identifiable, Codable {
    // Provides a unique identifier for each plant.
    var id = UUID()
    var name: String
    var room: RoomType
    var light: LightType
    var wateringDays: WateringFrequency
    var waterAmount: String
    // Stores the date when the plant was last watered.
    var lastWateredDate: Date?
    // Checks whether the plant has been watered today.
    var isWateredToday: Bool {
        guard let lastWateredDate else {
            return false
        }
        
        return Calendar.current.isDateInToday(lastWateredDate)
    }
    // Defines the keys used when encoding and decoding plant data.
//    enum CodingKeys: String, CodingKey {
//        case id, name, room, light
//        case wateringDays, waterAmount
//        case lastWateredDate, isWateredToday
//    }
    // Initializes a plant with the provided details.
    init(
        id: UUID = UUID(),
        name: String,
        room: RoomType,
        light: LightType,
        wateringDays: WateringFrequency,
        waterAmount: String,
        lastWateredDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.lastWateredDate = lastWateredDate
    }
//    // Decodes plant data and supports previously saved data formats.
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        id = try container.decode(UUID.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        room = try container.decode(RoomType.self, forKey: .room)
//        light = try container.decode(LightType.self, forKey: .light)
//        wateringDays = try container.decode(WateringFrequency.self, forKey: .wateringDays)
//        waterAmount = try container.decode(String.self, forKey: .waterAmount)
//        
//        if let date = try container.decodeIfPresent(Date.self, forKey: .lastWateredDate) {
//            lastWateredDate = date
//        } else {
//            let oldValue = try container.decodeIfPresent(Bool.self, forKey: .isWateredToday) ?? false
//            lastWateredDate = oldValue ? Date() : nil
//        }
//    }
//    // Encodes plant properties for persistent storage.
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(room, forKey: .room)
//        try container.encode(light, forKey: .light)
//        try container.encode(wateringDays, forKey: .wateringDays)
//        try container.encode(waterAmount, forKey: .waterAmount)
//        try container.encodeIfPresent(lastWateredDate, forKey: .lastWateredDate)
//    }
}

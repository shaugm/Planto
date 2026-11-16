//
//  PlantViewModel.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
// View Model
import Foundation
import SwiftUI
import UserNotifications

// Manages plant data and app-related operations using the MVVM pattern.
@Observable
class PlantViewModel {
    // UserDefaults key used to store saved plants.
    private let plantsKey = "savedPlants"
    // Loads saved plants when the ViewModel is initialized.
    init() {
        loadPlants()
    }
    // Stores all plants added by the user.
    var plants: [Plant] = []
    // Tracks whether the user has opened the app before.
    var hasLaunchedBefore: Bool = UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
        didSet {
            UserDefaults.standard.set(hasLaunchedBefore, forKey: "hasLaunchedBefore")
        }
    }
    // Tracks the current day to refresh daily plant statuses.
    var currentDay = Calendar.current.startOfDay(for: Date())
    // Refreshes the current day to update daily plant statuses.
    func refreshTodayStatus() {
        currentDay = Calendar.current.startOfDay(for: Date())
    }
    // Returns the number of plants watered today.
    var wateredCount: Int {
        plants.filter { $0.isWateredToday }.count
    }
    // Returns the total number of saved plants.
    var totalPlantsCount: Int {
        plants.count
    }
    // Saves the plant list to UserDefaults using JSON encoding.
    private func savePlants() {
        do {
            let encodedPlants = try JSONEncoder().encode(plants)
            UserDefaults.standard.set(encodedPlants, forKey: plantsKey)
            print("✅ Plants saved successfully")
        } catch {
            print("❌ Failed to save plants: \(error.localizedDescription)")
        }
    }
    // Loads the saved plant list from UserDefaults using JSON decoding.
    private func loadPlants() {
        guard let savedData = UserDefaults.standard.data(forKey: plantsKey) else {
            return
        }
        
        do {
            plants = try JSONDecoder().decode([Plant].self, from: savedData)
            print("✅ Plants loaded successfully")
        } catch {
            print("❌ Failed to load plants: \(error.localizedDescription)")
        }
    }
    // Creates and saves a new plant.
    // Clears completed plants when all existing plants have been watered.
    func addPlant(
        name: String,
        room: RoomType,
        light: LightType,
        wateringDays: WateringFrequency,
        waterAmount: String
    ){
        let newPlant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
        
        if !plants.isEmpty && wateredCount == totalPlantsCount {
            for plant in plants {
                cancelNotification(for: plant)
            }
            
            plants.removeAll()
        }
        plants.append(newPlant)
        savePlants()
    }
    
    // Updates the details of an existing plant.
    func updatePlant(
        _ plant: Plant,
        name: String,
        room: RoomType,
        light: LightType,
        wateringDays: WateringFrequency,
        waterAmount: String
    ){
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDays = wateringDays
            plants[index].waterAmount = waterAmount
            
            savePlants()
            
        }
    }
    
    // Adds a new plant or updates an existing one.
    func savePlant(
        _ plant: Plant?,
        name: String,
        room: RoomType,
        light: LightType,
        wateringDays: WateringFrequency,
        waterAmount: String
    ) {
        if let existingPlant = plant {
            updatePlant(
                existingPlant,
                name: name,
                room: room,
                light: light,
                wateringDays: wateringDays,
                waterAmount: waterAmount
            )
        } else {
            addPlant(
                name: name,
                room: room,
                light: light,
                wateringDays: wateringDays,
                waterAmount: waterAmount
            )
        }
    }
    // Removes pending and delivered notifications for a specific plant.
    func cancelNotification(for plant: Plant) {
        let identifier = plant.id.uuidString
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
        
        print("🗑️ Cancelled notification for plant: \(plant.name)")
    }
    
    // Deletes plants selected through the list's swipe-to-delete action.
    func deletePlant(at offsets: IndexSet) {
        for index in offsets {
            let plant = plants[index]
            cancelNotification(for: plant)
        }
        plants.remove(atOffsets: offsets)
        savePlants()
    }
    // Deletes a specific plant and cancels its notification.
    func deleteSpecificPlant(_ plant: Plant) {
        cancelNotification(for: plant)
        plants.removeAll { $0.id == plant.id }
        savePlants()
    }
    
    
    
    // Toggles a plant's watering status and updates its notification.
    func toggleWatered(for plant: Plant) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                
                if plants[index].isWateredToday {
                    plants[index].lastWateredDate = nil
                    scheduleNotification(for: plants[index])
                    
                } else {
                    plants[index].lastWateredDate = Date()
                    cancelNotification(for: plants[index])
                }
                
                savePlants()
                
                print("Last watered: \(plants[index].lastWateredDate ?? Date.distantPast)")
                print("Watered today: \(plants[index].isWateredToday)")
            }
        }
    }
    
    
    // Checks notification authorization and requests permission if needed.
    func checkNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                completion(true)
                
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                ) { granted, error in
                    if let error = error {
                        print("Notification permission error: \(error.localizedDescription)")
                    }
                    completion(granted)
                }
                
            case .denied:
                completion(false)
                
            @unknown default:
                completion(false)
            }
        }
    }
    
    
    // Schedules a repeating watering reminder based on the plant's watering frequency.
    func scheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto 🌱"
        content.body = "Hey! Let's water your plant \(plant.name)"
        content.sound = .default
        
        let interval = plant.wateringDays.timeInterval
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: interval,
            repeats: true
        )
        
        //        let interval: TimeInterval = 10
        //
        //        let trigger = UNTimeIntervalNotificationTrigger(
        //            timeInterval: interval,
        //            repeats: false
        //        )
        print("🌱 Plant: \(plant.name)")
        print("⏰ Watering frequency: \(plant.wateringDays.rawValue)")
        print("⏳ Notification interval: \(trigger.timeInterval)")
        
        let identifier = plant.id.uuidString
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        center.add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Successfully scheduled repeating notification for plant: \(plant.name)")
            }
        }
    }
    
}

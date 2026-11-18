//
//  AddEditPlantView.swift
//  Planto
//
//  Created by shaug alyahya on 29/05/1448 AH.
//
//  View
import SwiftUI
// Stores the values entered in the plant form.
struct PlantFormState {
    var name: String = ""
    var room: RoomType = .bedroom
    var light: LightType = .fullSun
    var wateringDays: WateringFrequency = .everyDay
    var waterAmount: String = "20-50 ml"
    
    // Initializes the form with default values or an existing plant's details.
    init(plant: Plant? = nil) {
        if let plant = plant {
            self.name = plant.name
            self.room = plant.room
            self.light = plant.light
            self.wateringDays = plant.wateringDays
            self.waterAmount = plant.waterAmount
        }
    }
}

struct AddEditPlantView: View {
    // Provides access to dismiss the current screen.
    @Environment(\.dismiss) var dismiss
    // Handles plant data and related operations.
    var viewModel: PlantViewModel
    // Stores the plant being edited, or nil when adding a new plant.
    var plantToEdit: Plant?
    
    // Holds the current values entered in the form.
    @State private var formState: PlantFormState
    // Controls the display of the plant name validation message.
    @State private var showNameError = false
    // Defines the available watering amounts.
    private let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    // Initializes the view and loads existing plant details when editing.
    init(viewModel: PlantViewModel, plantToEdit: Plant?) {
        self.viewModel = viewModel
        self.plantToEdit = plantToEdit
        _formState = State(initialValue: PlantFormState(plant: plantToEdit))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                VStack(spacing: 24) {
                    // Plant Name Card
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        TextField("", text: $formState.name, prompt: Text("Pothos").foregroundColor(.gray))
                            .foregroundColor(.white)
                            .tint(Color("plantoGreen"))
                            .multilineTextAlignment(.leading)
                            .onChange(of: formState.name) {
                                if !formState.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    showNameError = false
                                }
                            }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    if showNameError {
                        Text("Please enter a plant name.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal, 20)
                    }
                    // Pickers Card (Room & Light)
                    VStack(spacing: 0) {
                        // Room Picker
                        HStack {
                            Label("Room", systemImage: "paperplane")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Room", selection: $formState.room) {
                                ForEach(RoomType.allCases, id: \.self) { room in
                                    Text(room.rawValue).tag(room)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal)
                        
                        // Light Picker
                        HStack {
                            Label("Light", systemImage: "sun.max")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Light", selection: $formState.light) {
                                ForEach(LightType.allCases, id: \.self) { light in
                                    Text(light.rawValue).tag(light)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // Pickers Card (Watering Days & Amount)
                    VStack(spacing: 0) {
                        // Watering Days Picker
                        HStack {
                            Label("Watering Days", systemImage: "drop")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Watering Days", selection: $formState.wateringDays) {
                                ForEach(WateringFrequency.allCases, id: \.self) { frequency in
                                    Text(frequency.rawValue).tag(frequency)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal)
                        
                        // Water Amount Picker
                        HStack {
                            Label("Water", systemImage: "drop")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Water", selection: $formState.waterAmount) {
                                ForEach(waterAmounts, id: \.self) { Text($0).tag($0) }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // Shows the Delete Reminder button only when editing an existing plant.
                    if plantToEdit != nil {
                        // Deletes the selected plant and dismisses the form.
                        Button(action: {
                            if let plant = plantToEdit {
                                viewModel.deleteSpecificPlant(plant)
                                dismiss()
                            }
                        }) {
                            Text("Delete Reminder")
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(26)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                    }
                    
                    
                    Spacer()
                }
                .padding(.top)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    // Dismisses the form without saving changes.
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(plantToEdit == nil ? "Set Reminder" : "Edit Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Validates and saves the plant, then handles its watering notification.
                    Button(action: {
                        
                        let trimmedName = formState.name.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        
                        guard !trimmedName.isEmpty else {
                            showNameError = true
                            return
                        }
                        
                        let savedPlant = plantToEdit
                        let savedName = trimmedName
                        let savedRoom = formState.room
                        let savedLight = formState.light
                        let savedFrequency = formState.wateringDays
                        let savedAmount = formState.waterAmount
                        
                        // Saves the plant details before handling notification scheduling.
                        viewModel.savePlant(
                            savedPlant,
                            name: savedName,
                            room: savedRoom,
                            light: savedLight,
                            wateringDays: savedFrequency,
                            waterAmount: savedAmount,
                        )
                        
                        let savedPlantID = savedPlant?.id ?? viewModel.plants.last?.id
                        
                        dismiss()
                        
                        // Requests notification permission before scheduling a watering reminder.
                        viewModel.checkNotificationPermission { granted in
                            guard granted else { return }
                            
                            // Handles notification updates on the main thread.
                            DispatchQueue.main.async {
                                
                                if let savedPlantID,
                                   let plant = viewModel.plants.first(where: { $0.id == savedPlantID }) {
                                    // Cancels the reminder if the plant is already watered; otherwise, schedules it.
                                    if plant.isWateredToday {
                                        viewModel.cancelNotification(for: plant)
                                    } else {
                                        viewModel.scheduleNotification(for: plant)
                                    }
                                }
                            }
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("plantoGreen"))
                    .clipShape(Circle())
                    
                }
            }
        }
    }
}

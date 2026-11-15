////////
////////  AddEditPlantView.swift
////////  Planto
////////
////////  Created by shaug alyahya on 29/05/1448 AH.
////////
//
////view
//
//import SwiftUI
//
//struct AddEditPlantView: View {
//    @Environment(\.dismiss) var dismiss
//    var viewModel: PlantViewModel
//    var plantToEdit: Plant?
//
//    @State private var plantName: String = ""
//    @State private var selectedRoom: String = "Bedroom"
//    @State private var selectedLight: String = "Full Sun"
//    @State private var selectedWateringDays: String = "Every day"
//    @State private var selectedWaterAmount: String = "20-50 ml"
//
//    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
//    let lights = ["Full Sun", "Partial Sun", "Low Light"]
//    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
//    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
//
//    let customGreen = Color(red: 0.18, green: 0.55, blue: 0.34)
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color("sheetColor").ignoresSafeArea()
//
//                VStack(spacing: 20) {
//                    // Plant Name Card
//                    HStack {
//                        Text("Plant Name")
//                            .foregroundColor(.white)
//
//                        Spacer()
//
//                        TextField("Pothos", text: $plantName)
//                            .foregroundColor(.gray)
//                            .tint(Color("plantoGreen"))
//                            .multilineTextAlignment(.leading)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .background(Color(.systemGray6).opacity(0.12))
//                    .cornerRadius(30)
//                    .padding(.horizontal)
//
//                    VStack(spacing: 0) {
//                        // 1. Room Picker
//                        HStack {
//                            Label("Room", systemImage: "paperplane")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Room", selection: $selectedRoom) {
//                                ForEach(rooms, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(Color("dropdownText"))
//                        }
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//
//                        Divider()
//                            .background(Color.gray.opacity(0.3))
//                            .padding(.horizontal)
//
//                        // 2. Light Picker
//                        HStack {
//                            Label("Light", systemImage: "sun.max")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Light", selection: $selectedLight) {
//                                ForEach(lights, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(Color("dropdownText"))
//                        }
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//                    }
//                    .background(Color(.systemGray6).opacity(0.12))
//                    .cornerRadius(30)
//                    .padding(.horizontal)
//
//                    VStack(spacing: 0) {
//                        // Watering Days Picker
//                        HStack {
//                            Label("Watering Days", systemImage: "drop")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Watering Days", selection: $selectedWateringDays) {
//                                ForEach(wateringDaysOptions, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(Color("dropdownText"))
//                        }
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//
//                        Divider()
//                            .background(Color.gray.opacity(0.3))
//                            .padding(.horizontal)
//
//                        // Water Amount Picker
//                        HStack {
//                            Label("Water", systemImage: "drop.fill")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Water", selection: $selectedWaterAmount) {
//                                ForEach(waterAmounts, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(Color("dropdownText"))
//                        }
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//                    }
//                    .background(Color(.systemGray6).opacity(0.12))
//                    .cornerRadius(30)
//                    .padding(.horizontal)
//
//                    // زر حذف التذكير (في وضع التعديل)
//                    if plantToEdit != nil {
//                        Button(action: {
//                            if let plant = plantToEdit {
//                                viewModel.deleteSpecificPlant(plant)
//                                dismiss()
//                            }
//                        }) {
//                            Text("Delete Reminder")
//                                .foregroundColor(.red)
//                                .fontWeight(.semibold)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color(.systemGray6).opacity(0.15))
//                                .cornerRadius(26)
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, 10)
//                    }
//
//                    Spacer()
//                }
//                .padding(.top)
//            }
////            .navigationTitle("Set Reminder")
////            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                // زر الإلغاء (X)
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "xmark")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.white)
//                    }
//                }
//                ToolbarItem(placement: .principal) {
//                        Text("Set Reminder")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                    }
//                // زر الحفظ (✓)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        if !plantName.isEmpty {
//                            if let existingPlant = plantToEdit {
//                                viewModel.updatePlant(existingPlant, name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
//                            } else {
//                                viewModel.addPlant(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
//                            }
//                            dismiss()
//                        }
//                    }) {
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding(10)
//                            .background(plantName.isEmpty ? Color.gray.opacity(0.3) : Color("plantoGreen"))
//                            .clipShape(Circle())
//                    }
//                    .buttonStyle(.plain) // إلغاء أي ستايل افتراضي للنظام
//                }
//            }
//
//            .onAppear {
//                if let plant = plantToEdit {
//                    plantName = plant.name
//                    selectedRoom = plant.room
//                    selectedLight = plant.light
//                    selectedWateringDays = plant.wateringDays
//                    selectedWaterAmount = plant.waterAmount
//                }
//            }
//        }
//    }
//}
import SwiftUI

// نموذج يمثل حالة الفورم (مفصول عن الـ Model الأساسي)
struct PlantFormState {
    var name: String = ""
    var room: String = "Bedroom"
    var light: String = "Full Sun"
    var wateringDays: String = "Every day"
    var waterAmount: String = "20-50 ml"
    
    // مُنشئ لتعبئة الحقول تلقائياً في حال كنا نقوم بتعديل نبتة سابقة، أو تركها فارغة للإضافة
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
    @Environment(\.dismiss) var dismiss
    var viewModel: PlantViewModel
    var plantToEdit: Plant?
    
    // مصدر الحقيقة الواحد لحالة الحقول في هذه الشاشة
    @State private var formState: PlantFormState
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    // مُنشئ لاستقبال الـ ViewModel والنبتة المراد تعديلها (إن وجدت)
    init(viewModel: PlantViewModel, plantToEdit: Plant?) {
        self.viewModel = viewModel
        self.plantToEdit = plantToEdit
        // تهيئة الـ State بالاعتماد على بيانات النبتة الحالية
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
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // Pickers Card (Room & Light)
                    VStack(spacing: 0) {
                        // 1. Room Picker
                        HStack {
                            Label("Room", systemImage: "paperplane")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Room", selection: $formState.room) {
                                ForEach(rooms, id: \.self) { Text($0).tag($0) }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal)
                        
                        // 2. Light Picker
                        HStack {
                            Label("Light", systemImage: "sun.max")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Light", selection: $formState.light) {
                                ForEach(lights, id: \.self) { Text($0).tag($0) }
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
                                ForEach(wateringDaysOptions, id: \.self) { Text($0).tag($0) }
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
                    
                    // زر حذف التذكير (في وضع التعديل فقط)
                    if plantToEdit != nil {
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
                // زر الإلغاء (X)
                ToolbarItem(placement: .navigationBarLeading) {
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
                
                // زر الحفظ (✓)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !formState.name.isEmpty {
                            if let existingPlant = plantToEdit {
                                viewModel.updatePlant(
                                    existingPlant,
                                    name: formState.name,
                                    room: formState.room,
                                    light: formState.light,
                                    wateringDays: formState.wateringDays,
                                    waterAmount: formState.waterAmount
                                )
                            } else {
                                viewModel.addPlant(
                                    name: formState.name,
                                    room: formState.room,
                                    light: formState.light,
                                    wateringDays: formState.wateringDays,
                                    waterAmount: formState.waterAmount
                                )
                            }
                            dismiss()
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

//////
//////  AddEditPlantView.swift
//////  Planto
//////
//////  Created by shaug alyahya on 29/05/1448 AH.
//////
////
////import SwiftUI
////
////struct AddEditPlantView: View {
////    // بيئة للتحكم في إغلاق الشاشة (Sheet)
////    @Environment(\.dismiss) var dismiss
////    
////    // ربط الـ ViewModel
////    var viewModel: PlantViewModel
////    
////    // متغيرات حفظ المدخلات المؤقتة
////    @State private var plantName: String = ""
////    @State private var selectedRoom: String = "Bedroom"
////    @State private var selectedLight: String = "Full Sun"
////    @State private var selectedWateringDays: String = "Every day"
////    @State private var selectedWaterAmount: String = "20-50 ml"
////    
////    // الخيارات المذكورة في لوحة المحتوى (The Content)
////    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
////    let lights = ["Full Sun", "Partial Sun", "Low Light"]
////    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
////    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
////
////    var body: some View {
////        NavigationStack {
////            ZStack {
////                // الثيم الداكن للخلفية
////                Color.black.ignoresSafeArea()
////                
////                VStack(spacing: 20) {
////                    
////                    // 1. حقل إدخال اسم النبتة (TextField)
////                    TextField("Plant Name (e.g. Pothos)", text: $plantName)
////                        .padding()
////                        .background(Color(.systemGray6).opacity(0.2))
////                        .foregroundColor(.white)
////                        .cornerRadius(12)
////                        .padding(.horizontal)
////                    
////                    // 2. مجموعات الخيارات (Pickers) المطابقة لـ The Content
////                    VStack(spacing: 12) {
////                        
////                        // اختيار الغرفة
////                        HStack {
////                            Label("Room", systemImage: "paperplane")
////                                .foregroundColor(.white)
////                            Spacer()
////                            Picker("Room", selection: $selectedRoom) {
////                                ForEach(rooms, id: \.self) { room in
////                                    Text(room).tag(room)
////                                }
////                            }
////                            .pickerStyle(.menu)
////                            .tint(.green)
////                        }
////                        .padding()
////                        .background(Color(.systemGray6).opacity(0.15))
////                        .cornerRadius(12)
////                        
////                        // اختيار الإضاءة
////                        HStack {
////                            Label("Light", systemImage: "sun.max")
////                                .foregroundColor(.white)
////                            Spacer()
////                            Picker("Light", selection: $selectedLight) {
////                                ForEach(lights, id: \.self) { light in
////                                    Text(light).tag(light)
////                                }
////                            }
////                            .pickerStyle(.menu)
////                            .tint(.green)
////                        }
////                        .padding()
////                        .background(Color(.systemGray6).opacity(0.15))
////                        .cornerRadius(12)
////                        
////                        // اختيار أيام السقي
////                        HStack {
////                            Label("Watering Days", systemImage: "drop")
////                                .foregroundColor(.white)
////                            Spacer()
////                            Picker("Watering Days", selection: $selectedWateringDays) {
////                                ForEach(wateringDaysOptions, id: \.self) { day in
////                                    Text(day).tag(day)
////                                }
////                            }
////                            .pickerStyle(.menu)
////                            .tint(.green)
////                        }
////                        .padding()
////                        .background(Color(.systemGray6).opacity(0.15))
////                        .cornerRadius(12)
////                        
////                        // اختيار كمية الماء
////                        HStack {
////                            Label("Water", systemImage: "drop.fill")
////                                .foregroundColor(.white)
////                            Spacer()
////                            Picker("Water", selection: $selectedWaterAmount) {
////                                ForEach(waterAmounts, id: \.self) { amount in
////                                    Text(amount).tag(amount)
////                                }
////                            }
////                            .pickerStyle(.menu)
////                            .tint(.green)
////                        }
////                        .padding()
////                        .background(Color(.systemGray6).opacity(0.15))
////                        .cornerRadius(12)
////                    }
////                    .padding(.horizontal)
////                    
////                    Spacer()
////                }
////                .padding(.top)
////            }
////            .navigationTitle("Set Reminder")
////            .navigationBarTitleDisplayMode(.inline)
////            .toolbar {
////                // زر الإغلاق (X) اليسار
////                ToolbarItem(placement: .navigationBarLeading) {
////                    Button(action: {
////                        dismiss()
////                    }) {
////                        Image(systemName: "xmark")
////                            .foregroundColor(.white)
////                            .padding(8)
////                            .background(Color.gray.opacity(0.3))
////                            .clipShape(Circle())
////                    }
////                }
////                
////                // زر الحفظ (✓) اليمين
////                ToolbarItem(placement: .navigationBarTrailing) {
////                    Button(action: {
////                        if !plantName.isEmpty {
////                            // إضافة النبتة عبر الـ ViewModel
////                            viewModel.addPlant(
////                                name: plantName,
////                                room: selectedRoom,
////                                light: selectedLight,
////                                wateringDays: selectedWateringDays,
////                                waterAmount: selectedWaterAmount
////                            )
////                            dismiss() // إغلاق الشاشة بعد الحفظ
////                        }
////                    }) {
////                        Image(systemName: "checkmark")
////                            .foregroundColor(.white)
////                            .padding(8)
////                            .background(plantName.isEmpty ? Color.gray : Color.green)
////                            .clipShape(Circle())
////                    }
////                    .disabled(plantName.isEmpty) // منع الحفظ إذا كان الاسم فارغاً
////                }
////            }
////        }
////    }
////}
//import SwiftUI
//
//struct AddEditPlantView: View {
//    @Environment(\.dismiss) var dismiss
//    var viewModel: PlantViewModel
//    
//    // النبتة المراد تعديلها (إن وجدت)
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
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black.ignoresSafeArea()
//                
//                VStack(spacing: 20) {
//                    TextField("Plant Name (e.g. Pothos)", text: $plantName)
//                        .padding()
//                        .background(Color(.systemGray6).opacity(0.2))
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .padding(.horizontal)
//                    
//                    VStack(spacing: 12) {
//                        // Room Picker
//                        HStack {
//                            Label("Room", systemImage: "paperplane")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Room", selection: $selectedRoom) {
//                                ForEach(rooms, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(.green)
//                        }
//                        .padding().background(Color(.systemGray6).opacity(0.15)).cornerRadius(12)
//                        
//                        // Light Picker
//                        HStack {
//                            Label("Light", systemImage: "sun.max")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Light", selection: $selectedLight) {
//                                ForEach(lights, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(.green)
//                        }
//                        .padding().background(Color(.systemGray6).opacity(0.15)).cornerRadius(12)
//                        
//                        // Watering Days Picker
//                        HStack {
//                            Label("Watering Days", systemImage: "drop")
//                                .foregroundColor(.white)
//                            Spacer()
//                            Picker("Watering Days", selection: $selectedWateringDays) {
//                                ForEach(wateringDaysOptions, id: \.self) { Text($0).tag($0) }
//                            }
//                            .pickerStyle(.menu)
//                            .tint(.green)
//                        }
//                        .padding().background(Color(.systemGray6).opacity(0.15)).cornerRadius(12)
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
//                            .tint(.green)
//                        }
//                        .padding().background(Color(.systemGray6).opacity(0.15)).cornerRadius(12)
//                    }
//                    .padding(.horizontal)
//                    
//                    // زر حذف التذكير (يظهر فقط في حالة التعديل)[cite: 7]
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
//                                .background(Color(.systemGray6).opacity(0.2))
//                                .cornerRadius(12)
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, 10)
//                    }
//                    
//                    Spacer()
//                }
//                .padding(.top)
//            }
//            .navigationTitle("Set Reminder")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.white)
//                            .padding(8)
//                            .background(Color.gray.opacity(0.3))
//                            .clipShape(Circle())
//                    }
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        if !plantName.isEmpty {
//                            if let existingPlant = plantToEdit {
//                                // تحديث النبتة الحالية
//                                viewModel.updatePlant(existingPlant, name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
//                            } else {
//                                // إضافة نبتة جديدة
//                                viewModel.addPlant(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
//                            }
//                            dismiss()
//                        }
//                    }) {
//                        Image(systemName: "checkmark")
//                            .foregroundColor(.white)
//                            .padding(8)
//                            .background(plantName.isEmpty ? Color.gray : Color.green)
//                            .clipShape(Circle())
//                    }
//                    .disabled(plantName.isEmpty)
//                }
//            }
//            .onAppear {
//                // إذا كنا في وضع التعديل، نعبئ الحقول بالبيانات القديمة
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

//view

import SwiftUI

struct AddEditPlantView: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: PlantViewModel
    var plantToEdit: Plant?
    
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full Sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    let customGreen = Color(red: 0.18, green: 0.55, blue: 0.34)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("sheetColor").ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Plant Name Card
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        TextField("Pothos", text: $plantName)
                            .foregroundColor(.gray)
                            .tint(Color("plantoGreen"))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6).opacity(0.12))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        // 1. Room Picker
                        HStack {
                            Label("Room", systemImage: "paperplane")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Room", selection: $selectedRoom) {
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
                            Picker("Light", selection: $selectedLight) {
                                ForEach(lights, id: \.self) { Text($0).tag($0) }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .background(Color(.systemGray6).opacity(0.12))
                    .cornerRadius(30)
                    .padding(.horizontal)

                    VStack(spacing: 0) {
                        // Watering Days Picker
                        HStack {
                            Label("Watering Days", systemImage: "drop")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Watering Days", selection: $selectedWateringDays) {
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
                            Label("Water", systemImage: "drop.fill")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("Water", selection: $selectedWaterAmount) {
                                ForEach(waterAmounts, id: \.self) { Text($0).tag($0) }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("dropdownText"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .background(Color(.systemGray6).opacity(0.12))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // زر حذف التذكير (في وضع التعديل)
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
                                .background(Color(.systemGray6).opacity(0.15))
                                .cornerRadius(26)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
//            .navigationTitle("Set Reminder")
//            .navigationBarTitleDisplayMode(.inline)
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
                        Text("Set Reminder")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                // زر الحفظ (✓)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !plantName.isEmpty {
                            if let existingPlant = plantToEdit {
                                viewModel.updatePlant(existingPlant, name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
                            } else {
                                viewModel.addPlant(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount)
                            }
                            dismiss()
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(plantName.isEmpty ? Color.gray.opacity(0.3) : Color("plantoGreen"))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain) // إلغاء أي ستايل افتراضي للنظام
                }
            }
            
            .onAppear {
                if let plant = plantToEdit {
                    plantName = plant.name
                    selectedRoom = plant.room
                    selectedLight = plant.light
                    selectedWateringDays = plant.wateringDays
                    selectedWaterAmount = plant.waterAmount
                }
            }
        }
    }
}

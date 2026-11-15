//////
//////  ContentView.swift
//////  Planto
//////
//////  Created by shaug alyahya on 29/05/1448 AH.
//////
////
////import SwiftUI
////
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Hello, world!")
////        }
////        .padding()
////    }
////}
////
////#Preview {
////    ContentView()
////}
//import SwiftUI
//
//struct ContentView: View {
//    // ربط الواجهة للفيو مودل عشان اي تغيير في البيانات
//    @State private var viewModel = PlantViewModel()
//
//    // متغير للتحكم في إظهار شاشة إضافة نبتة جديدة
//    @State private var showingAddView = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black.ignoresSafeArea()
//
//                VStack(alignment: .leading, spacing: 20) {
//                    HStack {
//                        Text("My Plants 🌱")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//
//                    // 2. (Empty vs List vs All Done)
//                    if viewModel.plants.isEmpty {
//                        // (Empty State)
//                        Spacer()
//                        VStack(spacing: 20) {
//                            // استخدام تصميم الألوفيرا أو أي أيقونة معبرة؟؟؟؟؟
//                            Image(systemName: "leaf.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(.green)
//
//                            Text("Start your plant journey!")
//                                .font(.title2)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//
//                            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .multilineTextAlignment(.center)
//                                .padding(.horizontal, 40)
//
//                            // زر الانتقال لشاشة إضافة تذكير
//                            Button(action: {
//                                showingAddView = true
//                            }) {
//                                Text("Set Plant Reminder")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(Color.green.opacity(0.8))
//                                    .cornerRadius(25)
//                            }
//                            .padding(.horizontal, 40)
//                            .padding(.top, 20)
//                        }
//                        Spacer()
//
//                    } else if viewModel.wateredCount == viewModel.totalPlantsCount {
//                        // (All Done State)
//                        Spacer()
//                        VStack(spacing: 15) {
//                            Image(systemName: "party.popper.fill")
//                                .font(.system(size: 70))
//                                .foregroundColor(.green)
//
//                            Text("All Done! 🎉")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//
//                            Text("All Reminders Completed")
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity)
//                        Spacer()
//
//                    } else {
//                        //(List State)
//
//                        //(Progress Bar / Text)
//                        Text("\(viewModel.wateredCount) of your plants feel loved today ✨")
//                            .font(.subheadline)
//                            .foregroundColor(.green)
//                            .padding(.horizontal)
//
//                        // plants list
//                        List {
//                            ForEach(viewModel.plants) { plant in
//                                HStack {
//                                    Button(action: {
//                                        viewModel.toggleWatered(for: plant)
//                                    }) {
//                                        Image(systemName: plant.isWateredToday ? "checkmark.circle.fill" : "circle")
//                                            .font(.title2)
//                                            .foregroundColor(plant.isWateredToday ? .green : .gray)
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
//
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text("in \(plant.room)")
//                                            .font(.caption2)
//                                            .foregroundColor(.gray)
//
//                                        Text(plant.name)
//                                            .font(.headline)
//                                            .foregroundColor(.white)
//
//                                        HStack(spacing: 10) {
//                                            Label(plant.light, systemImage: "sun.max")
//                                                .font(.caption2)
//                                                .foregroundColor(.gray)
//
//                                            Label(plant.waterAmount, systemImage: "drop")
//                                                .font(.caption2)
//                                                .foregroundColor(.gray)
//                                        }
//                                    }
//                                    Spacer()
//                                }
//                                .padding(.vertical, 8)
//                                .listRowBackground(Color.black)
//                            }
//                            //(Swipe to Delete)
//                            .onDelete(perform: viewModel.deletePlant)
//                        }
//                        .listStyle(.plain)
//                    }
//                }
//
//                // add plant button
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            // طلب إذن الإشعارات عند فتح شاشة الإضافة لأول مرة
//                            viewModel.requestNotificationPermission()
//                            showingAddView = true
//                        }) {
//                            Image(systemName: "plus")
//                                .font(.title.bold())
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Color.green)
//                                .clipShape(Circle())
//                                .shadow(radius: 4)
//                        }
//                        .padding()
//                    }
//                }
//            }
//            .sheet(isPresented: $showingAddView) {
//                AddEditPlantView(viewModel: viewModel)
//                    .presentationDetents([.large])
//            }
//        }
//    }
//}
//
//view
// اضافت @stateobject عشان نقدر نتواصل ونستخدم الفيومودل
import SwiftUI

struct ContentView: View {
    @State private var viewModel = PlantViewModel()
    @State private var showingAddView = false
    
    // متغير يحدد إذا نعدل النبتة الحالية أو نضيف نبتة جديدة
    @State private var plantToEdit: Plant? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("My Plants 🌱")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                    }
                    
                    if viewModel.hasLaunchedBefore && viewModel.plants.isEmpty {
                        //1- No reminders set
                        Spacer()
                        VStack(spacing: 15) {
                            Text("No reminders set  yet..")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                        
                    } else if viewModel.plants.isEmpty {
                        //2- Start your plant journey
                        Spacer()
                        VStack(spacing: 20) {
                            Image("planto")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            
                            Text("Start your plant journey!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                            
//                            Button(action: {
//                                viewModel.hasLaunchedBefore = true // تجاوز الشاشة الترحيبية
//                                plantToEdit = nil
//                                viewModel.requestNotificationPermission()
//                                showingAddView = true
//                            }) {
//                                Text("Set Plant Reminder")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 50)
//                                    .padding(.vertical, 8)
//                                    .background(Color("plantoGreen"))
//                                    .cornerRadius(25)
//                            }
//                            .padding(.top, 10)
//                            Button(action: {
//                                viewModel.hasLaunchedBefore = true
//                                plantToEdit = nil
//                                viewModel.requestNotificationPermission()
//                                showingAddView = true
//                            }) {
//                                Text("Set Plant Reminder")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 40)
//                                    .padding(.vertical, 14)
//                                    .background(Color("plantoGreen").opacity(0.85)) // لون بلانتو الأخضر مع شفافية زجاجية خفيفة
//                                    .background(.ultraThinMaterial)                // تأثير الـ Liquid Glass من أبل
//                                    .environment(\.colorScheme, .dark)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 25)
//                                            .stroke(LinearGradient(colors: [.white.opacity(0.5), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1) // انعكاس الضوء على الحواف
//                                    )
//                                    .cornerRadius(25)
//                                    .shadow(color: Color("plantoGreen").opacity(0.3), radius: 10, x: 0, y: 5)
//                            }
                            Button(action: {
                                viewModel.hasLaunchedBefore = true
                                plantToEdit = nil
                                viewModel.requestNotificationPermission()
                                showingAddView = true
                            }) {
                                Text("Set Plant Reminder")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 9)
                            }
                            .background(Color("plantoGreen").opacity(0.8)) // دمج لونك الأخضر مع الشفافية
                            .background(.ultraThinMaterial)                // طبقة الزجاج السائل الخاصة بـ iOS 27
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.white.opacity(0.6), .white.opacity(0.1)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: Color("plantoGreen").opacity(0.4), radius: 10, x: 0, y: 5)
                            .padding(.top, 10)
                        }
                        Spacer(minLength: 20)
                        
                    } else if viewModel.wateredCount == viewModel.totalPlantsCount && viewModel.totalPlantsCount > 0 {
                        // 3- All Done
                        Spacer()
                        VStack(spacing: 20) {
                            Image("plantoDone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            
                            Text("All Done! 🎉")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("All Reminders Completed")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                        
                    } else {
                        //4- show the plant list and the progress view
                        VStack(spacing: 8) {
                            Text(viewModel.wateredCount == 0 ? "Your plants are waiting for a sip 💦" : "\(viewModel.wateredCount) of your plants feel loved today ✨")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            
                            //ProgressView
                            ProgressView(value: Double(viewModel.wateredCount), total: Double(viewModel.totalPlantsCount))
                                .tint(Color("plantoGreen"))
                                .background(Color.gray.opacity(0.3))
                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                .padding(.horizontal, 40).clipShape(Capsule())
                                .animation(.easeInOut, value: viewModel.wateredCount)
                        }
                        .padding(.vertical, 8)
                        
                        // قائمة النباتات
                        List {
                            ForEach(viewModel.plants) { plant in
                                HStack(alignment: .center, spacing: 15) {
                                    Button(action: {
                                        viewModel.toggleWatered(for: plant)
                                    }) {
                                        Image(systemName: plant.isWateredToday ? "checkmark.circle.fill" : "circle")
                                            .font(.title2)
                                            .foregroundColor(plant.isWateredToday ? Color("plantoMint") : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        HStack(spacing: 4) {
                                            Image(systemName: "paperplane")
                                                .font(.caption2)
                                            Text("in \(plant.room)")
                                                .font(.caption)
                                        }
                                        .foregroundColor(.gray)
                                        
                                        // اسم النبتة
                                        Text(plant.name)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        
                                        // كابسولات الإضاءة وكمية الماء
                                        HStack(spacing: 8) {
                                            // كابسولة الإضاءة
                                            HStack(spacing: 4) {
                                                Image(systemName: LightType(rawValue: plant.light)?.iconName ?? "sun.max")
                                                    Text(plant.light)
                                            }
                                            .font(.caption2)
                                            .foregroundColor(Color("lightChipText"))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color("lightChipText").opacity(0.15))
                                            .cornerRadius(8)
                                            
                                            // كابسولة الماء
                                            HStack(spacing: 4) {
                                                Image(systemName: "drop")
                                                Text(plant.waterAmount)
                                            }
                                            .font(.caption2)
                                            .foregroundColor(Color("waterChipText"))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color("waterChipText").opacity(0.15))
                                            .cornerRadius(8)
                                        }
                                    }
                                    .opacity(plant.isWateredToday ? 0.4 : 1.0)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    plantToEdit = plant
                                    showingAddView = true
                                }
                                .padding(.vertical, 8)
                                .listRowBackground(Color.clear)
                                
                            }
                            .onDelete(perform: viewModel.deletePlant)
                        }
                        .listStyle(.plain)
                    }
                }
                
                if viewModel.hasLaunchedBefore || !viewModel.plants.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                viewModel.hasLaunchedBefore = true
                                plantToEdit = nil
                                viewModel.requestNotificationPermission()
                                showingAddView = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                            }
                            .background(Color("plantoGreen").opacity(0.85))
                            .background(.ultraThinMaterial) // تأثير الزجاج السائل الدائري
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.white.opacity(0.7), .white.opacity(0.15)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            .padding()
                           
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddEditPlantView(viewModel: viewModel, plantToEdit: plantToEdit)
                    .presentationDetents([.large])
//                    .presentationBackground(Color("sheetColor"))
                    .presentationCornerRadius(30)
            }
        }.preferredColorScheme(.dark)
    }
    
}
#Preview {
    ContentView().preferredColorScheme(.dark)
}

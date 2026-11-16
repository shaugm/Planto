//////
//////  ContentView.swift
//////  Planto
//////
//////  Created by shaug alyahya on 29/05/1448 AH.
//////

//// View
import SwiftUI

struct ContentView: View {
    // Manages plant data and business logic through the ViewModel.
    @State private var viewModel = PlantViewModel()
    // Tracks the app's current lifecycle state.
    @Environment(\.scenePhase) private var scenePhase
    // Controls the presentation of the Add/Edit Plant screen.
    @State private var showingAddView = false
    // Controls the visibility of the All Done screen.
    @State private var hideAllDone = false
    // Stores existing plant IDs to detect newly added plants.
    @State private var plantIDsBeforeAdding: Set<UUID> = []
    // Holds the selected plant when editing, or nil when adding a new plant.
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
                    // Displays the empty reminder state when no reminders are available.
                    if (viewModel.hasLaunchedBefore && viewModel.plants.isEmpty) || hideAllDone {
                        Spacer()
                        VStack(spacing: 15) {
                            Text("No reminders set  yet..")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                        // Displays the welcome screen when the user has no plants yet.
                    } else if viewModel.plants.isEmpty {
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
                            
                            // Opens the Add Plant screen from the welcome view.
                            Button(action: {
                                viewModel.hasLaunchedBefore = true
                                plantToEdit = nil
                                showingAddView = true
                            }) {
                                Text("Set Plant Reminder")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 9)
                            }
                            
                            .glassEffect(
                                .regular
                                    .tint(Color("plantoGreen").opacity(0.65))
                                    .interactive(),
                                in: Capsule()
                            )
                            .padding(.top, 10)
                        }
                        Spacer(minLength: 20)
                        
                        // Displays the completion screen when all plants have been watered.
                    } else if viewModel.wateredCount == viewModel.totalPlantsCount &&
                                viewModel.totalPlantsCount > 0 &&
                                !hideAllDone {
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
                        
                        // Displays the plant list and daily watering progress.
                    } else {
                        VStack(spacing: 8) {
                            Text(viewModel.wateredCount == 0 ? "Your plants are waiting for a sip 💦" : "\(viewModel.wateredCount) of your plants feel loved today ✨")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Shows the daily watering progress.
                            ProgressView(value: Double(viewModel.wateredCount), total: Double(viewModel.totalPlantsCount))
                                .tint(Color("plantoGreen"))
                                .background(Color.gray.opacity(0.3))
                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                .padding(.horizontal, 40).clipShape(Capsule())
                                .animation(.easeInOut, value: viewModel.wateredCount)
                        }
                        .padding(.vertical, 8)
                        
                        // Displays all saved plants in a scrollable list.
                        List {
                            // Creates a row for each plant.
                            ForEach(viewModel.plants) { plant in
                                HStack(alignment: .center, spacing: 15) {
                                    // Toggles the watering status of the selected plant.
                                    Button(action: {
                                        viewModel.toggleWatered(for: plant)
                                    }) {
                                        Image(systemName: plant.isWateredToday ? "checkmark.circle.fill" : "circle")
                                            .font(.title2)
                                            .foregroundColor(plant.isWateredToday ? Color("plantoMint") : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    // Displays the plant's room, name, light condition, and water amount.
                                    VStack(alignment: .leading, spacing: 4) {
                                        // Displays the room where the plant is placed.
                                        HStack(spacing: 4) {
                                            Image(systemName: "paperplane")
                                                .font(.caption2)
                                            Text("in \(plant.room.rawValue)")
                                                .font(.caption)
                                        }
                                        .foregroundColor(.gray)
                                        
                                        // Plant Name
                                        Text(plant.name)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        
                                        // Displays the plant's light condition and watering amount.
                                        HStack(spacing: 8) {
                                            HStack(spacing: 4) {
                                                Image(systemName: plant.light.iconName)
                                                Text(" \(plant.light.rawValue)")
                                            }
                                            .font(.caption2)
                                            .foregroundColor(Color("lightChipText"))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color("lightChipText").opacity(0.15))
                                            .cornerRadius(8)
                                            
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
                                // Opens the selected plant in edit mode.
                                .onTapGesture {
                                    plantToEdit = plant
                                    showingAddView = true
                                }
                                .padding(.vertical, 8)
                                .listRowBackground(Color.clear)
                                
                            }
                            // Enables swipe-to-delete for plant rows.
                            .onDelete(perform: viewModel.deletePlant)
                        }
                        .listStyle(.plain)
                    }
                }.id(viewModel.currentDay)
                
                // Shows the floating Add button after the user starts using the app.
                if viewModel.hasLaunchedBefore || !viewModel.plants.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                viewModel.hasLaunchedBefore = true
                                plantToEdit = nil
                                if viewModel.wateredCount == viewModel.totalPlantsCount &&
                                    viewModel.totalPlantsCount > 0 {
                                    hideAllDone = true
                                }
                                // Records existing plants before opening the Add Plant screen.
                                plantIDsBeforeAdding = Set(viewModel.plants.map { $0.id })
                                showingAddView = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                            }
                            .glassEffect(
                                .regular
                                    .tint(Color("plantoGreen").opacity(0.65))
                                    .interactive(),
                                in: Circle()
                            )
                            
                            .padding()
                            
                        }
                    }
                    
                }
            }
            // Presents the Add/Edit Plant screen as a modal sheet.
            .sheet(
                isPresented: $showingAddView,
                onDismiss: {
                    // Checks whether a new plant was added before dismissing the sheet.
                    let newPlantWasAdded = viewModel.plants.contains {
                        !plantIDsBeforeAdding.contains($0.id)
                    }
                    // Hides the empty completion state when a new plant is added.
                    if newPlantWasAdded {
                        hideAllDone = false
                    }
                }
            ) {
                AddEditPlantView(viewModel: viewModel, plantToEdit: plantToEdit)
                    .presentationDetents([.large])
                    .presentationCornerRadius(30)
                
            }
            // Updates daily plant status when the app becomes active.
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    viewModel.refreshTodayStatus()
                    // Hides the All Done screen when all plants are watered.
                    if viewModel.totalPlantsCount > 0 &&
                        viewModel.wateredCount == viewModel.totalPlantsCount {
                        hideAllDone = true
                    }
                }
            }
        }.preferredColorScheme(.dark)
    }
    
}
#Preview {
    ContentView().preferredColorScheme(.dark)
}


import Foundation
import Combine
import SwiftUI

enum ExerciseCategory: Codable {
    case upper1
    case upper2
    case shoulders
    case legs
}

class SplitsViewModel: ObservableObject {
    @Published var upper1Exercises: [Exercise] = []
    @Published var upper2Exercises: [Exercise] = []
    @Published var shouldersExercises: [Exercise] = []
    @Published var legsExercises: [Exercise] = []

    
    func addExercise(_ exercise: Exercise, to category: ExerciseCategory) {
        switch category {
        case .upper1:
            upper1Exercises.append(exercise)
        case .upper2:
            upper2Exercises.append(exercise)
        case .shoulders:
            shouldersExercises.append(exercise)
        case .legs:
            legsExercises.append(exercise)
        }
    }
    
    func exercises(for category: ExerciseCategory) -> [Exercise] {
            switch category {
            case .upper1:
                return upper1Exercises
            case .upper2:
                return upper2Exercises
            case .shoulders:
                return shouldersExercises
            case .legs:
                return legsExercises
            }
        }
    
    func deleteExercise(at offsets: IndexSet, from category: ExerciseCategory) {
            switch category {
            case .upper1:
                upper1Exercises.remove(atOffsets: offsets)
            case .upper2:
                upper2Exercises.remove(atOffsets: offsets)
            case .shoulders:
                shouldersExercises.remove(atOffsets: offsets)
            case .legs:
                legsExercises.remove(atOffsets: offsets)
            }
        }
}

struct Upper1ListView: View {
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingAddExercisesView = false

    var body: some View {
        List {
            ForEach(splitsViewModel.upper1Exercises, id: \.id) { exercise in
                HStack {
                    Spacer() // Push content to center
                    ExerciseDetailView(exercise: exercise)
                        .multilineTextAlignment(.center)
                    Spacer() // Push content to center
                }
            }
            .onDelete { offsets in
                splitsViewModel.deleteExercise(at: offsets, from: .upper1)
            }
        }
        .navigationTitle("Upper 1 Exercises")
        .toolbar {
            Button("Add") {
                showingAddExercisesView = true
            }
        }
        .sheet(isPresented: $showingAddExercisesView) {
                    NavigationView {
                        AddExercisesView(isShowing: $showingAddExercisesView, category: .upper1)
                            .navigationTitle("Exercise Bank")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .environmentObject(splitsViewModel)
                    .environmentObject(viewModel)
                }
            }
        }





struct Upper2ListView: View {
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingAddExercisesView = false

    var body: some View {
        List {
            ForEach(splitsViewModel.exercises(for: .upper2), id: \.id) { exercise in
                HStack {
                    Spacer() // Push content to center
                    ExerciseDetailView(exercise: exercise)
                        .multilineTextAlignment(.center)
                    Spacer() // Push content to center
                }
            }
            .onDelete { offsets in
                splitsViewModel.deleteExercise(at: offsets, from: .upper2)
            }
        }
        .navigationTitle("Upper 2 Exercises")
        .toolbar {
            Button("Add") {
                showingAddExercisesView = true
            }
        }
        .sheet(isPresented: $showingAddExercisesView) {
            AddExercisesView(isShowing: $showingAddExercisesView, category: .upper2)
                .environmentObject(splitsViewModel)
                .environmentObject(viewModel)
        }
    }
}






struct ShouldersListView: View {
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingAddExercisesView = false

    var body: some View {
        List {
            ForEach(splitsViewModel.exercises(for: .shoulders), id: \.id) { exercise in
                HStack {
                    Spacer() // Push content to center
                    ExerciseDetailView(exercise: exercise)
                        .multilineTextAlignment(.center)
                    Spacer() // Push content to center
                }
            }
            .onDelete { offsets in
                splitsViewModel.deleteExercise(at: offsets, from: .shoulders)
            }
        }
        .navigationTitle("Shoulders Exercises")
        .toolbar {
            Button("Add") {
                showingAddExercisesView = true
            }
        }
        .sheet(isPresented: $showingAddExercisesView) {
            AddExercisesView(isShowing: $showingAddExercisesView, category: .shoulders)
                .environmentObject(splitsViewModel)
                .environmentObject(viewModel)
        }
    }
}





struct LegsListView: View {
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingAddExercisesView = false

    var body: some View {
        List {
            ForEach(splitsViewModel.exercises(for: .legs), id: \.id) { exercise in
                HStack {
                    Spacer() // Push content to center
                    ExerciseDetailView(exercise: exercise)
                        .multilineTextAlignment(.center)
                    Spacer() // Push content to center
                }
            }
            .onDelete { offsets in
                splitsViewModel.deleteExercise(at: offsets, from: .legs)
            }
        }
        .navigationTitle("Legs Exercises")
        .toolbar {
            Button("Add") {
                showingAddExercisesView = true
            }
        }
        .sheet(isPresented: $showingAddExercisesView) {
            AddExercisesView(isShowing: $showingAddExercisesView, category: .legs)
                .environmentObject(splitsViewModel)
                .environmentObject(viewModel)
        }
    }
}


//struct ExerciseSelectionView: View {
//    @EnvironmentObject var viewModel: ViewModel  // Assuming ViewModel contains all exercises
//    @EnvironmentObject var splitsViewModel: SplitsViewModel
//
//    var body: some View {
//        List(viewModel.exercises, id: \.id) { exercise in
//            Button(exercise.name) {
//                splitsViewModel.addExercise(exercise, to: .upper1)
//            }
//        }
//        .navigationTitle("Select Exercises")
//    }
//}


struct AddExercisesView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @Binding var isShowing: Bool
    var category: ExerciseCategory

    var body: some View {
        VStack {
            
            List(viewModel.exercises, id: \.id) { exercise in
                Button(action: {
                    splitsViewModel.addExercise(exercise, to: category)
                    isShowing = false
                }) {
                    Text(exercise.name)
                }
            }
            .navigationTitle("Exercise Bank")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Exercise Bank")
                                    .font(.largeTitle) // Adjust the font size here
                            }
                        }
            
            Spacer() 
            Spacer() // Add a Spacer here to push content up
        }
    }
}

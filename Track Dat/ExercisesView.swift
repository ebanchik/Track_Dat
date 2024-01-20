//
//  ExercisesView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/24/23.
//

import Foundation
import SwiftUI


struct ExerciseDetailView: View {
 let exercise: Exercise
 @EnvironmentObject var splitsViewModel: SplitsViewModel

    var body: some View {
    VStack {
     Text(exercise.name)
         .font(.title)
     Text("Sets: \(exercise.sets)")
     Text("Reps: \(exercise.reps)")
     Text("Break Time: \(exercise.break_t ?? "Default Value")")
     Text("Style: \(exercise.style)")
    }
    .padding()
    }
   }

struct Exercise: Hashable, Codable, Identifiable {
 let id: Int
 let name: String
 let sets: Int
 let reps: String
 let break_t: String?
 let style: String
 var category: ExerciseCategory?

 enum CodingKeys: String, CodingKey {
     case id
     case name
     case sets
     case reps
     case break_t
     case style
     case category
 }

 init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(Int.self, forKey: .id)
     name = try container.decode(String.self, forKey: .name)
     sets = try container.decode(Int.self, forKey: .sets)
     reps = try container.decode(String.self, forKey: .reps)
     break_t = try container.decodeIfPresent(String.self, forKey: .break_t)
     style = try container.decode(String.self, forKey: .style)
 }
  init(id: Int, name: String, sets: Int, reps: String, break_t: String?, style: String) {
          self.id = id
          self.name = name
          self.sets = sets
          self.reps = reps
          self.break_t = break_t
          self.style = style
      }
}


class ViewModel: ObservableObject {
   @Published var exercises: [Exercise] = []
   @Published var isLoading = false
   
   // Fetches exercises from the API
   func fetch() {
       isLoading = true
       guard let url = URL(string: "http://localhost:3000/exercises.json") else {
           print("Invalid URL")
           return
       }
       
       let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
           guard let data = data, error == nil else {
               print("Error fetching exercises: \(error?.localizedDescription ?? "Unknown error")")
               return
           }
           do {
               let exercises = try JSONDecoder().decode([Exercise].self, from: data)
               DispatchQueue.main.async {
                  self?.exercises = exercises
               }
           } catch {
               print("Failed to decode exercises: \(error)")
           }
       }
       
       task.resume()
       isLoading = false
   }
   
   // Adds an exercise to the local list (used after successfully adding to API)
   func addExercise(_ exercise: Exercise) {
       DispatchQueue.main.async {
           self.exercises.append(exercise)
       }
   }
   
   // Sends a new exercise to the Rails API and adds it to the local list upon success
    public func addExerciseToAPI(exercise: Exercise) {
     guard let url = URL(string: "http://localhost:3000/exercises") else {
         print("Invalid URL")
         return
     }

     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")

     do {
         let jsonData = try JSONEncoder().encode(exercise)
         request.httpBody = jsonData

         URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
             if let data = data {
                 if let newExercise = try? JSONDecoder().decode(Exercise.self, from: data) {
                    DispatchQueue.main.async {
                       // Update your UI or model accordingly
                       self?.fetch()
                       self?.addExercise(newExercise)
                    }
                 } else {
                    print("Invalid response from server")
                 }
             } else if let error = error {
                 print("HTTP Request Failed \(error)")
             }
         }.resume()
     } catch {
         print("Failed to encode exercise: \(error)")
     }
    }

    
    func removeExercise(_ exercise: Exercise) {
      // Remove the exercise from the local array
      if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
          exercises.remove(at: index)
      }
      
      // Send a DELETE request to the Rails API
      guard let url = URL(string: "http://localhost:3000/exercises/\(exercise.id)") else {
          return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "DELETE"
      
      let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if let error = error {
              print("Error: \(error)")
          } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
              print("Non-200 status code: \(response.statusCode)")
          } else {
              print("Successfully deleted exercise from database.")
          }
      }
      
      task.resume()
    }

}

//struct CategorySelectionView: View {
//    var exercise: Exercise
//    @EnvironmentObject var splitsViewModel: SplitsViewModel
//
//    var body: some View {
//        VStack {
//            Text("Select Category for \(exercise.name)")
//            Button("Upper 1") {
//                splitsViewModel.addExercise(exercise, to: .upper1)
//            }
//            Button("Upper 2") {
//                splitsViewModel.addExercise(exercise, to: .upper2)
//            }
//            Button("Shoulders") {
//                splitsViewModel.addExercise(exercise, to: .shoulders)
//            }
//            Button("Legs") {
//                splitsViewModel.addExercise(exercise, to: .legs)
//            }
//        }
//    }
//}


struct ExercisesListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var splitsViewModel: SplitsViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(viewModel.exercises, id: \.self) { exercise in
                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                Text(exercise.name).bold()
                            }
                            .padding(8)
                        }
                        .onDelete(perform: deleteExercises)
                    }
                    .navigationTitle("Exercises")
                    .onAppear {
                        viewModel.fetch()
                    }
                }
            }
        }
    }

    func deleteExercises(offsets: IndexSet) {
        offsets.forEach { index in
            let exercise = viewModel.exercises[index]
            viewModel.removeExercise(exercise)
        }
    }
}

    
struct AddExerciseView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var name: String = ""
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var breakTime: String = ""
    @State private var style: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Sets", text: $sets)
            TextField("Reps", text: $reps)
            TextField("Break Time", text: $breakTime)
            TextField("Style", text: $style)
            
            Button("Save") {
                if let setsInt = Int(sets) { // Attempt to convert the `sets` String to an Int
                    let exercise = Exercise(id: 0, name: name, sets: setsInt, reps: reps, break_t: breakTime, style: style)
                    viewModel.addExerciseToAPI(exercise: exercise)
                    
                    name = ""
                    sets = ""
                    reps = ""
                    breakTime = ""
                    style = ""
                    
                } else {
                    // Handle the error case where `sets` is not a valid integer
                    showingAlert = true
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Please enter a valid number for sets."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Add New Exercise")
    }
    
//    class ViewModel: ObservableObject {
//        // Your existing properties and methods...
//        
//        func addExercise(_ exercise: Exercise) {
//            let url = URL(string: "http://localhost:3000/exercises")! // Replace with your actual server URL
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            let body: [String: Any] = [
//                "id": exercise.id.uuidString,
//                "name": exercise.name,
//                "sets": exercise.sets,
//                "reps": exercise.reps,
//                "break_time": exercise.break_t!,
//                "style": exercise.style
//            ]
//            
//            let jsonData = try? JSONSerialization.data(withJSONObject: body)
//            request.httpBody = jsonData
//            
//            let task = URLSession.shared.dataTask(with: request) { _, _, _ in
//                // Handle the response here
//            }
//            
//            task.resume()
//        }
//    }
}
    


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
  let id: UUID
  let name: String
  let sets: Int
  let reps: String
  let break_t: String?
  let style: String

  enum CodingKeys: String, CodingKey {
      case id
      case name
      case sets
      case reps
      case break_t
      case style
  }

  init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
      name = try container.decode(String.self, forKey: .name)
      sets = try container.decode(Int.self, forKey: .sets)
      reps = try container.decode(String.self, forKey: .reps)
      break_t = try container.decodeIfPresent(String.self, forKey: .break_t)
      style = try container.decode(String.self, forKey: .style)
  }
   init(id: UUID, name: String, sets: Int, reps: String, break_t: String?, style: String) {
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
                  if let responseExercise = try? JSONDecoder().decode(Exercise.self, from: data) {
                      DispatchQueue.main.async {
                          // Update your UI or model accordingly
                          self?.fetch()
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
}

struct ExercisesListView: View {
   @EnvironmentObject var viewModel: ViewModel
   @State private var selectedExercise: Exercise? = nil
   @State private var showingDetail = false
   
   var body: some View {
       NavigationView {
           Group {
               if viewModel.isLoading {
                  ProgressView()
               } else {
                  List(viewModel.exercises, id: \.self) { exercise in
                      Button(action: {
                          self.selectedExercise = exercise
                          self.showingDetail = true
                      }) {
                          HStack {
                              Text(exercise.name)
                                 .bold()
                          }
                          .padding(8)
                      }
                  }
                  .navigationTitle("Exercises")
                  .onAppear {
                      if !ProcessInfo.processInfo.arguments.contains("-ui_testing") {
                          viewModel.fetch()
                      }
                  }
               }
           }
           .sheet(item: $selectedExercise) { exercise in
               ExerciseDetailView(exercise: exercise)
           }
           NavigationLink(destination: AddExerciseView().environmentObject(viewModel)) {
               Image(systemName: "plus")
                  .font(.largeTitle)
                  .padding()
           }
           .accentColor(.white)
           .background(Color.green)
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
                    let exercise = Exercise(id: UUID(), name: name, sets: setsInt, reps: reps, break_t: breakTime, style: style)
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
    


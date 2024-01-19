//
//  SplitsViewModel.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/26/23.
//

import Foundation
import Combine
import SwiftUI

    
public struct Upper1: Codable, Identifiable, Hashable {
    public var id = UUID()
    var name: String
    var sets: Int
    var reps: String
    var break_t: String?
    var style: String
    
    enum CodingKeys: String, CodingKey {
        case name, sets, reps, break_t, style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sets = try container.decode(Int.self, forKey: .sets)
        reps = try container.decode(String.self, forKey: .reps)
        break_t = try container.decode(String?.self, forKey: .break_t)
        style = try container.decode(String.self, forKey: .style)
    }
}
    
public struct Upper2: Codable, Identifiable, Hashable {
    public var id = UUID()
    var name: String
    var sets: Int
    var reps: String
    var break_t: String?
    var style: String
    
    enum CodingKeys: String, CodingKey {
        case name, sets, reps, break_t, style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sets = try container.decode(Int.self, forKey: .sets)
        reps = try container.decode(String.self, forKey: .reps)
        break_t = try container.decode(String?.self, forKey: .break_t)
        style = try container.decode(String.self, forKey: .style)
    }
}
    
public struct Legs: Codable, Identifiable, Hashable {
    public var id = UUID()
    var name: String
    var sets: Int
    var reps: String
    var break_t: String?
    var style: String
    
    enum CodingKeys: String, CodingKey {
        case name, sets, reps, break_t, style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sets = try container.decode(Int.self, forKey: .sets)
        reps = try container.decode(String.self, forKey: .reps)
        break_t = try container.decode(String?.self, forKey: .break_t)
        style = try container.decode(String.self, forKey: .style)
    }
}
        
public struct Shoulders: Codable, Identifiable, Hashable {
    public var id = UUID()
    var name: String
    var sets: Int
    var reps: String
    var break_t: String?
    var style: String
    
    enum CodingKeys: String, CodingKey {
        case name, sets, reps, break_t, style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sets = try container.decode(Int.self, forKey: .sets)
        reps = try container.decode(String.self, forKey: .reps)
        break_t = try container.decode(String?.self, forKey: .break_t)
        style = try container.decode(String.self, forKey: .style)
    }
}
            
                
public class SplitsViewModel: ObservableObject {
    @Published var upper1: [Upper1] = []
    @Published var upper2: [Upper2] = []
    @Published var legs: [Legs] = []
    @Published var shoulders: [Shoulders] = []
    @Published var isLoading = false
    
    func fetchUpper1() {
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/upper1.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Upper1].self, from: data)
                print(exercises)
                DispatchQueue.main.async {
                    self?.upper1 = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
    
    func fetchUpper2() {
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/upper2.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Upper2].self, from: data)
                print(exercises)
                DispatchQueue.main.async {
                    self?.upper2 = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
    
    func fetchShoulders() {
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/shoulder.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Shoulders].self, from: data)
                print(exercises)
                DispatchQueue.main.async {
                    self?.shoulders = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
    
    func fetchLegs() {
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/leg.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Legs].self, from: data)
                print(exercises)
                DispatchQueue.main.async {
                    self?.legs = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
    
    func deleteExercise(_ exercise: Upper1) {
       if let index = upper1.firstIndex(where: { $0.id == exercise.id }) {
           upper1.remove(at: index)
       }

       guard let url = URL(string: "http://localhost:3000/upper1/\(exercise.id.uuidString).json") else {
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

struct Upper1DetailView: View {
   let exercise: Upper1

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

struct Upper2DetailView: View {
   let exercise: Upper2

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

struct ShouldersDetailView: View {
   let exercise: Shoulders

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

struct LegsDetailView: View {
   let exercise: Legs

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

struct Upper1ListView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel

 public var body: some View {
   List(splitsViewModel.upper1) { upper1 in
       NavigationLink(destination: Upper1DetailView(exercise: upper1)) {
           Text(upper1.name)
       }
   }
   .navigationTitle("Upper 1")
   .onAppear {
       print("Fetching Upper1")
       splitsViewModel.fetchUpper1()
   }
   .onReceive(splitsViewModel.$upper1) { _ in
   }
 }
}


struct Upper2ListView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel

 public var body: some View {
   List(splitsViewModel.upper2) { upper2 in
       NavigationLink(destination: Upper2DetailView(exercise: upper2)) {
           Text(upper2.name)
       }
   }
   .navigationTitle("Upper 2")
   .onAppear {
       print("Fetching Upper2")
       splitsViewModel.fetchUpper2()
   }
   .onReceive(splitsViewModel.$upper2) { _ in
   }
 }
}

struct ShouldersListView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel

 public var body: some View {
   List(splitsViewModel.shoulders) { shoulders in
       NavigationLink(destination: ShouldersDetailView(exercise: shoulders)) {
           Text(shoulders.name)
       }
   }
   .navigationTitle("Shoulders")
   .onAppear {
       print("Fetching Shoulders")
       splitsViewModel.fetchShoulders()
   }
   .onReceive(splitsViewModel.$shoulders) { _ in
   }
 }
}

struct LegsListView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel

 public var body: some View {
   List(splitsViewModel.legs) { legs in
       NavigationLink(destination: LegsDetailView(exercise: legs)) {
           Text(legs.name)
       }
   }
   .navigationTitle("Legs")
   .onAppear {
       print("Fetching Legs")
       splitsViewModel.fetchLegs()
   }
   .onReceive(splitsViewModel.$legs) { _ in
   }
 }
}

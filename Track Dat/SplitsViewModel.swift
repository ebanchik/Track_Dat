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
 public var id = 0
 var name: String
 var sets: Int
 var reps: String
 var break_t: String?
 var style: String
 
 enum CodingKeys: String, CodingKey {
     case id, name, sets, reps, break_t, style
 }
 
 public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(Int.self, forKey: .id)
     name = try container.decode(String.self, forKey: .name)
     sets = try container.decode(Int.self, forKey: .sets)
     reps = try container.decode(String.self, forKey: .reps)
     break_t = try container.decode(String?.self, forKey: .break_t)
     style = try container.decode(String.self, forKey: .style)
 }
}

public struct Upper2: Codable, Identifiable, Hashable {
 public var id = 0
 var name: String
 var sets: Int
 var reps: String
 var break_t: String?
 var style: String
 
 enum CodingKeys: String, CodingKey {
     case id, name, sets, reps, break_t, style
 }
 
 public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(Int.self, forKey: .id)
     name = try container.decode(String.self, forKey: .name)
     sets = try container.decode(Int.self, forKey: .sets)
     reps = try container.decode(String.self, forKey: .reps)
     break_t = try container.decode(String?.self, forKey: .break_t)
     style = try container.decode(String.self, forKey: .style)
 }
}

public struct Legs: Codable, Identifiable, Hashable {
 public var id = 0
 var name: String
 var sets: Int
 var reps: String
 var break_t: String?
 var style: String
 
 enum CodingKeys: String, CodingKey {
     case id, name, sets, reps, break_t, style
 }
 
 public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(Int.self, forKey: .id)
     name = try container.decode(String.self, forKey: .name)
     sets = try container.decode(Int.self, forKey: .sets)
     reps = try container.decode(String.self, forKey: .reps)
     break_t = try container.decode(String?.self, forKey: .break_t)
     style = try container.decode(String.self, forKey: .style)
 }
}

public struct Shoulders: Codable, Identifiable, Hashable {
 public var id = 0
 var name: String
 var sets: Int
 var reps: String
 var break_t: String?
 var style: String
 
 enum CodingKeys: String, CodingKey {
     case id, name, sets, reps, break_t, style
 }
 
 public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     id = try container.decode(Int.self, forKey: .id)
     name = try container.decode(String.self, forKey: .name)
     sets = try container.decode(Int.self, forKey: .sets)
     reps = try container.decode(String.self, forKey: .reps)
     break_t = try container.decode(String?.self, forKey: .break_t)
     style = try container.decode(String.self, forKey: .style)
 }
}
            
                
import Foundation
import Combine
import SwiftUI

public class SplitsViewModel: ObservableObject {
 @Published var upper1: [Upper1] = []
 @Published var upper2: [Upper2] = []
 @Published var legs: [Legs] = []
 @Published var shoulders: [Shoulders] = []
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

struct Upper1ListView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel

 public var body: some View {
 List(splitsViewModel.upper1) { upper1 in
     NavigationLink(destination: Upper1DetailView(exercise: upper1)) {
         Text(upper1.name)
     }
 }
 .navigationTitle("Upper 1")
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
 }
}

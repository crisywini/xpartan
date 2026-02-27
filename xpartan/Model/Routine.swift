//
//  Routine.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation

import SwiftData

@Model
final class Routine {
    
    var name: String
    var sets: [ExcerciseSet]
    var totalDuration: TimeInterval
    var date: Date
    var isCompleted: Bool
    var repetitions: Int
    
    init(name: String) {
        self.name = name
        self.sets = []
        self.totalDuration = 0
        self.date = Date()
        self.isCompleted = false
        self.repetitions = 0
    }
    
    var estimatedDuration: TimeInterval {
        sets.reduce(0) {$0 + $1.duration}
    }
    
    var formattedDuration: String {
        let minutes = Int(totalDuration) / 60
        return "\(minutes) Min"
    }
    
    var  getReps: Int {
         sets.map{ $0.completedReps }.reduce(0,+)
    }
}

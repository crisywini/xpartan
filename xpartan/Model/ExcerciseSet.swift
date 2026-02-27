//
//  ExcerciseSet.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation
import SwiftData

@Model
final class ExcerciseSet {
    
    var excercise: Excercise
    var setNumber: Int
    var targetReps: Int
    var completedReps: Int
    var weight: Double
    var duration: TimeInterval
    var isCompleted: Bool
    
    
    init(excercise: Excercise, setNumber: Int, targetReps: Int, weight: Double) {
        self.excercise = excercise
        self.setNumber = setNumber
        self.targetReps = targetReps
        self.completedReps = 0
        self.weight = weight
        self.duration = 0
        self.isCompleted = false
    }
}

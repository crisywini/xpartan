//
//  Serie.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 7/03/26.
//
import Foundation
import SwiftData

@Model
final class Serie  {
    
    var setNumber: Int
    var targetReps: Int
    var completedReps: Int
    var weight: Double
    var duration: TimeInterval
    var isCompleted: Bool
    
    init(setNumber: Int, targetReps: Int, completedReps: Int, weight: Double, duration: TimeInterval, isCompleted: Bool) {
        self.setNumber = setNumber
        self.targetReps = targetReps
        self.completedReps = completedReps
        self.weight = weight
        self.duration = duration
        self.isCompleted = isCompleted
    }

}



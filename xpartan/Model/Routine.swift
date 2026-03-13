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
    var repetitions: Int
    
    init(name: String) {
        self.name = name
        self.sets = []
        self.totalDuration = 0
        self.date = Date()
        self.repetitions = 0
    }
    
    var estimatedDuration: TimeInterval {
        sets.reduce(0) {$0 + $1.duration}
    }
    
    var formattedDuration: String {
        let minutes = Int(totalDuration) / 60
        return "\(minutes) Min"
    }
    
    var  completedReps: Int {
         sets.map{ $0.completedReps }.reduce(0,+)
    }
    
    var isCompleted: Bool {
        return (repetitions + 1) >= 3
    }
    
    
    var excerciseSetsDefault: [ExcerciseSet] = {
        let benchPress = Excercise(name: "Press Plano", muscleGroup: "Pecho")
        let benchPressSet = ExcerciseSet(excercise: benchPress)
        benchPressSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        let hammerCurl = Excercise(name: "Martillo", muscleGroup: "Bicep")
        let hammerCurlSet = ExcerciseSet(excercise: hammerCurl)
        hammerCurlSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 12.0, duration: 0, isCompleted: false)]

        let step = Excercise(name: "Peldaño", muscleGroup: "Pierna")
        let stepSet = ExcerciseSet(excercise: step)
        stepSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        let thruster = Excercise(name: "Propulsores", muscleGroup: "Pierna y Hombro")
        let thrusterSet = ExcerciseSet(excercise: thruster)
        thrusterSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 12.0, duration: 0, isCompleted: false)]

        let dumbellRow = Excercise(name: "Remo", muscleGroup: "Espalda")
        let dumbellRowSet = ExcerciseSet(excercise: dumbellRow)
        dumbellRowSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        let frenchPress = Excercise(name: "Francés", muscleGroup: "Tricep")
        let frenchPressSet = ExcerciseSet(excercise: frenchPress)
        frenchPressSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 12.0, duration: 0, isCompleted: false)]

        let lunges = Excercise(name: "Estocada", muscleGroup: "Pierna")
        let lungesSet = ExcerciseSet(excercise: lunges)
        lungesSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        let militaryPress = Excercise(name: "Militar", muscleGroup: "Hombro")
        let militaryPressSet = ExcerciseSet(excercise: militaryPress)
        militaryPressSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 12.0, duration: 0, isCompleted: false)]

        let squat = Excercise(name: "Sentadilla", muscleGroup: "Pierna")
        let squatSet = ExcerciseSet(excercise: squat)
        squatSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        let farmer = Excercise(name: "Caminata", muscleGroup: "Antebrazos")
        let farmerSet = ExcerciseSet(excercise: farmer)
        farmerSet.serie = [Serie(setNumber: 1, targetReps: 30, completedReps: 0, weight: 25.0, duration: 0, isCompleted: false)]

        return [benchPressSet, hammerCurlSet, stepSet, thrusterSet, dumbellRowSet,
                frenchPressSet, lungesSet, militaryPressSet, squatSet, farmerSet]
    }()
    
}

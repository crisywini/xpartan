//
//  ActiveRoutineDetailViewModel.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 11/03/26.
//

import SwiftUI
import SwiftData


@Observable
class ActiveRoutineDetailViewModel {
    
    //Model
    var routine: Routine
    var user: User
    var excerciseSets: [ExcerciseSet] = {
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
    
    
    var finishCount = 0
    var routineElapsedTime: TimeInterval = 0
    var routineTimer: Timer? = nil
    
    //View
    var shouldDismiss = false
    var modelContext: ModelContext?
    
    
    init(routine: Routine, user: User) {
        self.routine = routine
        self.user = user
    }
    
    func setContext(_ modelContext: ModelContext){
        self.modelContext = modelContext
    }
    
    //View Model
    var formattedRoutineInfo: String {
        return "Serie \(routine.repetitions) • \(routine.date.formatted(date: .abbreviated, time: .omitted))"
    }
    
    
    var formattedRoutineTime: String {
        let minutes = Int(routineElapsedTime) / 60
        let seconds = Int(routineElapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func finishRoutine() {

        if routine.isCompleted {
            routine.totalDuration = routineElapsedTime
            routineTimer?.invalidate()
            routine.sets = excerciseSets
            modelContext?.insert(routine)
            user.routines.append(routine)
            shouldDismiss = true
            return
        }

        routine.repetitions += 1
        finishCount += 1
    }
    
    func startRoutineTimer() {
        routineTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.routineElapsedTime += 1
        }
    }
    
    func stopRoutineTimer() {
        routineTimer?.invalidate()
        routineTimer = nil
    }
    
    
}

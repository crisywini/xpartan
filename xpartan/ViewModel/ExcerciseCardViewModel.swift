//
//  ExcerciseCardViewModel.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 12/03/26.
//

import SwiftUI
import SwiftData


@Observable
class ExcerciseCardViewModel {
    
    //Model
    var excerciseSet: ExcerciseSet
    var completedReps = 0
    var timer: Timer? = nil
    var elapsedTime: TimeInterval = 0
    
    //View
    var isCompleted = false
    var isRunning = false
    
    
    var resetTrigger: Int
    
    
    init(excerciseSet: ExcerciseSet, resetTrigger: Int) {
        self.excerciseSet = excerciseSet
        self.resetTrigger = resetTrigger
    }
    
    
    
    //View Model
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.elapsedTime += 1
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        let setNumber = excerciseSet.serie.filter { $0.isCompleted }.count + 1
        let targetReps = excerciseSet.serie.first?.targetReps ?? 0
        let weight = excerciseSet.serie.first?.weight ?? 0

        excerciseSet.serie.append(Serie(
            setNumber: setNumber,
            targetReps: targetReps,
            completedReps: completedReps,
            weight: weight,
            duration: elapsedTime,
            isCompleted: true
        ))
        completedReps = 0
    }
    
    
    var excerciseName: String {
        return excerciseSet.excercise.name
    }
    
    var excerciseWeight: String  {
        return String(format: "%.f kg", excerciseSet.weight)
    }
    
    var excerciseReps: String {
        return "\(excerciseSet.completedReps) Reps"
    }
    
}

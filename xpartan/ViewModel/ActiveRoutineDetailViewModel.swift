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
    
    var finishCount = 0
    var routineElapsedTime: TimeInterval = 0
    var routineTimer: Timer? = nil
    
    //View
    var shouldDismiss = false
    
    
    init(routine: Routine, user: User) {
        self.routine = routine
        self.user = user
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
    
    func finishRoutine(_ modelContext: ModelContext) {

        if routine.isCompleted {
            routine.totalDuration = routineElapsedTime
            routineTimer?.invalidate()
            routine.sets = routine.excerciseSetsDefault
            modelContext.insert(routine)
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
    
    var excerciseSets: [ExcerciseSet] {
        return routine.excerciseSetsDefault
    }
    
}

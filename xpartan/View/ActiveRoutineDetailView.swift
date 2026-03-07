//
//  RoutineDetailView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 27/02/26.
//

import Foundation
import SwiftUI
import SwiftData

struct ActiveRoutineDetailView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    @Bindable var routine: Routine
    @Bindable var user: User
    
    @State private var finishCount = 0
    
    @State private var routineElapsedTime: TimeInterval = 0
    @State private var routineTimer: Timer? = nil

    @State private var exerciseSets: [ExcerciseSet] = {
        let benchPress = Excercise(name: "Press Plano", muscleGroup: "Pecho")
        let benchPressSet = ExcerciseSet(excercise: benchPress, setNumber: 1, targetReps: 30, weight: 25.0)

        let hammerCurl = Excercise(name: "Martillo", muscleGroup: "Bicep")
        let hammerCurlSet = ExcerciseSet(excercise: hammerCurl, setNumber: 1, targetReps: 30, weight: 12.0)

        let step = Excercise(name: "Peldaño", muscleGroup: "Pierna")
        let stepSet = ExcerciseSet(excercise: step, setNumber: 1, targetReps: 30, weight: 25.0)

        let thruster = Excercise(name: "Propulsores", muscleGroup: "Pierna y Hombro")
        let thrusterSet = ExcerciseSet(excercise: thruster, setNumber: 1, targetReps: 30, weight: 12.0)

        let dumbellRow = Excercise(name: "Remo", muscleGroup: "Espalda")
        let dumbellRowSet = ExcerciseSet(excercise: dumbellRow, setNumber: 1, targetReps: 30, weight: 25.0)

        let frenchPress = Excercise(name: "Francés", muscleGroup: "Tricep")
        let frenchPressSet = ExcerciseSet(excercise: frenchPress, setNumber: 1, targetReps: 30, weight: 12.0)

        let lunges = Excercise(name: "Estocada", muscleGroup: "Pierna")
        let lungesSet = ExcerciseSet(excercise: lunges, setNumber: 1, targetReps: 30, weight: 25.0)

        let militaryPress = Excercise(name: "Militar", muscleGroup: "Hombro")
        let militaryPressSet = ExcerciseSet(excercise: militaryPress, setNumber: 1, targetReps: 30, weight: 12.0)

        let squat = Excercise(name: "Sentadilla", muscleGroup: "Pierna")
        let squatSet = ExcerciseSet(excercise: squat, setNumber: 1, targetReps: 30, weight: 25.0)

        let farmer = Excercise(name: "Caminata", muscleGroup: "Antebrazos")
        let farmerSet = ExcerciseSet(excercise: farmer, setNumber: 1, targetReps: 30, weight: 25.0)

        return [benchPressSet, hammerCurlSet, stepSet, thrusterSet, dumbellRowSet,
                frenchPressSet, lungesSet, militaryPressSet, squatSet, farmerSet]
    }()

    var body: some View {

        ScrollView {

            VStack(spacing: 30) {
                VStack {
                    Text(
                        "Serie \(routine.repetitions) • \(routine.date.formatted(date: .abbreviated, time: .omitted))"
                    )
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                                    .frame(height: 24)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "gauge.with.needle")
                                        .foregroundStyle(.green)
                                        .font(.title3)
                                    Text(formattedRoutineTime)
                                        .font(.system(.title3, design: .monospaced))
                                        .foregroundStyle(.green)
                                }
                    
                }
                let columns = [GridItem(.flexible()), GridItem(.flexible())]

                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(exerciseSets, id: \.self) { es in
                        ExcerciseCardView(
                            excerciseSet: es,
                            resetTrigger: finishCount
                        )
                    }
                }
                
                HStack {
                    Button {
                        finishRoutine()
                    } label: {
                        
                        HStack {
                            Text("Finalizar")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.black)
                            Image(systemName: "flag.pattern.checkered")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .navigationTitle("Xpartano")
        }
        .padding(.horizontal)
        .onAppear {
            routineTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                routineElapsedTime += 1
            }
        }
        .onDisappear {
            routineTimer?.invalidate()
            routineTimer = nil
        }

    }
    
    
    func finishRoutine() {

        if routine.isCompleted {
            routine.totalDuration = routineElapsedTime
            routineTimer?.invalidate()
            routine.sets = exerciseSets
            modelContext.insert(routine)
            user.routines.append(routine)
            dismiss()
            return 
        }

        routine.repetitions += 1
        finishCount += 1
    }
    
    var formattedRoutineTime: String {
        let minutes = Int(routineElapsedTime) / 60
        let seconds = Int(routineElapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}

struct ExcerciseCardView: View {

    @Bindable var excerciseSet: ExcerciseSet

    @State private var isCompleted = false
    @State private var isRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil

    @State private var completedReps = 0

    let resetTrigger: Int



    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 5) {
                
                
                HStack{
                    Image(systemName: "gauge.with.needle")
                        .foregroundStyle(isRunning ? .green: .secondary)
                    Text(formattedTime)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(isRunning ? .green : .secondary)
                    
                }
                
                Text(excerciseSet.excercise.name)
                    .font(.title2)
                    .bold()
                HStack {
                    Image(systemName:"dumbbell.fill")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title2)
                        .bold()
                    Text(String(format: "%.f kg", excerciseSet.weight))
                        .font(.title3)
                }
                
                HStack {
                    Image(systemName:"flag.pattern.checkered.circle")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title)
                        .bold()
                    
                    Text("\(excerciseSet.completedReps) Reps")
                        .font(.title3)
                        .bold()
                }
                
                
                
                HStack {
                    Text("Reps")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(!isRunning ? .secondary : .primary)
                    TextField("Reps", value: $completedReps, format: .number)
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .disabled(!isRunning)
                        .foregroundStyle(!isRunning ? .secondary : .primary)
                    
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                    isRunning ? stop() : start()
                            }
                        
                        } label: {
                            Image(systemName: isRunning ? "stop.circle.fill" : "play.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(isRunning ? .red : .green)
                                    .scaleEffect(isRunning ? 1.4 : 1.3)
                        }
                        
                    }
                }
                

            }
            .padding(.horizontal, 20)
            .frame(width: .infinity, height: 170)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .onChange(of: resetTrigger) {
            timer?.invalidate()
            timer = nil
            isRunning = false
            completedReps = 0
        }
    }

    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        excerciseSet.duration = elapsedTime
        excerciseSet.completedReps += completedReps
        completedReps = 0
    }
}

#Preview {
    ActiveRoutineDetailView(routine: Routine(name: "Xpartano"), user: User(photo: nil, name: "Cris", height: 180.0, weight: 79.0, gender: "Male", category: "Wild", age: 26)
    )
        .modelContainer(for: [Routine.self, ExcerciseSet.self], inMemory: true)

}

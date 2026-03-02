//
//  RoutineDetailView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 27/02/26.
//

import Foundation
import SwiftUI
import SwiftData

struct RoutineDetailView: View {
    
    var routine: Routine?
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(excerciseSetsDefault, id: \.self) { es in
                        ExcerciseCardView(excerciseSet: es)
                        
                    }
                }
            }
            
        }
        .padding(.horizontal)
        
    }
    
    
    var excerciseSetsDefault: [ExcerciseSet] {
        
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
        
        
        var excerciseSets: [ExcerciseSet] = []
        
        excerciseSets.append(benchPressSet)
        excerciseSets.append(hammerCurlSet)
        excerciseSets.append(stepSet)
        excerciseSets.append(thrusterSet)
        excerciseSets.append(dumbellRowSet)
        excerciseSets.append(frenchPressSet)
        excerciseSets.append(lungesSet)
        excerciseSets.append(militaryPressSet)
        excerciseSets.append(squatSet)
        excerciseSets.append(farmerSet)
        
        return excerciseSets
    }
    
}

struct ExcerciseCardView: View {
    
    @Bindable var excerciseSet: ExcerciseSet
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 5) {
                
                HStack {
                    Image(systemName: "play.circle")
                        .font(.title3)
                        .foregroundColor(Color(.green).opacity(0.6))
                    
                    Image(systemName: "stop.circle")
                        .font(.title3)
                        .foregroundColor(Color(.red).opacity(0.6))
                    
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
                    
                    Text("\(excerciseSet.targetReps) Reps")
                        .font(.title3)
                        .bold()
                }
                
                
                
                HStack {
                    Text("Reps")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .bold()
                    TextField("Reps",  value: $excerciseSet.completedReps, format: .number)
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                }
                

            }
            .padding(.horizontal, 20)
            .frame(width: .infinity, height: 150)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    RoutineDetailView(routine: nil)
}

//
//  HorizontalBarChart.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 7/03/26.
//

import SwiftUI
import Charts

struct HorizontalBarChart: View {
    
    var excercises: ExcerciseSet
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(exce)
        }
        
    }
}





#Preview {
    
    let benchPress = Excercise(name: "Press Plano", muscleGroup: "Pecho")
    let benchPressSet = ExcerciseSet(excercise: benchPress, setNumber: 1, targetReps: 30, weight: 25.0)
    benchPressSet.completedReps = 20
    HorizontalBarChart(excercises: benchPressSet)
}


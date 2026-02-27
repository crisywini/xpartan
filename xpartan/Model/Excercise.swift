//
//  Excercise.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation
import SwiftData

@Model
final class Excercise {
    
    var name: String
    var muscleGroup: String
    
    init(name: String, muscleGroup: String) {
        self.name = name
        self.muscleGroup = muscleGroup
    }
}

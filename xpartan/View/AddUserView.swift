//
//  AddUserView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation

import SwiftUI

import PhotosUI

struct AddUserView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    

    @State private var selectedPhoto: PhotosPickerItem?
    
    @State private var selectedGender: Gender = .male
    @State private var selectedCategory: Category = .wild
    
    @State private var vm: AddUserViewModel = AddUserViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                photoSection
                basicInfoSection
            }
            
            .navigationTitle("Nuevo Usuario")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        vm.saveUser(selectedGender: selectedGender.rawValue,
                                    selectedCategory: selectedCategory.rawValue,
                                    modelContext: modelContext)
                    }
                    .disabled(!vm.isFormValid)
                    .bold()
                }
            }
            .onChange(of: selectedPhoto) { _, newValue in
                Task {
                    vm.photoData = try? await newValue?.loadTransferable(type: Data.self)
                }
            }
            .onChange(of: vm.shouldDismiss) {
                if vm.shouldDismiss {
                    dismiss()
                }
            }
        }
    }
    
    private var photoSection: some View {
        Section("Foto") {
            HStack {
                Spacer()
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    if let photoData = vm.photoData, let uiImage = UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "camera.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .opacity(0.6)
                            Text("Agrega una foto")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 120, height: 120)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
    
    private var basicInfoSection: some View{
        Section("Información básica"){
            TextField("Nombre", text: $vm.name)
            TextField("Altura", text: $vm.height)
                .keyboardType(.decimalPad)
            TextField("Peso", text: $vm.weight)
                .keyboardType(.decimalPad)
            TextField("Edad", text: $vm.age)
                .keyboardType(.numberPad)
            Picker("Genero", selection: $selectedGender){
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
            Picker("Categoria", selection: $selectedCategory) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
        }
    }
    
    
    
    
}


enum Gender: String, CaseIterable {
    case male = "Hombre"
    case female = "Mujer"
    case other = "Otro"
}


enum Category: String, CaseIterable {
    case wild = "Wild"
    case beginner = "Begins"
}

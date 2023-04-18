//
//  Overview.swift
//  iExpense
//
//  Created by Edmond Podlegaev on 13.04.2023.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct NewOverview: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)")
            Button("Dismiss") { dismiss() }
        }
    }
}


struct Overview: View {
    @StateObject private var user = User()

    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("newTapCount") private var newTapCount = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("First Name", text: $user.firstName)
                TextField("Last Name", text: $user.lastName)
                
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    NewOverview(name: "@ilozur")
                }
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                }
                Button("New tap count: \(newTapCount)") {
                    newTapCount += 1
                    
                }
            }
            .navigationTitle("Overview")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}

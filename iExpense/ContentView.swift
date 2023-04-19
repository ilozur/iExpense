//
//  ContentView.swift
//  iExpense
//
//  Created by Edmond Podlegaev on 13.04.2023.
//

import SwiftUI

struct SmallExpense: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.green)
    }
}

struct MediumExpense: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.yellow)
    }
}

struct LargeExpense: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.red)
    }
}


extension View {
    func smallExpenseStyle() -> some View {
            modifier(LargeExpense())
    }
    func mediumExpenseStyle() -> some View {
            modifier(LargeExpense())
    }
    func largeExpenseStyle() -> some View {
            modifier(LargeExpense())
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack (alignment: .leading) {
                            if item.amount > 100 {
                                Text(item.name)
                                    .largeExpenseStyle()
                            }
                            if item.amount > 50 && item.amount <= 99 {
                                Text(item.name)
                                    .mediumExpenseStyle()
                            }
                            if item.amount > 10 && item.amount <= 49 {
                                Text(item.name)
                                    .smallExpenseStyle()
                            }
                            if item.amount > 1 && item.amount <= 9 {
                                Text(item.name)
                                    .font(.headline)
                            }
                            Text(item.type)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "RUB"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

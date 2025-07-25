//
//  ContentView.swift
//  iExpense
//
//  Created by Pranav on 20/07/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    static let allTypes = [
        "cosmetics", "study", "party", "food", "transport", "health", "clothing",
        "subscriptions", "entertainment", "education", "gifts", "travel", "rent",
        "utilities", "groceries", "investment", "savings", "donation", "fitness", "insurance"
    ]
    
    var amountaColor: Color {
        switch self.amount {
        case 0..<100: return .green
        case 100..<1000: return .orange
        case 1000..<10000: return .red
        default: return .blue
        }
    }
}

@Observable
class Expenses  {
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack{
                        Text(item.name)
                            .font(.title2)
                        Spacer()
                        VStack{
                            
                            Text("\(item.amount,specifier:"%.2f")")
                                .font(.title3)
                            
                            Text(item.type)
                                .font(.caption)
                                .frame(width: 80, height: 20)
                                .background(item.amountaColor)
                                .clipShape(.capsule)
                        }
                    }
                    
                }.onDelete(perform: removeEle)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem{
                    Button{
                        showingAddExpense = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
                    .presentationDetents([.medium])
            }
        }
      
       
    }
    
    func removeEle(at offSet : IndexSet){
        expenses.items.remove(atOffsets: offSet)
    }
    
}

#Preview {
    ContentView()
}



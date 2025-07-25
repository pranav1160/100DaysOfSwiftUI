//
//  AddView.swift
//  iExpense
//
//  Created by Pranav on 21/07/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var thisName:String = ""
    @State private var arrType:[String] = ExpenseItem.allTypes
    @State private var thisType:String = "study"
    @State private var thisAmount:Double = 0
    
    var expenses: Expenses
    
    var body: some View {
        
        NavigationStack {
            Form{
                TextField("Enter Name",text: $thisName)
                Section{
                    Slider(value: $thisAmount,in: 0...10000,step: 1)
                    Text("Amount :\(thisAmount.formatted())")
                }
                
                Picker("Type", selection: $thisType) {
                    ForEach(arrType,id: \.self) { ele in
                        Text("\(ele)")
                    }
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Add"){
                        let newExpense = ExpenseItem(
                            name: thisName,
                            type: thisType,
                            amount: thisAmount
                        )
                        expenses.items.append(newExpense)
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                }
                
                ToolbarItem (placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }

            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

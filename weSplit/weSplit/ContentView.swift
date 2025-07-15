import SwiftUI

struct ContentView: View {
    
    @State private var amount:Double = 0
    @State private var numPeople:Int = 1
    @State private var tipPercentage:Double = 0
    var formatted : String{
        String(format: "%.2f", tipPercentage)
    }
    
    @FocusState private var amountIsFocused
    
    var ans : Double{
        let x1 = tipPercentage/100*amount
        let x = (x1+amount)/Double(numPeople+1)
        return x
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                   
                        TextField(
                            "Amount :",
                            value: $amount,
                            format:
                                    .currency(
                                        code: Locale.current.currency?.identifier ?? "USD"
                                    )
                        )
                        .focused($amountIsFocused)
                        .keyboardType(.decimalPad)
                    
                }
                
                Section{
                    Picker("Number Of People", selection: $numPeople) {
                        ForEach(1..<100){i in
                            Text("\(i) Person")
                        }
                    }
                }
                
                Section{
                    Slider(value: $tipPercentage,in: 0...100)
                    
                    Text("Tip :\(formatted)")
                }
                
                Section{
                    Text("Per Person: \(ans, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")

                }
            }
            .navigationTitle("We-Split")
            .toolbar {
                if amountIsFocused {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
        
            }
        }
    }
}

#Preview {
    ContentView()
}

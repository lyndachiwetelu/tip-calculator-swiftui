//

import SwiftUI

struct ContentView: View {
    @State var bill: String = ""
    @State var selectedTipPercent = 5
    @State var personsToSplitBill = 1
    
    
    @State var billWithTip: String = "0.00"
    @State var totalBill: String = "0.00" // grand total
    @State var tip: String = "0.00"
    
    @State var showAlert = false
    
    
    let step = 1
    let range = 1...20
    
    let formatter: NumberFormatter = {
        let formatter  = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Happy Tipper").font(.title2)
            PriceCardView(
                billWithTip: $billWithTip,
                totalTip: $tip,
                tipPercent: $selectedTipPercent,
                originalBill: $bill,
                totalBill: $totalBill,
                billPersons: $personsToSplitBill
            )
            
            
            VStack(alignment: .leading) {
                Text("Enter your total bill amount")
                TextField("", text: $bill)
                    .font(.system(size: 22))
                    .padding(10)
                    .frame(width: 350, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)

            }
            
            VStack(alignment: .leading) {
                Text("Select desired Tip percent %")
                Picker("Tip", selection: $selectedTipPercent) {
                    Text("5%").tag(5)
                    Text("10%").tag(10)
                    Text("15%").tag(15)
                }.pickerStyle(.segmented)
            }
            
            
            VStack(alignment: .leading) {
                Text("Want to split the bill?").foregroundColor(Color.gray)
                Stepper(value: $personsToSplitBill, in: range, step: step) {
                    HStack {
                        Text("Split by Persons: ")
                        Text("\(personsToSplitBill)").font(.title2)
                    }
                }
            }
            
            
            Button(action: {
                calculateTip()
            }, label: {
                Text("Calculate Bill with Tip")
                    .frame(width: 350, height: 50)
                    .foregroundColor(.white)
                    .background(Color("AppPink"))
                    .cornerRadius(200)
            })
            
            
            Button(action: {
                resetValues()
                
                // optional
                personsToSplitBill = 1
                selectedTipPercent = 5
                bill = ""
                
            }, label: {
                Text("Cancel")
                    .frame(width: 350, height: 50)
                    .foregroundColor(Color("AppPink"))
                    .background(.gray.opacity(0.2))
                    .cornerRadius(200)
            })
            
            
            
            
   
        } // main VStack
        .alert("Please enter a valid amount", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onChange(of: bill) { newValue in
            if newValue.isEmpty {
                resetValues()
            }
        }
        .onChange(of: selectedTipPercent) { _ in
            resetValues()
        }
    } // body
    
    
    func calculateTip() -> Void {
        guard let billAmountNumber = formatter.number(from: bill) else {
            showAlert = true
            return
        }
        
        let billAmount = Float(truncating: billAmountNumber)
        let tipPercentage = Float(selectedTipPercent) / 100.0
        let tipAmount  = billAmount * tipPercentage
        let totalBillWithTip = billAmount + tipAmount
        
        var billWithTip: Float = 0.0
        
        if personsToSplitBill > 1 {
            billWithTip = totalBillWithTip / Float(personsToSplitBill)
        } else {
            billWithTip = totalBillWithTip
        }
        
        self.billWithTip = formatter.string(from: NSNumber(value: billWithTip)) ?? "0.00"
        self.totalBill = formatter.string(from: NSNumber(value: totalBillWithTip)) ?? "0.00"
        self.tip = formatter.string(from: NSNumber(value: tipAmount)) ?? "0.00"
        
    }
    
    func resetValues() -> Void {
        billWithTip = "0.00"
        totalBill = "0.00"
        tip = "0.00"
    }
}

#Preview {
    ContentView()
}

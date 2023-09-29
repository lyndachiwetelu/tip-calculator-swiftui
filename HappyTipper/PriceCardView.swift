//

import SwiftUI

struct PriceCardView: View {
    @Binding var billWithTip: String
    @Binding var totalTip: String
    @Binding var tipPercent: Int
    @Binding var originalBill: String
    @Binding var totalBill: String
    @Binding var billPersons: Int
    
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Text("Total per person: \(billWithTip) ")
                Text("Grand Total: \(totalBill)")
            }.font(.title2)
            
            Group {
                Text("Bill: \(originalBill)")
                Text("Your Tip: \(totalTip) ( \(tipPercent) %)")
                Text("Split by: \(billPersons)")
                
            }.opacity(0.8)
        }.frame(width: 350, height: 170)
        .background(Color("AppPink"))
        .cornerRadius(20)
        .foregroundColor(Color.white)
    }
}

#Preview {
    PriceCardView(billWithTip: .constant("10"), totalTip: .constant("10"), tipPercent: .constant(10), originalBill: .constant("0.00"), totalBill: .constant("0.00"), billPersons: .constant(1))
}

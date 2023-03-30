import SwiftUI

struct CardView: View {
    let category: String
    let colorOne: Color
    let colorTwo: Color 
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [colorOne, colorTwo], startPoint: .leading, endPoint: .trailing)
            Text(category)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

import SwiftUI

struct StarView: View {
    @Binding var starRange: Int
    @Binding var starSelection: Int

    var body: some View {
        HStack {
            ForEach(1..<starRange + 1, id: \.self) { rating in
                Image(systemName: "star") 
                    .foregroundColor(rating > starSelection ? Color.gray : Color.yellow) 
                    .onTapGesture {
                        starSelection = rating  
                    }
            }
        }
    }
}

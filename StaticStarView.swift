import SwiftUI

struct StaticStarView: View {
    let starRange: Int
    let starSelection: Int
    
    var body: some View {
        HStack {
            ForEach(1..<starRange + 1, id: \.self) { rating in
                Image(systemName: "star.fill") 
                    .foregroundColor(rating > starSelection ? Color.gray : Color.yellow) 
            }
        }
    }
}


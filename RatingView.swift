import SwiftUI

struct RatingView: View {
    @Environment(\.colorScheme) var colorScheme
    let rating: Rating 
    
    var body: some View {
        List {
            Section("RateItz") {
                LabeledContent("RateItz", value: rating.name)
                LabeledContent("Category", value: rating.category) 
                LabeledContent("Rating Type", value: rating.ratingType)
                if rating.ratingType == "Stars" {
                    StaticStarView(starRange: rating.ratingScale, starSelection: rating.ratingSelection)
                } else {
                    LabeledContent("Rating", value: "\(rating.ratingSelection)/\(rating.ratingScale)")
                }
            }
            
            if !rating.notes.trimmingCharacters(in: .whitespaces).isEmpty || !rating.images.isEmpty {
                Section("Notes") {
                    Text(rating.notes)
                    ForEach(0..<rating.images.count, id: \.self) { image in 
                        rating.images[image]
                    }
                }
            }
        }
        .scrollContentBackground(.hidden) 
        .background(.black)
        .toolbar {
            Button("Edit") {
                
            }
        }
    }
}

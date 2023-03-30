import SwiftUI

struct Rating: Identifiable {
    let id = UUID() 
    let name: String
    let category: String
    let otherCategory: String
    let color: Color
    let ratingType: String
    let ratingScale: Int
    let ratingSelection: Int
    let notes: String
    let images: [Image]
}

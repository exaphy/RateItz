import SwiftUI

class Ratings: ObservableObject {
    @Published var ratings = [Rating]()
}

import SwiftUI

extension Color {
    static let darkBlue = Color(red: 0.11, green: 0.17, blue: 0.29)
    static let lightGray = Color(red: 0.39, green: 0.39, blue: 0.39)
    static let charcoalGray = Color(red: 0.17, green: 0.17, blue: 0.17)
    static let midnightPurple = Color(red: 0.10, green: 0.09, blue: 0.21)
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showSheet = false 
    @StateObject var ratings = Ratings()
    let rows = [GridItem(.adaptive(minimum: 80))]
    static let images = [Image]()
    let ratingExample = Rating(name: "RateItz Hotel", category: "Hotel", otherCategory: "", color: Color.white, ratingType: "Stars", ratingScale: 5, ratingSelection: 5, notes: "", images: images) 
    
    var body: some View {
        NavigationView {
            ZStack {
                if colorScheme == .dark {
                    Color.black
                        .ignoresSafeArea()
                }
                
                GeometryReader { geo in 
                    ScrollView {
                        HStack {
                            Text("Welcome to RateItz") 
                                .foregroundColor(.gray) 
                                .padding()
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows) {
                                Group {
                                    if ratings.ratings.isEmpty {
                                        CardView(category: "Get Started", colorOne: .charcoalGray, colorTwo: .black)
                                            .onTapGesture { 
                                                showSheet = true
                                            }
                                    } else {
                                        CardView(category: "Add RateItz", colorOne: .gray, colorTwo: .black)
                                            .onTapGesture { 
                                                showSheet = true
                                            }  
                                    }
                                    Group {
                                        NavigationLink {
                                            RatingView(rating: ratingExample) 
                                                .navigationTitle("RateItz Example")
                                        } label: {
                                            CardView(category: "RateItz Example", colorOne: .darkBlue, colorTwo: .black)
                                        }
                                        NavigationLink {
                                            
                                        } label: {
                                            CardView(category: "All Examples", colorOne: .midnightPurple, colorTwo: .black)
                                        }
                                    }
                                    .accentColor(.white) 
                                }
                                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2)
                            }
                            .padding(.horizontal)
                        }
                        
                        ScrollView {
                            if ratings.ratings.isEmpty {
                                HStack {
                                    Text("My RateItz")
                                        .foregroundColor(.gray) 
                                        .padding()
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal) {
                                    LazyHGrid(rows: rows) {
                                        Group {
                                            CardView(category: "Add RateItz", colorOne: .darkBlue, colorTwo: .midnightPurple)
                                                .onTapGesture {
                                                    showSheet = true
                                                }
                                        }
                                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2)
                                    }
                                    .padding(.horizontal)
                                }
                            } else {
                                ForEach(ratings.ratings) { rating in
                                    HStack {
                                        Text("My RateItz \(rating.category)")
                                            .foregroundColor(.gray) 
                                            .padding()
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("RateItz")
            .sheet(isPresented: $showSheet) {
                AddRateItz(ratings: ratings) 
            }
        }
    }
}

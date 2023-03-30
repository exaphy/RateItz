import PhotosUI
import SwiftUI

struct AddRateItz: View {
    @Environment(\.colorScheme) var colorScheme 
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var categories = ["Books", "TV Shows", "Movies", "Hotels", "Restaurants", "Other"]
    @State private var categorySelection = "Books"
    @State private var otherCategory = ""
    @State private var customColors = false 
    @State private var color =
    Color.white 
    
    @State private var scales = ["Stars", "Number"] 
    @State private var scaleType = "Stars"
    @State private var scaleStars = ["5", "10"]
    @State private var starRange = 5
    @State private var numberRange = 10
    @State private var starSelection = 1
    @State private var numberSelection = 1
    
    @State private var notes = ""
    @State private var imageSelections = [PhotosPickerItem]()
    @State private var images = [Image]()
    
    @ObservedObject var ratings: Ratings 
    
    var disabled: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return true 
        } else if categorySelection == "Other" && otherCategory.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("RateItz") {
                    TextField("RateItz Name", text: $name)
                    Picker("Category", selection: $categorySelection) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    if categorySelection == "Other" {
                        TextField("Other Category", text: $otherCategory)
                    }
                    Toggle("Custom Color", isOn: $customColors) 
                    if customColors {
                        ColorPicker("RateItz Color", selection: $color)
                    }
                }
                
                Section {
                    Picker("Scale Type", selection: $scaleType) {
                        ForEach(scales, id: \.self) {
                            Text($0)
                        }
                    }
                    if scaleType == "Stars" {
                        Picker("Scale Range (1-\(starRange))", selection: $starRange) {
                            ForEach(2..<11, id: \.self) { 
                                Text(String($0))
                            }
                        }
                        HStack {
                            StarView(starRange: $starRange, starSelection: $starSelection) 
                        }
                    } else {
                        Picker("Scale Range (1-\(numberRange))", selection: $numberRange) {
                            ForEach(2..<101, id: \.self) {
                                Text(String($0))
                            }
                        }
                        Picker("Rating", selection: $numberSelection) {
                            ForEach(1..<numberRange + 1, id: \.self) {
                                Text(String($0))
                            }
                        }
                    }
                } header: {
                    Text("Review")
                } footer: {
                    Text("For best results, ensure your scale range is equal across RateItz in their respective categories.")
                }
                
                Section {
                    TextEditor(text: $notes)
                    PhotosPicker("Add Photos", selection: $imageSelections, matching: .images)
                    ForEach(0..<images.count, id: \.self) { image in
                        images[image] 
                            .resizable()
                            .scaledToFit() 
                    }
                } header: {
                    Text("Notes (Optional)")
                } footer: {
                    Text("Add notes and your favorite photos for future reference.")
                }
            }
            .navigationTitle("Add RateItz")
            .toolbar {
                Button("Add RateItz") {
                    addRateItz()
                    dismiss()
                }
                .disabled(disabled)
            }
            .onChange(of: imageSelections) { _ in
                Task {
                    images.removeAll()
                    
                    for image in imageSelections {
                        if let data = try await image.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                let finalImage = Image(uiImage: uiImage)
                                images.append(finalImage)
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addRateItz() {
        if scaleType == "Stars" {
            if starSelection > starRange {
                starSelection = starRange
            }
            let rating = Rating(name: name, category: categorySelection, otherCategory: otherCategory, color: color, ratingType: scaleType, ratingScale: starRange, ratingSelection: starSelection, notes: notes, images: images) 
            ratings.ratings.append(rating) 
        } else {
            if numberSelection > numberRange {
                numberSelection = numberRange
            }
            let rating = Rating(name: name, category: categorySelection, otherCategory: otherCategory, color: color, ratingType: scaleType, ratingScale: numberRange, ratingSelection: numberSelection, notes: notes, images: images) 
            ratings.ratings.append(rating) 
        }
    }
}

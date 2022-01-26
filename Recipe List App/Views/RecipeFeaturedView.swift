//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Dave Sutter on 1/25/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    // Reference the view model
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Featured Recipes")
                .bold()
                .font(.largeTitle)
                .padding(.leading)
                .padding(.top, 40)
            
            GeometryReader { geo in
                TabView {
                    ForEach(0..<model.recipes.count) { index in
                        
                        let recipe = model.recipes[index]
                        if recipe.featured {
                            
                            VStack {
                            
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack {
                                        Image(recipe.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(recipe.name)
                                            .padding(5)
                                        
                                    }
                                    
                                }
                                    .frame(width: geo.size.width-40, height: geo.size.height-100, alignment: .center)
                                    .cornerRadius(15)
                                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5),radius: 10, x: -5, y: 5)
                                
                                VStack() {
                                    Text("Preparation Time:")
                                        .font(.headline)
                                    Text(recipe.prepTime)
                                    Text("Highlights")
                                        .font(.headline)
                                    Text(recipe.highlights.joined(separator: ", "))
                                }
                                
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            
            }
            
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}

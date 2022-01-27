//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
        
    }
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {
        
        var elements = [String]()
        
        if ingredient.num != nil {
            //get the modified numerator and denominator
            let num = ingredient.num! * targetServings
            let denom = (ingredient.denom != nil ? ingredient.denom! : 1) * recipeServings
            
            //remove the whole part
            let wholePart = num / denom
            let remainder = num % denom
            
            //get the reaminder string, dividing by gcd if needed
            if wholePart > 0 {
                elements.append(String(wholePart))
            }
            if remainder > 0 {
                elements.append(getFractionString(num: remainder, denom: denom))
            }
            if ingredient.unit != nil {
                elements.append(getCorrectedUnit(unit: ingredient.unit!, num: num, denom: denom))
            }
            
            return elements.joined(separator: " ")
        }
        else {
            return ingredient.unit ?? "" //this is an option for if nil
        }
    }
    
    static func getFractionString(num: Int, denom: Int) -> String {
        
        if num == 0 {
            //fraction string for 0 numerator
            return ""
        }
        else {
            //non zero numerator
            var rNum = num
            var rDenom = denom
            for d in (2...denom/2) {
                if (num % d == 0) && (denom % d == 0) {
                    rNum = num / d
                    rDenom = denom / d
                }
            }
            
            return "\(rNum)/\(rDenom)"
        }
    }
    
    static func getCorrectedUnit(unit: String, num: Int, denom: Int) -> String {
        if Float(num)/Float(denom) > 1 {
            return unit + "s"
        }
        else {
            return unit
        }
    }
}

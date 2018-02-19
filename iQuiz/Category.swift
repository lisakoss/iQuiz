//
//  Category.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/19/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class Category: NSObject {
    var categoryTitle:String = ""
    var categoryDescription:String = ""
    var questions:[Question] = []
    
    init(categoryTitle:String, categoryDescription:String, questions:[Question]) {
        self.categoryTitle = categoryTitle
        self.categoryDescription = categoryDescription
        self.questions = questions
    }
}

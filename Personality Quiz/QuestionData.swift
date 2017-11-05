//
//  QuestionData.swift
//  Personality Quiz
//
//  Created by Joseph Barbati on 11/4/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import Foundation

struct Question
{
    var text: String
    var type: Response
    var answers: [Answer]
}

struct Answer
{
    var text: String
    var type: Animal
}

enum Response
{
    case single, multiple, ranged
}

enum Animal : Character
{
    case dog = "🐶"
    case cat = "🐱"
    case bunny = "🐰"
    case turtle = "🐢"
    
    var definition: String
    {
        switch self
        {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .bunny:
            return "You love everyting that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}

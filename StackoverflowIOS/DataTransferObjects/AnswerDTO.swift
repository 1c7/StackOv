//
//  AnswerDTO.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

typealias AnswerId = Int

struct AnswerDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case questionId = "question_id"
        case isAccepted = "is_accepted"
        case score
        case link
        case body = "body_markdown"
        case owner
    }
    
    let id: AnswerId
    let questionId: QuestionId
    let isAccepted: Bool
    let score: Int
    let link: URL
    let body: String?
    let owner: UserDTO
}

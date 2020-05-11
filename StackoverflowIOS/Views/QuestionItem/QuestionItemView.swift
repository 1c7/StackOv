//
//  QuestionItemView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 03/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct QuestionItemView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    
    @State private var collectionHeight: CGFloat = .zero
    let model: QuestionItemModel
    
    init(model: QuestionItemModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            questionInfo
                .padding(.bottom, 8)
                .frame(width: 58)
            content
                .padding(.bottom, 8)
        }
        .onAppear {
            self.stackoverflowStore.itemWasShowed(id: self.model.id)
        }
    }
    
    var questionInfo: some View {
        VStack(spacing: 6) {
            ScoreView(value: model.score)
            AnswersView(value: model.answerCount, isAnswered: model.isAnswered)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
                .foregroundColor(.title)
                .font(.system(size: 16))
            
            tagsCollection
                .frame(height: self.collectionHeight)
        }
        .onPreferenceChange(CollectionViewSizeKey.self) {
            self.collectionHeight = $0.height
        }
    }
    
    var tagsCollection: some View {
        return CollectionView(data: model.tags) { tag in
            TagView(tag: tag.name) {
                self.stackoverflowStore.searchStore.search(tag: tag)
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
struct QuestionItemView_Previews: PreviewProvider {
    static let model = QuestionItemModel(id: 100, title: "Testasdasdasdasdadadsadadsadadasdassdadsasdasdadsasdad111111", isAnswered: true, viewCount: 0, answerCount: 10, score: 2012, tags: (1...20).map({ TagModel(name: "Tag \($0)") }), link: URL(string: "www.google.com")!)
    
    static var previews: some View {
        Group {
            QuestionItemView(model: model)
                .environment(\.colorScheme, .light)
            
            QuestionItemView(model: model)
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

// MARK: - Subviews

fileprivate struct ScoreView: View {
    let value: Int
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(Color.Votes.title)
            Text("votes")
                .font(.system(size: 11))
                .foregroundColor(Color.Votes.description)
        }
        .padding(.bottom, 5)
    }
}

fileprivate struct AnswersView: View {
    let value: Int
    let isAnswered: Bool
    
    var body: some View {
        Group {
            if isAnswered {
                content.cornerRadius(3)
            } else {
                content.overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.Answers.boarder, lineWidth: 1)
                )
            }
        }
    }
    
    var content: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 20))
                .fontWeight(.medium)
            Text("answers")
                .font(.system(size: 11))
        }
        .foregroundColor(Color.Answers.title(isAnswered: isAnswered))
        .padding(.top, 7)
        .padding(.bottom, 5)
        .frame(maxWidth: .infinity)
        .background(Color.Answers.background(isAnswered: isAnswered))
        .foregroundColor(isAnswered ? Color.white : Color.black)
    }
}

// MARK: - Extensions

fileprivate extension Color {
    static let title = Color("questionItemTitle")
    
    enum Answers {
        static let boarder = Color("questionItemAnswersBackground")
        static func title(isAnswered: Bool) -> Color {
            isAnswered ? Color.white : Color("questionItemAnswersBackground")
        }
        static func background(isAnswered: Bool) -> Color {
            isAnswered ? Color("questionItemAnswersBackground") : Color.clear
        }
    }
    
    enum Votes {
        static let title = Color("questionItemVotesForeground")
        static let description =  Color("questionItemVotesForeground")
    }
}

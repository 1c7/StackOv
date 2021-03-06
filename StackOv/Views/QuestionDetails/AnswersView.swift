//
//  AnswersView.swift
//  StackOv
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import HTMLEntities
import Down

struct AnswersView: View {
    @EnvironmentObject var answersStore: AnswersStore
    
    @State var isLoading: Bool = false
    
    var body: some View {
        Group { () -> AnyView in
            switch answersStore.state {
            case .unknown, .emptyContent:
                return AnyView(EmptyView())
            case let .content(model):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return AnyView(content(model))
            case .loading:
                return AnyView(loading)
            case .error:
                return AnyView(error)
            }
        }
    }

    var loading: some View {
        LoadingIndicatorView()
            .frame(width: 30, height: 30)
            .padding(.top)
    }
    
    var error: some View {
        Text(answersStore.state.error?.localizedDescription ?? "")
    }
    
    var sectionHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            Divider()
            Text("Answers")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color.title)
                .padding(.top, 6)
            Divider()
        }
        .padding(.bottom)
    }
    
    func content(_ model: [AnswerModel]) -> some View {
        VStack(alignment: .center, spacing: .zero) {
            sectionHeader
                .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(model) {
                    AnswerView(model: $0)
                    
                    if $0.id != model.last?.id || self.answersStore.hasMore {
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }
                }
            }
            
            if self.answersStore.hasMore {
                LoadMoreButton(isLoading: $isLoading) {
                    self.answersStore.loadAnswers(.next)
                    self.isLoading = true
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
struct AnswersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswersView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(QuestionStore())
                .environmentObject(AnswersStore())
            
            AnswersView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(QuestionStore())
                .environmentObject(AnswersStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let title = Color("questionTitle")
    #if DEBUG
    static let background = Color("mainBackground")
    #endif
}

//
//  QuestionDetailsView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct QuestionDetailsView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    
    let questionItem: QuestionItemModel
    
    @State private var safariStatus: Bool = false
    
    init(item: QuestionItemModel) {
        self.questionItem = item
        
        // https://medium.com/@francisco.gindre/customizing-swiftui-navigation-bar-8369d42b8805
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .navBurForeground
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        QuestionView()
                            .padding(.horizontal, 16)
                            .environmentObject(self.stackoverflowStore.questionStore)
                        
                        AnswersView()
                            .environmentObject(self.stackoverflowStore.questionStore)
                            .environmentObject(self.stackoverflowStore.answersStore)
                        
                        Color.clear
                            .frame(height: geometry.safeAreaInsets.bottom)
                    }
                    .frame(width: geometry.size.width)
                }
                .padding(.top, 0.3)
            }
            
            NavigationBarView()
                .edgesIgnoringSafeArea([.leading, .trailing])
                .padding(.top, -NavigationBarView.Constants.height)
                .environmentObject(self.stackoverflowStore)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(alignment: .center, spacing: .zero) {
                Button(action: {
                    self.safariStatus = true
                }) {
                    Image.share
                }
                .frame(width: 44, height: 44)
                
                Button(action: {
                    self.stackoverflowStore.questionStore.reload()
                    self.stackoverflowStore.answersStore.reload()
                    self.stackoverflowStore.questionStore.loadQuestion(id: self.questionItem.id)
                }) {
                    Image.reload
                }
                .frame(width: 44, height: 44)
            }
        )
        .sheet(isPresented: $safariStatus) {
            SafariView(url: self.questionItem.link)
        }
        .onAppear {
            self.stackoverflowStore.questionStore.loadQuestion(id: self.questionItem.id) //meta: 269753 // 61979056 // 61978105
            // problems with images in question 59767456 and answer 59767698
            // snippets 62108080
        }
        .onDisappear {
            self.stackoverflowStore.questionStore.reload()
            self.stackoverflowStore.answersStore.reload()
        }
    }
}

// MARK: - Previews

#if DEBUG
struct QuestionDetailsView_Previews: PreviewProvider {
    static let model = QuestionItemModel(id: 56892691, title: "", isAnswered: false, viewCount: 0, answerCount: 0, score: 0, tags: [], link: URL(string: "google.com")!)
    static var previews: some View {
        Group {
            QuestionDetailsView(item: model)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(StackoverflowStore())
            
            QuestionDetailsView(item: model)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(StackoverflowStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension UIColor {
    static let navBurForeground = UIColor(named: "searchBarForeground")
}

fileprivate extension Color {
    static let background = Color("mainBackground")
}


fileprivate extension Image {
    static let share = Image(systemName: "square.and.arrow.up")
    static let reload = Image(systemName: "arrow.clockwise")
}

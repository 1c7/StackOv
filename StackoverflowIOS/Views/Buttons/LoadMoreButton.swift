//
//  LoadMoreButton.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 28/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct LoadMoreButton: View {
    @Binding var isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: { self.isLoading.toggle(); self.action() }) {
            HStack(alignment: .center, spacing: .zero) {
                Spacer()
                if !self.isLoading {
                    Text("Show next answers")
                        .fontWeight(.medium)
                        .frame(minHeight: 20)
                }
                if self.isLoading {
                    LoadingIndicatorView()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
            .foregroundColor(.foreground)
            .padding()
        }
        .background(Color.background)
        .cornerRadius(3)
        .padding(.horizontal, 16)
        .disabled(isLoading)
    }
    
    init(isLoading: Binding<Bool>, action: @escaping () -> Void) {
        self._isLoading = isLoading
        self.action = action
    }
}

// MARK: - Previews

#if DEBUG
struct LoadMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadMoreButton(isLoading: .constant(false), action: {})
                .padding()
                .background(Color.mainBackground)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            LoadMoreButton(isLoading: .constant(false), action: {})
                .padding()
                .background(Color.mainBackground)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

fileprivate extension Color {
    static let foreground = Color("loadMoreForeground")
    static let background = Color("loadMoreBackground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}

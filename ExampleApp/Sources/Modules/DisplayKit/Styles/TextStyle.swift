import Foundation
import SwiftUI

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.gray)
            .font(.largeTitle)
    }
}

struct HeadlineLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.black)
            .font(.headline)

    }
}

struct ActionLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.accentColor)
            .font(.subheadline)
    }
}

extension Text {
    var primary: ModifiedContent<Text, PrimaryLabel> {
        modifier(PrimaryLabel())
    }

    var headline: ModifiedContent<Text, HeadlineLabel> {
        modifier(HeadlineLabel())
    }

    var action: ModifiedContent<Text, ActionLabel> {
        modifier(ActionLabel())
    }
}

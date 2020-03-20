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

extension Text {
    var primary: ModifiedContent<Text, PrimaryLabel> {
        return modifier(PrimaryLabel())
    }
}

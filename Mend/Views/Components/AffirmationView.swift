import SwiftUI

private extension String {
    var mathItalicized: String {
        map { character in
            guard let scalar = character.unicodeScalars.first else { return character }

            switch scalar.value {
            case 65...90:
                return Character(UnicodeScalar(0x1D434 + scalar.value - 65)!)
            case 97...122:
                if scalar.value == 104 {
                    return Character("ℎ")
                }
                return Character(UnicodeScalar(0x1D44E + scalar.value - 97)!)
            default:
                return character
            }
        }
        .map(String.init)
        .joined()
    }
}

struct AffirmationView: View {
    @State private var selectedAffirmationIndex = 0

    private let affirmations = [
        "I am deeply beautiful, incredibly strong, and entirely whole.",
        "This pain is temporary; my strength is permanent.",
        "I am redirecting all my love back into myself.",
        "I am not broken; I am breaking through.",
        "Every single day, I am growing and evolving.",
        "My scars are just proof of my resilience.",
        "I choose to treat myself with radical kindness today.",
        "I hold the pen. I write my own beautiful future.",
        "I am worthy of the love I so freely give.",
        "I am rising, I am healing, and I am unstoppable."
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A gentle space to remember your strength.")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.darkCharcoal)

            
            TabView(selection: $selectedAffirmationIndex) {
                ForEach(affirmations.indices, id: \.self) { index in
                    VStack(spacing: 12) {
                        Text("\"\(affirmations[index].mathItalicized)\"")
                            .font(.title3.weight(.semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.darkCharcoal)
                            .padding(.horizontal, 10)

                        Text("\(index + 1) of \(affirmations.count)")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color.brandPrimary.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 20)
                    .background(
                        LinearGradient(
                            colors: [Color.white.opacity(0.92), Color.white.opacity(0.72)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.brandPrimary.opacity(0.18), lineWidth: 1)
                    )
                    .tag(index)
                    .padding(.horizontal, 4)
                }
            }
            .frame(height: 170)
            .tabViewStyle(.page(indexDisplayMode: .automatic))
        }
    }
}

#Preview {
    AffirmationView()
        .padding()
}

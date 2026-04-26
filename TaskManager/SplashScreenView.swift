import SwiftUI

struct SplashScreenView: View {
    var onFinished: () -> Void

    @State private var scale: CGFloat = 0.7
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)

                Text("Менеджер задач")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("У Вас всё под контролем")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(duration: 0.6)) {
                    scale = 1
                    opacity = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    onFinished()
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(onFinished: {})
}

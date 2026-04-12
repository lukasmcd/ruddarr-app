import SwiftUI

extension View {
    /// Presents an alert for a `LocalizedError`, triggering an error haptic
    /// notification the first time the alert becomes visible.
    func errorAlert<E, A, M>(
        isPresented: Binding<Bool>,
        error: E?,
        @ViewBuilder actions: @escaping (E) -> A,
        @ViewBuilder message: @escaping (E) -> M
    ) -> some View where E: LocalizedError, A: View, M: View {
        self
            .alert(
                isPresented: isPresented,
                error: error,
                actions: actions,
                message: message
            )
            .onChange(of: isPresented.wrappedValue) { _, newValue in
                guard newValue else { return }
                #if os(iOS)
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                #endif
            }
    }
}

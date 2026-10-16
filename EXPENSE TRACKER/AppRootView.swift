import SwiftUI

struct AppRootView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        
        SplashView()
    }
}

#Preview {
    AppRootView()
        .environmentObject(LanguageManager())
}

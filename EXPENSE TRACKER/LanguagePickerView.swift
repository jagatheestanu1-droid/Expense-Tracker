import SwiftUI

struct LanguagePickerView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(AppLanguage.allCases) { language in
                    
                    Button {
                        languageManager.selectedLanguage = language
                        dismiss()
                    } label: {
                        
                        HStack {
                            
                            Text(language.flag)
                                .font(.title2)
                            
                            Text(language.rawValue)
                                .font(.headline)
                            
                            Spacer()
                            
                            if languageManager.selectedLanguage == language {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .navigationTitle(
                languageManager.text(
                    english: "Choose Language",
                    hindi: "भाषा चुनें",
                    marathi: "भाषा निवडा",
                    urdu: "زبان منتخب کریں"
                )
            )
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button(
                        languageManager.text(
                            english: "Done",
                            hindi: "हो गया",
                            marathi: "झाले",
                            urdu: "مکمل"
                        )
                    ) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LanguagePickerView()
        .environmentObject(LanguageManager())
}

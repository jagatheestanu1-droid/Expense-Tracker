import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var showDeleteAlert = false
    
    @Query private var expenses: [Expense]
    @Query private var budgets: [Budget]
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - Header
                    
                    Text(
                        languageManager.text(
                            english: "Settings",
                            hindi: "सेटिंग्स",
                            marathi: "सेटिंग्ज",
                            urdu: "ترتیبات"
                        )
                    )
                    .font(.system(
                        size: 34,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    // MARK: - App Settings
                    
                    Text(
                        languageManager.text(
                            english: "App Settings",
                            hindi: "ऐप सेटिंग्स",
                            marathi: "अॅप सेटिंग्ज",
                            urdu: "ایپ سیٹنگز"
                        )
                    )
                    .font(.system(
                        size: 14,
                        weight: .semibold
                    ))
                    .foregroundStyle(
                        Color.white.opacity(0.5)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    // MARK: Language
                    
                    NavigationLink {
                        LanguagePickerView()
                            .environmentObject(languageManager)
                    } label: {
                        
                        HStack(spacing: 14) {
                            
                            ZStack {
                                
                                RoundedRectangle(
                                    cornerRadius: 14
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .cyan,
                                            .blue,
                                            .purple
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                
                                Image(systemName: "globe")
                                    .font(.system(
                                        size: 20,
                                        weight: .bold
                                    ))
                                    .foregroundStyle(.white)
                            }
                            .frame(
                                width: 50,
                                height: 50
                            )
                            
                            
                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {
                                
                                Text(
                                    languageManager.text(
                                        english: "Language",
                                        hindi: "भाषा",
                                        marathi: "भाषा",
                                        urdu: "زبان"
                                    )
                                )
                                .font(.system(
                                    size: 17,
                                    weight: .semibold
                                ))
                                .foregroundStyle(.white)
                                
                                Text(
                                    languageManager.selectedLanguage.rawValue
                                )
                                .font(.system(
                                    size: 13,
                                    weight: .medium
                                ))
                                .foregroundStyle(
                                    Color.white.opacity(0.45)
                                )
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(
                                    size: 13,
                                    weight: .bold
                                ))
                                .foregroundStyle(
                                    Color.white.opacity(0.35)
                                )
                        }
                        .padding(18)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .fill(
                            Color.white.opacity(0.055)
                        )
                    )
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .stroke(
                            Color.white.opacity(0.08),
                            lineWidth: 1
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    
                    // MARK: - Data
                    
                    Text(
                        languageManager.text(
                            english: "Data",
                            hindi: "डेटा",
                            marathi: "डेटा",
                            urdu: "ڈیٹا"
                        )
                    )
                    .font(.system(
                        size: 23,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    
                    // MARK: Delete All Data
                    
                    Button {
                        showDeleteAlert = true
                    } label: {
                        
                        HStack(spacing: 14) {
                            
                            ZStack {
                                
                                RoundedRectangle(
                                    cornerRadius: 14
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .red,
                                            .pink
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                
                                Image(systemName: "trash.fill")
                                    .font(.system(
                                        size: 20,
                                        weight: .bold
                                    ))
                                    .foregroundStyle(.white)
                            }
                            .frame(
                                width: 50,
                                height: 50
                            )
                            
                            
                            VStack(
                                alignment: .leading,
                                spacing: 5
                            ) {
                                
                                Text(
                                    languageManager.text(
                                        english: "Delete All Data",
                                        hindi: "सारा डेटा हटाएं",
                                        marathi: "सर्व डेटा हटवा",
                                        urdu: "تمام ڈیٹا حذف کریں"
                                    )
                                )
                                .font(.system(
                                    size: 17,
                                    weight: .semibold
                                ))
                                .foregroundStyle(.red)
                                
                                Text(
                                    languageManager.text(
                                        english: "Delete all expenses and budget data",
                                        hindi: "सभी खर्च और बजट डेटा हटाएं",
                                        marathi: "सर्व खर्च आणि बजेट डेटा हटवा",
                                        urdu: "تمام اخراجات اور بجٹ کا ڈیٹا حذف کریں"
                                    )
                                )
                                .font(.system(
                                    size: 12,
                                    weight: .medium
                                ))
                                .foregroundStyle(
                                    Color.white.opacity(0.45)
                                )
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(
                                    size: 13,
                                    weight: .bold
                                ))
                                .foregroundStyle(
                                    Color.white.opacity(0.3)
                                )
                        }
                        .padding(18)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .fill(
                            Color.red.opacity(0.055)
                        )
                    )
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .stroke(
                            Color.red.opacity(0.15),
                            lineWidth: 1
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    
                    // MARK: Warning
                    
                    HStack(
                        alignment: .top,
                        spacing: 10
                    ) {
                        
                        Image(
                            systemName: "exclamationmark.triangle.fill"
                        )
                        .foregroundStyle(.orange)
                        
                        Text(
                            languageManager.text(
                                english: "Deleting your data cannot be undone.",
                                hindi: "डेटा हटाने के बाद इसे वापस नहीं लाया जा सकता।",
                                marathi: "डेटा हटवल्यानंतर तो परत मिळवता येणार नाही.",
                                urdu: "ڈیٹا حذف کرنے کے بعد اسے واپس نہیں لایا جا سکتا۔"
                            )
                        )
                        .font(.system(
                            size: 12,
                            weight: .medium
                        ))
                        .foregroundStyle(
                            Color.white.opacity(0.45)
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    
                    
                    Spacer()
                        .frame(height: 35)
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        
        // MARK: - Delete Alert
        
        .alert(
            languageManager.text(
                english: "Delete All Data?",
                hindi: "सारा डेटा हटाएं?",
                marathi: "सर्व डेटा हटवायचा?",
                urdu: "تمام ڈیٹا حذف کریں؟"
            ),
            isPresented: $showDeleteAlert
        ) {
            
            Button(
                languageManager.text(
                    english: "Cancel",
                    hindi: "रद्द करें",
                    marathi: "रद्द करा",
                    urdu: "منسوخ کریں"
                ),
                role: .cancel
            ) {
                
            }
            
            Button(
                languageManager.text(
                    english: "Delete",
                    hindi: "हटाएं",
                    marathi: "हटवा",
                    urdu: "حذف کریں"
                ),
                role: .destructive
            ) {
                deleteAllData()
            }
            
        } message: {
            
            Text(
                languageManager.text(
                    english: "Are you sure? This action cannot be undone.",
                    hindi: "क्या आप निश्चित हैं? यह कार्रवाई वापस नहीं की जा सकती।",
                    marathi: "तुम्हाला खात्री आहे का? ही कृती पूर्ववत करता येणार नाही.",
                    urdu: "کیا آپ واقعی یہ کرنا چاہتے ہیں؟ یہ کارروائی واپس نہیں کی جا سکتی۔"
                )
            )
        }
    }
    
    
    // MARK: - Delete All Data
    
    private func deleteAllData() {
        
        for expense in expenses {
            modelContext.delete(expense)
        }
        
        for budget in budgets {
            modelContext.delete(budget)
        }
        
        try? modelContext.save()
    }
}


// MARK: - Preview

#Preview {
    
    SettingsView()
        .environmentObject(LanguageManager())
}

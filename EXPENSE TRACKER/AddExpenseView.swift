import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var amount = ""
    @State private var category = "Food"
    @State private var note = ""
    @State private var date = Date()
    
    let categories = [
        "Food",
        "Travel",
        "Shopping",
        "Education",
        "Others"
    ]
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: Header
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text(
                                languageManager.text(
                                    english: "Add Expense",
                                    hindi: "खर्च जोड़ें",
                                    marathi: "खर्च जोडा",
                                    urdu: "اخراجات شامل کریں"
                                )
                            )
                            .font(.system(
                                size: 32,
                                weight: .bold,
                                design: .rounded
                            ))
                            .foregroundStyle(.white)
                            
                            Text(
                                languageManager.text(
                                    english: "Track your spending easily",
                                    hindi: "अपने खर्च को आसानी से ट्रैक करें",
                                    marathi: "तुमचा खर्च सहज ट्रॅक करा",
                                    urdu: "اپنے اخراجات کو آسانی سے ٹریک کریں"
                                )
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
                        
                        Image(systemName: "plus")
                            .font(.system(
                                size: 20,
                                weight: .bold
                            ))
                            .foregroundStyle(.white)
                            .frame(
                                width: 48,
                                height: 48
                            )
                            .background(
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
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    // MARK: Amount Card
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(
                            languageManager.text(
                                english: "Amount",
                                hindi: "राशि",
                                marathi: "रक्कम",
                                urdu: "رقم"
                            )
                        )
                        .font(.system(
                            size: 14,
                            weight: .semibold
                        ))
                        .foregroundStyle(
                            Color.white.opacity(0.55)
                        )
                        
                        HStack(spacing: 10) {
                            
                            Text("₹")
                                .font(.system(
                                    size: 28,
                                    weight: .bold,
                                    design: .rounded
                                ))
                                .foregroundStyle(.cyan)
                            
                            TextField(
                                languageManager.text(
                                    english: "0.00",
                                    hindi: "0.00",
                                    marathi: "0.00",
                                    urdu: "0.00"
                                ),
                                text: $amount
                            )
                            .keyboardType(.decimalPad)
                            .font(.system(
                                size: 30,
                                weight: .bold,
                                design: .rounded
                            ))
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(20)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(
                        LinearGradient(
                            colors: [
                                Color.cyan.opacity(0.18),
                                Color.blue.opacity(0.15),
                                Color.purple.opacity(0.12)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 24
                        )
                    )
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 24
                        )
                        .stroke(
                            Color.cyan.opacity(0.18),
                            lineWidth: 1
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 25)
                    
                    
                    // MARK: Category
                    
                    Text(
                        languageManager.text(
                            english: "Category",
                            hindi: "श्रेणी",
                            marathi: "श्रेणी",
                            urdu: "زمرہ"
                        )
                    )
                    .font(.system(
                        size: 21,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    ScrollView(
                        .horizontal,
                        showsIndicators: false
                    ) {
                        
                        HStack(spacing: 12) {
                            
                            ForEach(
                                categories,
                                id: \.self
                            ) { item in
                                
                                categoryButton(
                                    item
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 12)
                    
                    
                    // MARK: Note
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {
                        
                        Text(
                            languageManager.text(
                                english: "Note",
                                hindi: "नोट",
                                marathi: "नोंद",
                                urdu: "نوٹ"
                            )
                        )
                        .font(.system(
                            size: 14,
                            weight: .semibold
                        ))
                        .foregroundStyle(
                            Color.white.opacity(0.55)
                        )
                        
                        TextField(
                            languageManager.text(
                                english: "What was this expense for?",
                                hindi: "यह खर्च किस लिए था?",
                                marathi: "हा खर्च कशासाठी होता?",
                                urdu: "یہ خرچ کس لیے تھا؟"
                            ),
                            text: $note
                        )
                        .font(.system(
                            size: 16,
                            weight: .medium
                        ))
                        .foregroundStyle(.white)
                        .padding(16)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 17
                            )
                            .fill(
                                Color.white.opacity(0.06)
                            )
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 17
                            )
                            .stroke(
                                Color.white.opacity(0.08),
                                lineWidth: 1
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    // MARK: Date
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {
                        
                        Text(
                            languageManager.text(
                                english: "Date",
                                hindi: "तारीख",
                                marathi: "तारीख",
                                urdu: "تاریخ"
                            )
                        )
                        .font(.system(
                            size: 14,
                            weight: .semibold
                        ))
                        .foregroundStyle(
                            Color.white.opacity(0.55)
                        )
                        
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .tint(.cyan)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(14)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 17
                            )
                            .fill(
                                Color.white.opacity(0.06)
                            )
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 17
                            )
                            .stroke(
                                Color.white.opacity(0.08),
                                lineWidth: 1
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                    
                    
                    // MARK: Buttons
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            saveExpense()
                        } label: {
                            
                            HStack {
                                
                                Image(
                                    systemName: "checkmark"
                                )
                                
                                Text(
                                    languageManager.text(
                                        english: "Save Expense",
                                        hindi: "खर्च सेव करें",
                                        marathi: "खर्च जतन करा",
                                        urdu: "اخراجات محفوظ کریں"
                                    )
                                )
                            }
                            .font(.system(
                                size: 17,
                                weight: .bold
                            ))
                            .foregroundStyle(.white)
                            .frame(
                                maxWidth: .infinity
                            )
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [
                                        .cyan,
                                        .blue,
                                        .purple
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 18
                                )
                            )
                        }
                        
                        
                        Button {
                            dismiss()
                        } label: {
                            
                            Text(
                                languageManager.text(
                                    english: "Cancel",
                                    hindi: "रद्द करें",
                                    marathi: "रद्द करा",
                                    urdu: "منسوخ کریں"
                                )
                            )
                            .font(.system(
                                size: 15,
                                weight: .semibold
                            ))
                            .foregroundStyle(
                                Color.white.opacity(0.55)
                            )
                            .frame(
                                maxWidth: .infinity
                            )
                            .padding(.vertical, 13)
                            .background(
                                Color.white.opacity(0.05)
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 16
                                )
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    Spacer()
                        .frame(height: 35)
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
    
    
    // MARK: - Category Button
    
    private func categoryButton(
        _ item: String
    ) -> some View {
        
        let isSelected = category == item
        
        return Button {
            category = item
        } label: {
            
            HStack(spacing: 8) {
                
                Image(
                    systemName: categoryIcon(item)
                )
                .font(.system(
                    size: 15,
                    weight: .bold
                ))
                
                Text(
                    translatedCategory(item)
                )
                .font(.system(
                    size: 14,
                    weight: .semibold
                ))
            }
            .foregroundStyle(
                isSelected
                ? .white
                : Color.white.opacity(0.6)
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(
                isSelected
                ? AnyShapeStyle(
                    LinearGradient(
                        colors: categoryColors(item),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                : AnyShapeStyle(
                    Color.white.opacity(0.06)
                )
            )
            .clipShape(
                Capsule()
            )
            .overlay {
                Capsule()
                    .stroke(
                        isSelected
                        ? Color.white.opacity(0.15)
                        : Color.white.opacity(0.08),
                        lineWidth: 1
                    )
            }
        }
        .buttonStyle(.plain)
    }
    
    
    // MARK: - Category Icon
    
    private func categoryIcon(
        _ category: String
    ) -> String {
        
        switch category {
            
        case "Food":
            return "fork.knife"
            
        case "Travel":
            return "car.fill"
            
        case "Shopping":
            return "bag.fill"
            
        case "Education":
            return "book.fill"
            
        default:
            return "ellipsis"
        }
    }
    
    
    // MARK: - Category Colors
    
    private func categoryColors(
        _ category: String
    ) -> [Color] {
        
        switch category {
            
        case "Food":
            return [.green, .mint]
            
        case "Travel":
            return [.purple, .blue]
            
        case "Shopping":
            return [.pink, .purple]
            
        case "Education":
            return [.orange, .yellow]
            
        default:
            return [.blue, .cyan]
        }
    }
    
    
    // MARK: - Category Translation
    
    private func translatedCategory(
        _ category: String
    ) -> String {
        
        switch category {
            
        case "Food":
            return languageManager.text(
                english: "Food",
                hindi: "भोजन",
                marathi: "अन्न",
                urdu: "کھانا"
            )
            
        case "Travel":
            return languageManager.text(
                english: "Travel",
                hindi: "यात्रा",
                marathi: "प्रवास",
                urdu: "سفر"
            )
            
        case "Shopping":
            return languageManager.text(
                english: "Shopping",
                hindi: "खरीदारी",
                marathi: "खरेदी",
                urdu: "خریداری"
            )
            
        case "Education":
            return languageManager.text(
                english: "Education",
                hindi: "शिक्षा",
                marathi: "शिक्षण",
                urdu: "تعلیم"
            )
            
        default:
            return languageManager.text(
                english: "Others",
                hindi: "अन्य",
                marathi: "इतर",
                urdu: "دیگر"
            )
        }
    }
    
    
    // MARK: - Save Expense
    
    private func saveExpense() {
        
        guard let amountValue = Double(amount),
              amountValue > 0 else {
            return
        }
        
        let newExpense = Expense(
            amount: amountValue,
            category: category,
            note: note,
            date: date
        )
        
        modelContext.insert(newExpense)
        
        try? modelContext.save()
        
        dismiss()
    }
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        AddExpenseView()
            .environmentObject(LanguageManager())
    }
}

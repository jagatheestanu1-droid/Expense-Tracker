import SwiftUI
import SwiftData

struct EditExpenseView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    
    var expense: Expense
    
    @State private var amount: String
    @State private var category: String
    @State private var note: String
    @State private var date: Date
    
    @State private var showError = false
    
    let categories = [
        "Food",
        "Travel",
        "Shopping",
        "Education",
        "Others"
    ]
    
    init(expense: Expense) {
        
        self.expense = expense
        
        _amount = State(
            initialValue: String(expense.amount)
        )
        
        _category = State(
            initialValue: expense.category
        )
        
        _note = State(
            initialValue: expense.note
        )
        
        _date = State(
            initialValue: expense.date
        )
    }
    
    var body: some View {
        
        Form {
            
            Section {
                
                TextField(
                    languageManager.text(
                        english: "Amount",
                        hindi: "राशि",
                        marathi: "रक्कम",
                        urdu: "رقم"
                    ),
                    text: $amount
                )
                .keyboardType(.decimalPad)
                
                TextField(
                    languageManager.text(
                        english: "Description",
                        hindi: "विवरण",
                        marathi: "वर्णन",
                        urdu: "تفصیل"
                    ),
                    text: $note
                )
                
                Picker(
                    languageManager.text(
                        english: "Category",
                        hindi: "श्रेणी",
                        marathi: "श्रेणी",
                        urdu: "زمرہ"
                    ),
                    selection: $category
                ) {
                    
                    ForEach(categories, id: \.self) { item in
                        
                        Text(translatedCategory(item))
                            .tag(item)
                    }
                }
                
                DatePicker(
                    languageManager.text(
                        english: "Date",
                        hindi: "तारीख",
                        marathi: "तारीख",
                        urdu: "تاریخ"
                    ),
                    selection: $date,
                    displayedComponents: .date
                )
            }
            
            Section {
                
                Button {
                    saveChanges()
                } label: {
                    
                    Text(
                        languageManager.text(
                            english: "Save Changes",
                            hindi: "बदलाव सेव करें",
                            marathi: "बदल जतन करा",
                            urdu: "تبدیلیاں محفوظ کریں"
                        )
                    )
                }
            }
        }
        .navigationTitle(
            languageManager.text(
                english: "Edit Expense",
                hindi: "खर्च संपादित करें",
                marathi: "खर्च संपादित करा",
                urdu: "اخراجات میں ترمیم کریں"
            )
        )
        .alert(
            languageManager.text(
                english: "Invalid Amount",
                hindi: "गलत राशि",
                marathi: "अवैध रक्कम",
                urdu: "غلط رقم"
            ),
            isPresented: $showError
        ) {
            Button(
                languageManager.text(
                    english: "OK",
                    hindi: "ठीक है",
                    marathi: "ठीक आहे",
                    urdu: "ٹھیک ہے"
                )
            ) {
                showError = false
            }
        } message: {
            Text(
                languageManager.text(
                    english: "Please enter an amount greater than 0.",
                    hindi: "कृपया 0 से अधिक राशि दर्ज करें।",
                    marathi: "कृपया 0 पेक्षा जास्त रक्कम प्रविष्ट करा.",
                    urdu: "براہ کرم 0 سے زیادہ رقم درج کریں۔"
                )
            )
        }
    }
    
    private func saveChanges() {
        
        guard let newAmount = Double(amount),
              newAmount > 0 else {
            showError = true
            return
        }
        
        expense.amount = newAmount
        expense.category = category
        expense.note = note
        expense.date = date
        
        try? modelContext.save()
        
        dismiss()
    }
    
    private func translatedCategory(_ category: String) -> String {
        
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
}

#Preview {
    Text("Edit Expense Preview")
}

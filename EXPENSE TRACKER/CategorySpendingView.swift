import SwiftUI
import SwiftData

struct CategorySpendingView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var expenses: [Expense]
    
    private let categories = [
        "Food",
        "Travel",
        "Shopping",
        "Education",
        "Others"
    ]
    
    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: Header
                    
                    Text(languageManager.text(
                        english: "All Spending",
                        hindi: "सभी खर्च",
                        marathi: "सर्व खर्च",
                        urdu: "تمام اخراجات"
                    ))
                    .font(.system(
                        size: 32,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    // MARK: Total Spending Card
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(languageManager.text(
                            english: "Total Spent",
                            hindi: "कुल खर्च",
                            marathi: "एकूण खर्च",
                            urdu: "کل خرچ"
                        ))
                        .font(.system(
                            size: 14,
                            weight: .medium
                        ))
                        .foregroundStyle(Color.white.opacity(0.55))
                        
                        Text(
                            "₹\(totalSpent, specifier: "%.2f")"
                        )
                        .font(.system(
                            size: 34,
                            weight: .bold,
                            design: .rounded
                        ))
                        .foregroundStyle(.white)
                        
                        HStack(spacing: 6) {
                            
                            Image(systemName: "chart.bar.fill")
                                .foregroundStyle(.cyan)
                            
                            Text(languageManager.text(
                                english: "Category-wise spending",
                                hindi: "श्रेणी के अनुसार खर्च",
                                marathi: "श्रेणीनुसार खर्च",
                                urdu: "زمرے کے لحاظ سے اخراجات"
                            ))
                            .font(.system(
                                size: 13,
                                weight: .medium
                            ))
                            .foregroundStyle(Color.white.opacity(0.5))
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.25),
                                Color.purple.opacity(0.18),
                                Color.pink.opacity(0.12)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                Color.white.opacity(0.08),
                                lineWidth: 1
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                    
                    
                    // MARK: Category Title
                    
                    Text(languageManager.text(
                        english: "Categories",
                        hindi: "श्रेणियां",
                        marathi: "श्रेणी",
                        urdu: "زمرے"
                    ))
                    .font(.system(
                        size: 23,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    // MARK: Category Cards
                    
                    VStack(spacing: 14) {
                        
                        ForEach(categories, id: \.self) { category in
                            
                            NavigationLink {
                                CategoryExpenseListView(
                                    category: category
                                )
                            } label: {
                                spendingCard(
                                    category: category
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 12)
                    
                    
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
    
    
    // MARK: - Spending Card
    
    private func spendingCard(
        category: String
    ) -> some View {
        
        let total = expenses
            .filter {
                $0.category == category
            }
            .reduce(0) {
                $0 + $1.amount
            }
        
        let percentage: Double = {
            
            guard totalSpent > 0 else {
                return 0
            }
            
            return (total / totalSpent) * 100
        }()
        
        return VStack(spacing: 13) {
            
            HStack(spacing: 14) {
                
                // Category Icon
                
                ZStack {
                    
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: categoryColors(category),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Image(systemName: categoryIcon(category))
                        .font(.system(
                            size: 21,
                            weight: .bold
                        ))
                        .foregroundStyle(.white)
                }
                .frame(
                    width: 58,
                    height: 58
                )
                
                
                // Category Name + Amount
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    
                    Text(
                        translatedCategory(category)
                    )
                    .font(.system(
                        size: 17,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    
                    Text(
                        "₹\(total, specifier: "%.2f")"
                    )
                    .font(.system(
                        size: 14,
                        weight: .medium
                    ))
                    .foregroundStyle(
                        Color.white.opacity(0.55)
                    )
                }
                
                Spacer()
                
                
                // Percentage
                
                Text(
                    "\(Int(percentage))%"
                )
                .font(.system(
                    size: 13,
                    weight: .bold
                ))
                .foregroundStyle(
                    categoryColors(category)[0]
                )
                .padding(.horizontal, 11)
                .padding(.vertical, 7)
                .background(
                    Capsule()
                        .fill(
                            categoryColors(category)[0]
                                .opacity(0.12)
                        )
                )
            }
            
            
            // Progress Bar
            
            GeometryReader { geometry in
                
                ZStack(alignment: .leading) {
                    
                    Capsule()
                        .fill(
                            Color.white.opacity(0.08)
                        )
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: categoryColors(category),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: geometry.size.width
                                * CGFloat(
                                    min(percentage / 100, 1)
                                )
                        )
                }
            }
            .frame(height: 7)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 21)
                .fill(
                    Color.white.opacity(0.055)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 21)
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
        }
        .padding(.horizontal, 20)
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
    
    
    // MARK: - Translation
    
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
}


// MARK: - Category Expense List

struct CategoryExpenseListView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var allExpenses: [Expense]
    
    let category: String
    
    var categoryExpenses: [Expense] {
        allExpenses
            .filter { $0.category == category }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Header
                    
                    HStack {
                        
                        Text(
                            translatedCategory(category)
                        )
                        .font(.system(
                            size: 30,
                            weight: .bold,
                            design: .rounded
                        ))
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(systemName: categoryIcon(category))
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
                                    colors: categoryColors(category),
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
                    
                    
                    // Total
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(languageManager.text(
                            english: "Total Spent",
                            hindi: "कुल खर्च",
                            marathi: "एकूण खर्च",
                            urdu: "کل خرچ"
                        ))
                        .font(.system(
                            size: 13,
                            weight: .medium
                        ))
                        .foregroundStyle(
                            Color.white.opacity(0.5)
                        )
                        
                        Text(
                            "₹\(categoryExpenses.reduce(0) { $0 + $1.amount }, specifier: "%.2f")"
                        )
                        .font(.system(
                            size: 28,
                            weight: .bold,
                            design: .rounded
                        ))
                        .foregroundStyle(.white)
                    }
                    .padding(18)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(
                        Color.white.opacity(0.055)
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 20
                        )
                    )
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 20
                        )
                        .stroke(
                            Color.white.opacity(0.08),
                            lineWidth: 1
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    // Expenses
                    
                    Text(languageManager.text(
                        english: "Expenses",
                        hindi: "खर्च",
                        marathi: "खर्च",
                        urdu: "اخراجات"
                    ))
                    .font(.system(
                        size: 22,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    
                    if categoryExpenses.isEmpty {
                        
                        VStack(spacing: 12) {
                            
                            Image(systemName: "tray")
                                .font(.system(
                                    size: 38,
                                    weight: .medium
                                ))
                                .foregroundStyle(
                                    Color.white.opacity(0.35)
                                )
                            
                            Text(languageManager.text(
                                english: "No expenses in this category",
                                hindi: "इस श्रेणी में कोई खर्च नहीं है",
                                marathi: "या श्रेणीमध्ये कोणताही खर्च नाही",
                                urdu: "اس زمرے میں کوئی اخراجات نہیں ہیں"
                            ))
                            .font(.system(
                                size: 15,
                                weight: .medium
                            ))
                            .foregroundStyle(
                                Color.white.opacity(0.5)
                            )
                            .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 60)
                        
                    } else {
                        
                        VStack(spacing: 12) {
                            
                            ForEach(categoryExpenses) { expense in
                                
                                expenseRow(expense)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 14)
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
    
    
    // MARK: - Expense Row
    
    private func expenseRow(
        _ expense: Expense
    ) -> some View {
        
        HStack(spacing: 14) {
            
            Image(systemName: categoryIcon(category))
                .font(.system(
                    size: 19,
                    weight: .bold
                ))
                .foregroundStyle(.white)
                .frame(
                    width: 46,
                    height: 46
                )
                .background(
                    LinearGradient(
                        colors: categoryColors(category),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 13
                    )
                )
            
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(
                    expense.note.isEmpty
                    ? translatedCategory(category)
                    : expense.note
                )
                .font(.system(
                    size: 16,
                    weight: .semibold
                ))
                .foregroundStyle(.white)
                .lineLimit(1)
                
                Text(
                    expense.date.formatted(
                        date: .abbreviated,
                        time: .omitted
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
            
            Text(
                "₹\(expense.amount, specifier: "%.2f")"
            )
            .font(.system(
                size: 16,
                weight: .bold,
                design: .rounded
            ))
            .foregroundStyle(.white)
        }
        .padding(13)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    Color.white.opacity(0.055)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    Color.white.opacity(0.07),
                    lineWidth: 1
                )
        }
    }
    
    
    // MARK: - Helpers
    
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
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        CategorySpendingView()
            .environmentObject(LanguageManager())
    }
}

import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    
    case english = "English"
    case hindi = "हिंदी"
    case marathi = "मराठी"
    case urdu = "اردو"
    
    var id: String {
        rawValue
    }
    
    var flag: String {
        switch self {
        case .english:
            return "🇬🇧"
        case .hindi:
            return "🇮🇳"
        case .marathi:
            return "🇮🇳"
        case .urdu:
            return "🕌"
        }
    }
}

final class LanguageManager: ObservableObject {
    
    @Published var selectedLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(
                selectedLanguage.rawValue,
                forKey: "selectedLanguage"
            )
        }
    }
    
    @Published var hasCompletedOnboarding: Bool
    
    init() {
        
        if let savedLanguage = UserDefaults.standard.string(
            forKey: "selectedLanguage"
        ),
        let language = AppLanguage(rawValue: savedLanguage) {
            
            selectedLanguage = language
            
        } else {
            
            selectedLanguage = .english
        }
        
        // TEMPORARY: Start onboarding again for testing
        hasCompletedOnboarding = false
    }
    
    func completeOnboarding() {
        
        UserDefaults.standard.set(
            true,
            forKey: "hasCompletedOnboarding"
        )
        
        hasCompletedOnboarding = true
    }
    
    func resetOnboarding() {
        
        UserDefaults.standard.set(
            false,
            forKey: "hasCompletedOnboarding"
        )
        
        hasCompletedOnboarding = false
    }
    
    func text(
        english: String,
        hindi: String,
        marathi: String,
        urdu: String
    ) -> String {
        
        switch selectedLanguage {
        case .english:
            return english
        case .hindi:
            return hindi
        case .marathi:
            return marathi
        case .urdu:
            return urdu
        }
    }
    
    var dashboard: String {
        text(
            english: "Dashboard",
            hindi: "डैशबोर्ड",
            marathi: "डॅशबोर्ड",
            urdu: "ڈیش بورڈ"
        )
    }
    
    var totalSpent: String {
        text(
            english: "Total Spent",
            hindi: "कुल खर्च",
            marathi: "एकूण खर्च",
            urdu: "کل خرچ"
        )
    }
    
    var recentExpenses: String {
        text(
            english: "Recent Expenses",
            hindi: "हाल के खर्च",
            marathi: "अलीकडील खर्च",
            urdu: "حالیہ اخراجات"
        )
    }
    
    var monthlyBudget: String {
        text(
            english: "Monthly Budget",
            hindi: "मासिक बजट",
            marathi: "मासिक बजेट",
            urdu: "ماہانہ بجٹ"
        )
    }
    
    var spendingChart: String {
        text(
            english: "Spending Chart",
            hindi: "खर्च चार्ट",
            marathi: "खर्चाचा चार्ट",
            urdu: "خرچ کا چارٹ"
        )
    }
    
    var clearTestData: String {
        text(
            english: "Clear Test Data",
            hindi: "टेस्ट डेटा साफ करें",
            marathi: "टेस्ट डेटा साफ करा",
            urdu: "ٹیسٹ ڈیٹا صاف کریں"
        )
    }
    
    var addExpense: String {
        text(
            english: "＋ Add Expense",
            hindi: "＋ खर्च जोड़ें",
            marathi: "＋ खर्च जोडा",
            urdu: "＋ خرچ شامل کریں"
        )
    }
    
    var searchExpenses: String {
        text(
            english: "Search expenses",
            hindi: "खर्च खोजें",
            marathi: "खर्च शोधा",
            urdu: "اخراجات تلاش کریں"
        )
    }
    
    var noExpenses: String {
        text(
            english: "No expenses yet",
            hindi: "अभी कोई खर्च नहीं है",
            marathi: "अजून कोणतेही खर्च नाहीत",
            urdu: "ابھی کوئی اخراجات نہیں ہیں"
        )
    }
    
    var noMatchingExpenses: String {
        text(
            english: "No matching expenses",
            hindi: "कोई मिलान वाला खर्च नहीं मिला",
            marathi: "जुळणारे कोणतेही खर्च सापडले नाहीत",
            urdu: "کوئی مماثل اخراجات نہیں ملے"
        )
    }
}

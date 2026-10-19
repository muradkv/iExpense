# iExpense

![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

A sleek, persistent personal and business expense tracker built natively with SwiftUI. 

The app allows users to quickly add expenses, categorizes them automatically, formats currency based on the device's locale, and securely saves the data across launches using local storage.

## Preview
<img width="25%" alt="Start" src="https://github.com/user-attachments/assets/393a9520-8a6d-42eb-8ee6-8ce0b1ed1ffe" />
<img width="25%" alt="Add" src="https://github.com/user-attachments/assets/87f2302d-daed-46a5-9e4f-9bc4698284f9" />
<img width="25%" alt="End" src="https://github.com/user-attachments/assets/42837896-51ea-463b-adc2-f25539bf23ae" />

## Features

### Core Capabilities (v1.0.0+ Baseline)
* **Smart Categorization:** Expenses are automatically grouped into distinct "Personal" and "Business" sections within the list interface.
* **Dynamic Styling:** Visual hierarchy automatically highlights significant expenses (e.g., amounts over $100 are bold and colored red) for quick scannability.
* **Locale-Aware Formatting:** Prices and currency markers are dynamically formatted based on the user's active device region and system language.
* **Safe Swipe-Deletion:** Features responsive swipe-to-delete interaction, resolving internal index mismatch bugs via strict UUID tracking.

### Advanced Data Management (v2.0.0+ SwiftData Upgrade)
* **Persistent SQLite Storage:** Replaced volatile file persistence with a high-performance local SQLite database handled natively by `SwiftData`.
* **Runtime List Sorting:** Users can instantly reorder the main timeline by expense Name or numeric Amount directly via toolbar interactions.
* **Contextual Predicate Filtering:** Implemented rapid database-level category switches ('All', 'Personal Only', 'Business Only') without loading unnecessary objects into memory.
* **Native Empty State UX:** Integrates `ContentUnavailableView` placeholders that dynamically instruct the user when the entry tracking log is empty.
* **VoiceOver Accessibility:** Grouped expense rows announce the item name and localized currency amount in a single swipe, followed by the expense category as an accessibility hint.

## About the Project & Challenge

This application was built to fulfill **Project 7 (Days 36-38)** of the SwiftUI learning path created by Paul Hudson (Hacking with Swift). 

Beyond the core tutorial, the codebase underwent architectural refactoring to master modern iOS application design and clean code principles. Key topics practiced and implemented include:

* **Modern State Management:** Transitioned to the modern iOS 17 `@Observable` macro to create a central, reactive `Expenses` ViewModel, simplifying data flow.
* **Data Persistence & Codable:** Leveraged `UserDefaults` combined with `JSONEncoder`/`JSONDecoder`. The save logic is encapsulated inside a `didSet` property observer, keeping the UI layer completely unaware of the storage mechanism.
* **Separation of Concerns:** Broke down a massive UI into stateless, reusable components (like `ExpenseRowView`) and separated logic into Models, ViewModels, and Views.
* **Type Safety & Encapsulation:** Replaced "stringly-typed" categories with an `ExpenseType` Enum (`CaseIterable`, `Identifiable`, `Codable`). Applied `private(set)` access modifiers to protect data integrity from unintended UI mutations.
* **Safe Deletion Logic:** Resolved the filtered-list index mismatch bug by implementing deletion based on unique `UUID`s rather than temporary UI offsets.

Later, the project was upgraded during **Project 12 (Days 57-59)** to completely migrate the persistence layer to `SwiftData` and complete three advanced database challenges:
1. **Dynamic Sorting:** Implemented toolbar-driven sorting options allowing users to sort expenses by Name or Amount at runtime.
2. **Dynamic Filtering:** Added category filter selectors to display 'All', 'Personal Only', or 'Business Only' records.
3. **Database Architecture:** Resolved engine limitations of macro `#Predicate` with custom string-based model properties to filter rows efficiently.

Finally, during **Project 15 (Day 76 — Accessibility)**, `ExpenseRowView` was enhanced for screen readers by combining each row into a single accessibility element that announces the expense name and formatted currency value in one `.accessibilityLabel` while exposing the category type via `.accessibilityHint`.

Beyond the tutorial curriculum, the codebase underwent architectural refactoring to master clean MVVM design and robust error handling in SwiftData context operations.

🔗 **Original Project:** [Project 7 Description](https://www.hackingwithswift.com/100/swiftui/36)  
🔗 **SwiftData Upgrade:** [Project 12 Challenges](https://www.hackingwithswift.com/books/ios-swiftui/swiftdata-wrap-up)
🔗 **Accessibility Upgrade:** [Project 15 Challenges (Day 76)](https://www.hackingwithswift.com/100/swiftui/76)

## Project Versioning & Changelog

**v2.2.0 (VoiceOver Accessibility Integration)** — commit: `144c22a`  
Completed the Day 76 accessibility challenge. Grouped `ExpenseRowView` elements into a single VoiceOver element that reads out the expense name and locale-formatted currency amount in one label, and provides the expense category (`Personal` or `Business`) as a hint.

**v2.1.0 (Clean Architecture & Layout Polish)** — commit: `01e920c`  
Moved model instantiating from AddExpenseView into the ViewModel. Replaced duplicate layout structures with a single `@ViewBuilder` helper. Fixed data synchronization bugs with forced model context saves and integrated `ContentUnavailableView` placeholders.

**v2.0.0 (SwiftData Engine Integration)** — commit: `1f5ee77`  
Major data layer modernization. Replaced UserDefaults with SwiftData engine by transforming ExpenseItem into a `@Model` class. Created a dynamic subview initialization flow to manage dynamic sorting and macro `#Predicate` category filtering.

**v1.2.0 (MVVM & Type Safety Refactoring)** — commit: `9f41d2a`  
Refactored the codebase to follow clean MVVM principles. Removed loose properties from views, replaced stringly-typed categories with a type-safe `ExpenseType` enum, unified array deletion hooks, and reorganised the folder layout.

**v1.1.0 (Section Split & Dynamic Styling)** — commit: `e87da9e`  
Split the expense list layout into distinct Personal and Business sections. Extracted view rows into a modular `ExpenseRowView` component and added dynamic text styling to highlight costs above $10 and $100 thresholds.

**v1.0.0 (Functional MVP baseline)** — commit: `62c84e3`  
Initial baseline implementation of the core course curriculum. Designed base user interfaces with ContentView and AddView sheets, supported local system region currency formatting, and implemented data persistence via `UserDefaults` with JSON encoders.

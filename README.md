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

* **Smart Categorization:** Expenses are automatically grouped into "Personal" and "Business" sections within the list.
* **Persistent Storage:** Data is saved instantly and seamlessly in the background using `UserDefaults`.
* **Dynamic Styling:** Visual hierarchy highlights significant expenses (e.g., amounts over $100 are bold and colored red) for quick scannability.
* **Locale-Aware Formatting:** Currency is dynamically formatted based on the user's system region and language settings.
* **List Management:** Intuitive swipe-to-delete functionality with safe item removal.

## About the Project & Challenge

This application was built to fulfill **Project 7 (Days 36-38)** of the SwiftUI learning path created by Paul Hudson (Hacking with Swift). 

Beyond the core tutorial, the codebase underwent architectural refactoring to master modern iOS application design and clean code principles. Key topics practiced and implemented include:

* **Modern State Management:** Transitioned to the modern iOS 17 `@Observable` macro to create a central, reactive `Expenses` ViewModel, simplifying data flow.
* **Data Persistence & Codable:** Leveraged `UserDefaults` combined with `JSONEncoder`/`JSONDecoder`. The save logic is encapsulated inside a `didSet` property observer, keeping the UI layer completely unaware of the storage mechanism.
* **Separation of Concerns:** Broke down a massive UI into stateless, reusable components (like `ExpenseRowView`) and separated logic into Models, ViewModels, and Views.
* **Type Safety & Encapsulation:** Replaced "stringly-typed" categories with an `ExpenseType` Enum (`CaseIterable`, `Identifiable`, `Codable`). Applied `private(set)` access modifiers to protect data integrity from unintended UI mutations.
* **Safe Deletion Logic:** Resolved the filtered-list index mismatch bug by implementing deletion based on unique `UUID`s rather than temporary UI offsets.

🔗 **[Full project description here](https://www.hackingwithswift.com/100/swiftui/36)**

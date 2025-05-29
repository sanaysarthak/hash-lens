# 🔍 Hash Lens

## 📋 Overview

Hash Lens is a modern, user‑friendly Flutter app for generating and comparing cryptographic hashes of text (with file hashing coming soon). It provides a clean dark‑themed interface, letting users select from multiple hash algorithms, compute hashes, and verify matches.


## ✨ Key Features

- 🔑 **Algorithm Selection**: Choose from MD5, SHA-1, SHA-256, and SHA-512.
- 📝 **Text Hashing**: Enter any text and generate its cryptographic hash.
- 📋 **Copy & Compare**: Copy the result to clipboard, paste another hash, and verify match/mismatch.
- 🎨 **Dark Theme**: Sleek, high‑contrast UI built with Flutter’s Material components.
- ⚙️ **Expandable**: Stubbed “File” tab with file hashing planned next.
- 🚀 **Responsive**: Works on both Android and iOS with adaptive layouts.


## 🛠️ Technical Implementation

The system is built using:
- **Framework**: Flutter with MaterialApp and TabController.
- **Hashing**: Uses Dart’s ```crypto``` package and ```dart:convert``` for MD5, SHA‑1, SHA‑256, SHA‑512.
- **State Management**: ```StatefulWidget``` for interactive hash generation and comparison.
- **Clipboard**: ```Clipboard.setData``` to copy hashes, with ```SnackBar``` notifications.


## ⚡ Getting Started

1. **Clone the repository**:
   ```sh
   git clone https://github.com/sanaysarthak/hash-lens.git
   cd hash-lens
   ```
   
2. **Install dependencies**:
   
   Ensure ```crypto``` is in ```pubspec.yaml```:
   ```sh
   dependencies:
     flutter:
       sdk: flutter
     crypto: ^3.0.3
   ```
   Fetch packages:
   ```sh
   flutter pub get
   ```
   
3. **Run the app**:
   ```sh
   flutter run
   ```

   
## 📱 Usage

1. Select the **Text** tab.
2. Choose a hash algorithm from the dropdown.
3. Enter text into the input field.
4. Tap **Generate Hash** to compute and display the digest.
5. (Optional) Tap the copy icon to copy to clipboard.
6. Paste a hash into the comparison field and tap **Compare Hashes**.
7. A dialog shows **Hashes match!** (green) or **Hashes do not match.** (red).


## 🚀 Future Enhancements

- 📂 **File Hashing**: Support for selecting files and computing their hashes.
- 🔍 **Auto‑Detect Algorithm**: Identify algorithm by pasted hash length/format.
- 🕑 **History**: Save recent hash computations for quick re‑access.
- 🌐 **Localization**: Multi‑language support.
- ☁️ **Cloud Sync**: Store history across devices.


## 🤝 Contributing

Contributions and improvements are welcome! Please open an issue or submit a pull request.


## 📄 License

This project is licensed under the BSD-3-Clause license. See LICENSE for details.


⭐ If you find Hash Lens useful, please give it a star! ⭐

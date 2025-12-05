# Union Shop 🛍️

A modern, fully-featured e-commerce Flutter application for the University of Portsmouth Student Union shop. This mobile-first application provides a seamless shopping experience with authentication, cart management, product browsing, and personalized merchandise options.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?style=flat&logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Integrated-FFCA28?style=flat&logo=firebase)
![Tests](https://img.shields.io/badge/Tests-201%20Passing-success?style=flat)

## 📱 Overview

Union Shop is a cross-platform e-commerce application that replicates the [UPSU Shop](https://shop.upsu.net) functionality with enhanced features including:

- 🏠 **Dynamic Homepage** with featured products and collections
- 🛒 **Shopping Cart** with persistent storage
- 🔐 **Authentication System** (Email, Google, Apple Sign-In)
- 🔍 **Product Search** functionality
- 🎨 **Print Shack** - Custom merchandise personalization
- 💳 **Checkout System** with order management
- 📱 **Responsive Design** - Optimized for mobile and desktop
- 💾 **Data Persistence** using SharedPreferences

## ✨ Key Features

### User Authentication
- Email/password authentication
- Google Sign-In integration
- Apple Sign-In support
- User profile management with Firestore
- Password reset functionality

### Shopping Experience
- Browse multiple product collections (Hoodies, Sportswear, Stationery, Gifts, etc.)
- Advanced filtering and sorting (by price, name, popularity)
- Pagination for large product catalogs
- Product detail pages with image galleries
- Color and size selection for products
- Real-time cart updates with badge notifications

### Cart & Checkout
- Add/remove items with quantity management
- Automatic price calculations (subtotal, 20% VAT, shipping)
- Free shipping on orders over £50
- Persistent cart storage across sessions
- Order summary and checkout flow

### Print Shack Personalization
- Custom text personalization for merchandise
- Dynamic preview updates
- Multiple line support with character limits
- Font style and color selection
- Product type and garment color options

### Additional Features
- Global search across all products
- Sale items with promotional pricing
- About pages with company information
- Responsive navigation with mobile menu
- Footer with opening hours and links

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.0 or higher) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (2.17 or higher) - Included with Flutter
- **Git** - [Install Git](https://git-scm.com/downloads)
- **Code Editor** - VS Code or Android Studio recommended
- **Firebase Account** (optional for authentication features)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ibnoucheikhalae/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase (Optional)**
   
   If you want to use authentication features:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable Authentication (Email/Password, Google, Apple)
   - Enable Firestore Database
   - Download configuration files and update `lib/main.dart` with your Firebase credentials

4. **Run the application**
   ```bash
   flutter run
   ```

   Or for web:
   ```bash
   flutter run -d chrome
   ```

### Running Tests

The project includes 201 comprehensive tests covering:
- Unit tests for models and services
- Widget tests for UI components
- Integration tests for complete user flows
- Edge case testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/cart_test.dart
```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── data/                     # Data layer
│   ├── dummy_collections.dart
│   └── dummy_products.dart
├── models/                   # Data models
│   ├── cart_item.dart
│   ├── collection.dart
│   └── product.dart
├── pages/                    # Screen/Page widgets
│   ├── home_page.dart
│   ├── collections_page.dart
│   ├── collection_view_page.dart
│   ├── product_page.dart
│   ├── cart_page.dart
│   ├── checkout_page.dart
│   ├── login_page.dart
│   ├── signup_page.dart
│   ├── account_page.dart
│   ├── search_page.dart
│   ├── sale_page.dart
│   ├── about_page.dart
│   ├── personalisation_page.dart
│   └── printshack_about_page.dart
├── services/                 # Business logic layer
│   ├── auth_service.dart
│   ├── cart_service.dart
│   └── search_service.dart
└── widgets/                  # Reusable UI components
    ├── app_header.dart
    ├── footer.dart
    ├── collection_card.dart
    └── product_card.dart

test/
├── cart_test.dart           # Cart functionality tests
├── cart_service_test.dart   # Cart service unit tests
├── cart_item_test.dart      # Cart item model tests
├── cart_edge_cases_test.dart
├── search_service_test.dart # Search functionality tests
├── search_edge_cases_test.dart
├── models_test.dart         # Data model tests
├── widgets_test.dart        # Widget tests
├── integration_test.dart    # End-to-end tests
├── footer_test.dart
└── pages/                   # Page-specific tests
    ├── home_page_test.dart
    ├── cart_page_test.dart
    ├── product_page_test.dart
    └── ... (14 page test files)
```

## 🛠️ Technologies & Dependencies

### Core Framework
- **Flutter** - UI framework
- **Dart** - Programming language

### Key Packages
- **firebase_core** (^3.8.1) - Firebase initialization
- **firebase_auth** (^5.3.4) - Authentication
- **cloud_firestore** (^5.5.1) - Cloud database
- **google_sign_in** (^6.2.2) - Google authentication
- **sign_in_with_apple** (^6.1.3) - Apple authentication
- **shared_preferences** (^2.2.2) - Local data persistence
- **google_fonts** (^6.1.0) - Poppins font family
- **url_launcher** (^6.2.0) - External URL handling

### Development Tools
- **flutter_test** - Testing framework
- **flutter_lints** - Code analysis and linting

## 💻 Usage

### Basic Navigation

1. **Homepage** - View featured products and collections
2. **Shop Dropdown** - Access product categories (Hoodies, Sportswear, etc.)
3. **Search Icon** - Search for specific products
4. **Cart Icon** - View shopping cart (shows item count badge)
5. **Account Icon** - Login or access account dashboard

### Shopping Flow

1. Browse collections or search for products
2. Click on a product to view details
3. Select color and size options
4. Choose quantity and click "Add to Cart"
5. Review cart items and quantities
6. Proceed to checkout
7. Complete order (demo - no real payment processing)

### Personalization (Print Shack)

1. Navigate to "The Print Shack" from menu
2. Select product type (Hoodie, T-Shirt, Bag)
3. Choose garment color and print position
4. Enter personalized text (up to 3 lines)
5. Select font style and color
6. Preview updates dynamically
7. Add to cart with chosen customizations

### Account Management

1. Sign up with email or social login
2. Complete profile information
3. View and edit profile details
4. Update contact information and address
5. Sign out when finished

## 📸 Screenshots

*Note: Add screenshots of your application here to showcase key features*

```
[Homepage] [Collections] [Product Page]
[Cart] [Checkout] [Account Dashboard]
```

## 🧪 Testing

The application has **201 passing tests** covering:

- **Unit Tests**: Models, services, data structures
- **Widget Tests**: UI components, pages, navigation
- **Integration Tests**: Complete user workflows
- **Edge Cases**: Boundary conditions, error handling

Test coverage includes:
- Cart operations (add, remove, update, persistence)
- Authentication flows
- Search functionality
- Product filtering and sorting
- Responsive layout behavior
- Form validation

## 🐛 Known Issues & Limitations

### Current Limitations
- **Demo Payment**: Checkout is simulated - no real payment gateway integration
- **Placeholder Images**: Some product images use placeholder URLs
- **Limited Product Data**: Uses hardcoded dummy data instead of live API
- **Offline Mode**: Requires internet for Firebase features

### Future Improvements
- [ ] Real payment gateway integration (Stripe/PayPal)
- [ ] Backend API for dynamic product management
- [ ] Order history and tracking
- [ ] Product reviews and ratings
- [ ] Wishlist functionality
- [ ] Push notifications for orders
- [ ] Advanced analytics dashboard
- [ ] Multi-language support
- [ ] Dark mode theme

## 🤝 Contributing

This is a coursework project for University of Portsmouth. If you're a student working on similar projects:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is created for educational purposes as part of the University of Portsmouth coursework.

## 👤 Contact

**Alaei Bnoucheikh**

- GitHub: [@ibnoucheikhalae](https://github.com/ibnoucheikhalae)
- Repository: [union_shop](https://github.com/ibnoucheikhalae/union_shop)

## 🙏 Acknowledgments

- University of Portsmouth - Course materials and guidance
- [UPSU Shop](https://shop.upsu.net) - Original inspiration
- Flutter Community - Documentation and resources
- Firebase - Authentication and database services

---

**Built with ❤️ using Flutter**


**University Computers:**

- Open [AppsAnywhere](https://appsanywhere.port.ac.uk/sso) and launch the following in the given order:
  - Git
  - Flutter And Dart SDK
  - Visual Studio Code

**Personal Windows Computer:**

- Install [Chocolatey package manager](https://chocolatey.org/install)
- Run in PowerShell (as Administrator):

  ```bash
  choco install git vscode flutter -y
  ```

**Personal macOS Computer:**

- Install [Homebrew package manager](https://brew.sh/)
- Run in Terminal:

  ```bash
  brew install --cask visual-studio-code flutter
  ```

After installation, verify your setup by running:

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation.

For detailed step-by-step instructions, refer to [Worksheet 1 — Introduction to Flutter](https://manighahrmani.github.io/sandwich_shop/worksheet-1.html), which covers the complete setup process for all three options.

### Fork the Repository

Go to the repository containing the code for the coursework and click on the fork button as shown in the screenshot: [github.com/manighahrmani/union_shop/fork](https://github.com/manighahrmani/union_shop/fork) (Alternatively, just use this link: [github.com/manighahrmani/union_shop/fork](https://github.com/manighahrmani/union_shop/fork).)

![Fork Button](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_fork_button.png)

Do not change anything and click on the Create fork button. You should then have a public fork of my repository with a URL like (YOUR-USERNAME replaced with your username): [github.com/YOUR-USERNAME/union_shop](https://github.com/YOUR-USERNAME/union_shop)

![Fork Settings](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_fork_settings.png)

Note that the name of this created fork must be “union_shop”. If you already have a repository with this name, you need to rename it beforehand.

### Clone Your Forked Repository

If you are using Firebase, access idx.google.com with a personal Google account. Create a new Flutter Workspace named `union_shop` (choose the Flutter template in the “Start coding an app” section). Once the Flutter Workspace is created, open the integrated terminal (View → Terminal) and link this project to your forked GitHub repository by running the following commands (replace YOUR-USERNAME in the URL): 

```bash
rm -rf .git && git init && git remote add origin https://github.com/YOUR-USERNAME/union_shop.git && git fetch origin && git reset --hard origin/main 
```

This command should remove the existing Git history, initialize a new Git repository, add your forked repository as the remote named origin, fetch the data from it. It should also reset the local files to match the main branch of your forked repository. After running the above commands, open the Source Control view and commit any local changes.  

Otherwise, open a terminal, change to your desired directory, and run the following commands:

```bash
git clone https://github.com/YOUR-USERNAME/union_shop.git
cd union_shop
```

Replace `YOUR-USERNAME` with your actual GitHub username.

### Install Dependencies

Your editor should automatically prompt you to install the required dependencies when you open the project. If not, open the integrated terminal (open the Command Palette with `Ctrl+Shift+P` or `Cmd+Shift+P` and type "Terminal: Create New Terminal") and run the following command:

```bash
flutter pub get
```

### Run the Application

This application is primarily designed to run on the **web** and should be viewed in **mobile view** using your browser's developer tools. We recommend using Google Chrome.

Select Chrome as the target device and run the application either from the `main.dart` file or by entering the following command in the terminal:

```bash
flutter run -d chrome
```

Once the app is running in Chrome, open Chrome DevTools by right-clicking on the page and selecting "Inspect" (or use the shortcut `F12`). Click the "Toggle device toolbar" button as shown in the screenshot below.

![Chrome DevTools Mobile View](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_chrome_devtools.png)

From the Dimensions menu, select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5):

![Device Selection](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_chrome_devtools_device_selection.png)

## Marking Criteria

This assessment is worth 55% of the marks for the module's assessment item 1 (the remaining 45% comes from the weekly sign-offs). The mark for the assessment is divided into two components:

- **[Application (functionality) (30%)](#application)**: Demonstrated through a live demo during practical
- **[Software Development Practices (25%)](#software-development-practices)**: Assessed through your repository

⚠️ You will only receive marks if you **both** attend a practical session for the demo **and** submit the link to your forked repository on Moodle before the deadline. Failure to do either will result in a mark of 0 for the entire coursework.

For info on the overall assessment structure, visit the [Flutter Course homepage](https://manighahrmani.github.io/sandwich_shop/).

### Application

30% of the coursework mark comes from functionality demonstrated through a live demo during practical sessions. More information about the demo sessions is provided in the [demonstration section](#demonstration).

Your objective is to reimplement as many features from the existing [Union Shop website](https://shop.upsu.net) as you can in your forked repository using Flutter.

The table below is an almost comprehensive list of features present on the website, sorted by difficulty. Each feature has a corresponding percentage value indicating its weight in the 30% application mark and a reference link to the relevant page on the actual website.

⚠️ Note that this assessment focuses on functionality over visual design (do not spend a lot of time making it look exactly like the real website). You do not have to list the exact same products or collections as the real website. You are also encouraged to use copyright-free or AI-generated images instead of downloading images from the real website.

| Feature | Description | Marks (%) | Reference |
|---------|-------------|-----------|-----------|
| **Basic (40%)** | | | |
| Static Homepage | Homepage layout and widgets with static content (hardcoded data* acceptable, mobile view focus) | 5% | [Homepage](https://shop.upsu.net/) |
| Static Navbar | Top navigation bar with menu (links do not have to work at this stage, mobile view focus) | 5% | [Homepage](https://shop.upsu.net/) |
| About Us Page | Static about us page* with company information (separate page from homepage) | 5% | [About Us](https://shop.upsu.net/pages/about-us) |
| Footer | Footer with dummy* links and information present in at least one page | 4% | [Homepage](https://shop.upsu.net/) |
| Dummy* Collections Page | Page displaying various collections of products (hardcoded data* acceptable) | 5% | [Collections](https://shop.upsu.net/collections/) |
| Dummy* Collection Page | Page displaying products within one collection including dropdowns and filters (hardcoded data* acceptable, widgets do not have to function) | 5% | [Collection Example](https://shop.upsu.net/collections/autumn-favourites) |
| Dummy* Product Page | Product page showing details and images with dropdowns, buttons and widgets (hardcoded data* acceptable, widgets do not have to function) | 4% | [Product Example](https://shop.upsu.net/collections/autumn-favourites/products/classic-sweatshirt-1) |
| Sale Collection | Page showing sale products with discounted prices and promotional messaging (hardcoded data* acceptable, widgets do not have to function) | 4% | [Sale Items](https://shop.upsu.net/collections/sale-items) |
| Authentication UI | Login/signup page with the relevant forms (widgets do not have to function) | 3% | [Sign In](https://shop.upsu.net/account/login) |
| **Intermediate (35%)** | | | |
| Navigation | Full navigation across all pages; users should be able to navigate using buttons, navbar, and URLs | 3% | All pages |
| Dynamic Collections Page | Collections page populated from data models or services with functioning sorting, filtering, pagination widgets | 6% | [Collections](https://shop.upsu.net/collections/) |
| Dynamic Collection Page | Product listings of a collection populated from data models or services with functioning sorting, filtering, pagination widgets | 6% | [Collection Example](https://shop.upsu.net/collections/autumn-favourites) |
| Functional Product Pages | Product pages populated from data models or services with functioning dropdowns and counters (add to cart buttons do not have to work yet) | 6% | [Product Example](https://shop.upsu.net/collections/autumn-favourites/products/classic-sweatshirt-1) |
| Shopping Cart | Add items to cart, view cart page, basic cart functionality (checkout buttons should place order without real monetary transactions) | 6% | [Cart](https://shop.upsu.net/cart) |
| Print Shack | Text personalisation page with associated about page, the form must dynamically update based on selected fields | 3% | [Personalisation](https://shop.upsu.net/products/personalise-text) |
| Responsiveness* | The layout of the application should be adaptive and the application should function on desktop in addition to mobile view (no need to test it on real devices) | 5% | All pages |
| **Advanced (25%)** | | | |
| Authentication System | Full user authentication and account management (you can implement this with other external authentications like Google, not just Shop), includes the account dashboard and all relevant functionality | 8% | [Account](https://shop.upsu.net/account) |
| Cart Management | Full cart functionality including quantity editing/removal, price calculations and persistence | 6% | [Cart](https://shop.upsu.net/cart) |
| Search System | Complete search functionality (search buttons should function on the navbar and the footer) | 4% | [Search](https://shop.upsu.net/search) |

Below are explanations for some of the terminology used in the table:

***Pages** refer to distinct screens or views in your application that users can navigate to. See [line 22 of `lib/main.dart`](https://github.com/manighahrmani/union_shop/blob/main/lib/main.dart#L22) or the `navigateToProduct` function in the same file for an example of how to define routes for different pages.

***Hardcoded data** refers to data (text or images) that is directly written into your code files rather than being fetched from a database or external service. For example, you can create a list of products with an AI-generated image and text descriptions directly in your Dart code instead of retrieving them from a backend.

***Dummy data** is data that is often hardcoded or (AI) generated for display or testing purposes. It is not meant to represent real-world data stored in your services.

***Responsiveness** refers to the ability of your application to adapt its layout and design based on the screen size and orientation of the device it is being viewed on. Your app should primarily focus on mobile view but to achieve full marks in this section, it should also function correctly on wider screens (desktop view).

### Software Development Practices

In addition to functionality, you will be assessed on your software development practices demonstrated throughout the project (worth 25% of the coursework mark). These marks are awarded after the demo based on evidence in your repository.

The table below outlines the aspects that will be evaluated and the mark (from the 25%) allocated to each:

| Aspect | Description | Marks (%) |
|--------|-------------|-----------|
| Git | Regular, small, meaningful commits* to your repository throughout development; clear commit messages | 8% |
| README | A comprehensive, well-formatted and accurate README file* (delete the current README file first) | 5% |
| Testing | Tests covering all or almost all of the application; passing tests | 6% |
| External Services* | Integration and utilization of cloud services | 6% |

⚠️ You may not be awarded the 25% software development practices mark if your code has problems or poor quality. Your code must be properly formatted and free from errors, warnings, or suggestions. Make sure your codebase is also well-structured, refactored and relatively free of repetition too. Your code must be your own work (you need to understand it). **Plagiarised code** (e.g., commits showing large chunks of code copied over, especially from other students) will be penalised according to the University’s academic misconduct policy, and you be awarded 0 marks for the entire coursework.

Below are some explanations for the terminology used in the table:

***Regular, small, meaningful commits**: [worksheet 2](https://manighahrmani.github.io/sandwich_shop/worksheet-2.html) onwards on the [Flutter Course homepage](https://manighahrmani.github.io/sandwich_shop/) have demonstrated how to use Git effectively. You need to follow the practice taught in the worksheets.

***README**: Refer to [worksheet 4](https://manighahrmani.github.io/sandwich_shop/worksheet-4.html#writing-a-readme) for guidance on writing a good README file.

***External Services** refer to third-party cloud services like Firebase or Azure that your application integrates with. This could include services like user authentication, database, or hosting the application live on the web. To get marks for this, you must integrate at **least two** separate external services. You are only awarded marks if your README documents this integration and explains how it is used in your application (e.g., provide a live link to the website if you have hosted it).

## Submission

You need to submit the link to your forked repository on Moodle **before the deadline**. Open the Moodle page for Programming Applications and Programming Languages (M30235) or User Experience Design and Implementation (M32605) and find the submission section titled "Item 1 - Set exercise (coursework) (CW)". See below:

![Moodle Submission Page](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_moodle_submission_section.png)

Open the On time or the Late/Extenuating Circumstances submission link and click on Add submission. There you will find an editable Online text field. Paste the link to the GitHub repository for your coursework in the provided text field and click on Save changes. You are **not** submitting any files for this coursework.

![Moodle Submission Online Text](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_moodle_submission_online_text.png)

Make sure the repository is public. Check to see if it opens in an incognito/private window (you should not get a 404 error).

⚠️ You can edit the link itself before the deadline, but do not edit the repository (do not make new commits) after the deadline. I will label your submission as late if you do this.

## Demonstration

The demos take place during your usual timetabled practical sessions in weeks 19 or 20 (Friday 12/12/2025 or Friday 19/12/2025). More information about the demo sessions will be provided closer to the time.

During the demo, you will have **up to 10 minutes** to demonstrate your application to staff. You must clone your repository and run the application live. You need to be prepared to show the features you have implemented and answer any questions about your code.

⚠️ Make sure your application runs correctly (on your personal device or the university computers) from a fresh clone before attending the demo session.

## Project Structure

This starter repository that you will fork provides a minimal skeletal structure with:

- **Homepage** (`lib/main.dart`): A basic homepage
- **Product Page** (`lib/product_page.dart`): A single product page
- **Widget Tests**: Basic tests for both of the above pages (`test/home_test.dart` and `test/product_test.dart`)

Here is an overview of the project structure after forking:

```plaintext
union_shop/
├── lib/
│   ├── main.dart           # Main application and homepage
│   └── product_page.dart   # Product detail page
├── test/
│   ├── home_test.dart      # Homepage widget tests
│   └── product_test.dart   # Product page widget tests
├── pubspec.yaml            # Project dependencies
└── README.md               # This file
```

Note that this is the initial structure. You are expected to create additional files and directories as needed to complete the coursework. You can also reorganize the project structure as you see fit.

## Help with Coursework

### Support

If you have questions or encounter issues while working on this coursework, use [the dedicated Discord channel](https://portdotacdotuk-my.sharepoint.com/:b:/g/personal/mani_ghahremani_port_ac_uk/EbX583gvURRAhqsnhYqmbSEBwIFw6tXRyz_Br1GxIyE8dg) to ask for help. Before posting a new question, check the existing posts to see if your question has already been answered. You can also attend your timetabled practical sessions to get face-to-face support from teaching staff.

If you are facing external extenuating circumstances that are affecting your ability to complete this coursework, you should submit an [Extenuating Circumstances Form](https://myport.port.ac.uk/my-course/exams/extenuating-circumstances) as soon as possible. You are also welcome to contact me on Discord for additional support without needing to disclose the private details of your situation.

### Resources

The worksheets listed on [the homepage](https://manighahrmani.github.io/sandwich_shop/) are your primary learning resource for Flutter development. Work through these worksheets systematically as they provide the foundation you need to complete the coursework successfully. Refrain from using other online resources such as Stack Overflow, YouTube tutorials, or other websites for this coursework as they may contain outdated or incorrect information that could lead you astray.

### Tips

Starting early is crucial for success in this coursework. The earlier you begin, the more time you have to learn, experiment, and seek help when needed. You should aim to work on the coursework alongside the worksheets rather than leaving everything until the end. As you complete each worksheet, implement the corresponding features in your coursework application. This approach allows you to apply what you learn immediately and build your application incrementally.

When planning your implementation, prioritize features based on the difficulty levels outlined in the [marking criteria](#application). Start with the basic features to establish a solid foundation before moving on to intermediate and advanced functionality. This strategy ensures you secure marks early and have a working application even if you run out of time for the more complex features.

Version control is an essential part of this coursework. Commit your changes regularly to Git with clear, descriptive commit messages. Each commit should represent a small, meaningful unit of work rather than large batches of changes. This practice creates checkpoints you can return to if something goes wrong and demonstrates your development process to assessors. To commit and push your changes, use the following commands:

```bash
git add .
git commit -m "Brief description of what you changed"
git push
```

If you make a mistake and need to revert to a previous commit, you can view your commit history with `git log --oneline`, find the commit hash where things were working (for example, `abc1234`), and revert to that commit with `git reset --hard abc1234`. If necessary, you can force push with `git push --force`. In extreme cases where your repository is completely broken and unrecoverable, you can start fresh by deleting your forked repository on GitHub (Settings → Danger Zone → Delete this repository), forking the original repository again from [github.com/manighahrmani/union_shop](https://github.com/manighahrmani/union_shop), and cloning your fresh fork.

AI tools are valuable during development, and you are encouraged to use them. However, you must apply the best practices taught in the worksheets, particularly those covered in [Worksheet 6](https://manighahrmani.github.io/sandwich_shop/worksheet-6.html). AI-generated code should be reviewed, understood, and adapted to fit your application properly. Blindly copying AI suggestions without understanding them will likely result in poor code quality and may not meet the requirements. Use AI as a learning aid and coding partner rather than a replacement for your own understanding and decision-making.

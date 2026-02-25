<div align="center">

# 📚 Huddle
### *Can collaboration transform learning into an experience, not a task?*

**Huddle** is an iOS app that transforms the university campus into a real-time connected community — making it effortless to find, join, and create study groups with fellow students.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-blue?style=flat-square&logo=swift)
![iOS](https://img.shields.io/badge/iOS-17%2B-lightgrey?style=flat-square&logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-15%2B-blue?style=flat-square&logo=xcode)
![Status](https://img.shields.io/badge/Status-In%20Development-green?style=flat-square)

</div>

---

## 🎓 About This Project

Huddle was built as part of the **Web & Mobile Programming** course at the **University of Palermo**, developed in collaboration with **Apple** through the **Apple Developer Academy** program.

Upon completing this course and delivering a functional iOS app, every team member received an official **Apple certificate and Open Badge** — a recognized credential in iOS and Swift development.

---

## 🎯 The Problem

University should be the place of connections — but often you find yourself studying alone in overcrowded corridors.

Students face two core problems:

- **Social Isolation** — Feeling alone among thousands of people
- **Wasted Time** — Searching for empty classrooms and compatible study partners

> *"The single strongest predictor of college success is the ability to participate in or form a study group."*
> — **Richard Light, Harvard University**

---

## 💡 The Solution

Huddle is an interactive iOS app that connects students in real time, letting them organize study sessions — called **Huddles** — filtered by faculty, subject, building, and date. Students can also share WhatsApp and Telegram group links directly in the app.

---

## 🎬 Demo

> Video demo coming soon

---

## Features

### Implemented

**Onboarding Wizard**
Horizontal swipe intro for first-time users

**Email Verification**
Secure sign-up using your official UniPa university email

**Explore Huddles**
Browse and search all study sessions, filter by engineering faculty

**Create a Huddle**
Set subject, building, room, date, and share group chat links

**Join & Leave**
One tap to join or leave any session, with haptic feedback

**My Group**
View all the Huddles you have joined in one place

**Profile**
Edit your username, view your email, and manage your session

**Real-time Sync**
All data is stored in a shared cloud database and visible across every device instantly

### Future Improvements

**Mini Quizzes**
Quick timed challenges between study group members on the subject being studied

**Shared Calendar**
A synced schedule visible to all students in a Huddle

**Campus Map**
Discover nearby libraries, study rooms, and coworking spaces on campus

**In-app Chat**
Real-time messaging with active Huddles in your department

**Push Notifications**
Get notified when a new Huddle is created in your subject

**Ratings**
Rate study sessions and build your academic reputation over time

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Swift 5.9 |
| UI Framework | SwiftUI |
| Architecture | MVVM |
| Cloud Database | ParthenoKit (UniPa SDK) |
| Email Service | EmailJS API |
| Session Storage | UserDefaults |
| Version Control | Git / GitHub |
| IDE | Xcode 15 |

---

## 🏛️ Architecture

```
HuddleApp
├── Auth
│   ├── RegisterView             # Onboarding wizard + login/register form
│   └── RegisterViewModel        # Auth logic, email verification, ParthenoKit storage
├── Main Tabs
│   ├── SearchView               # Explore all huddles with filters
│   ├── DetailView               # Huddle detail page, join/leave
│   ├── CreateView               # Create a new huddle
│   ├── MyGroupView              # User's joined huddles
│   └── ProfileView / EditProfileView
├── Services
│   ├── SessionManager           # Local login session (UserDefaults)
│   ├── DatabaseManager          # HuddleService: ParthenoKit CRUD
│   └── EmailService             # Verification codes via EmailJS
└── Models
    ├── User
    └── Huddle
```

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- iOS 17+ deployment target
- A University of Palermo email (`@community.unipa.it` or `@unipa.it`)

### Installation

```bash
git clone https://github.com/salvoZero4/Huddle.git
cd Huddle
open Huddle.xcodeproj
```

> ⚠️ **Note:** This project uses `ParthenoKit.xcframework`, a proprietary SDK provided by the University of Palermo. Place it in the `Frameworks/` folder before building. Without it the project will not compile.

---

## 👥 Team

Developed collaboratively by 6 students at the **University of Palermo**, 2026.

| Name | Degree | Role |
|------|--------|------|
| **Yasmine Ghomrassi** | Data Science & Software Engineering | Developer, Designer |
| **Salvatore Scaravalle** | Computer Engineering | Developer, Designer |
| **Daniele Giammarresi** | Computer Engineering | Developer, Designer |
| **Gabriele Barone** | Biomedical Engineering | Developer, Designer |
| **Israt Ahmed** | Computer Science | Designer |
| **Matteo Maria Raimondi** | Automation & Systems Engineering | Researcher, Presentation Designer |

---

## 🏅 Certificate & Open Badge

This project was built as part of an official collaboration between the **University of Palermo** and **Apple**. Upon completing the course and delivering a fully functional iOS application, each team member was awarded an **Apple certificate** and an **Open Badge** — a verifiable digital credential recognizing proficiency in Swift, SwiftUI, and iOS app development.

---

## 📄 License

Academic project developed at the University of Palermo in collaboration with Apple, 2026.
Not licensed for commercial use.

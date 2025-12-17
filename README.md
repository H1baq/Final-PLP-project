# Know Your Flow 🌸

**Know Your Flow** is a mobile and web application designed to educate young girls and teens about menstruation, provide period tracking tools, and allow users to maintain personal profiles. The app is also suitable for organizations and educational institutions to use as a learning tool for menstrual health education.

---

## Table of Contents

* [Purpose](#purpose)
* [Features](#features)
* [Target Audience](#target-audience)
* [Tech Stack](#tech-stack)
* [Installation & Setup](#installation--setup)
* [Future Plans](#future-plans)
* [AI-Powered Development & Learning](#ai-powered-development--learning)
* [AI Prompts & Methodology](#ai-prompts--methodology)
* [Contact](#contact)

---

## Purpose

The main purpose of **Know Your Flow** is to:

* Educate young girls and teens about menstruation, hormones, and hygiene.
* Provide a period tracker to monitor cycles and symptoms.
* Offer a personalized profile system for better health insights.
* Serve as a learning resource for schools, institutions, and organizations teaching menstrual health.

---

## Features

* **Educational Lessons:** Interactive lessons on hormones, hygiene, menstrual cycle, and myth-busting.
* **Period Tracking:** Users can log cycles, symptoms, moods, and view insights.
* **Profile Management:** Set up and manage personal profiles.
* **Institutional Use:** Sections designed for organizations to educate the girl child.
* **Cross-Platform:** Works on mobile (Android/iOS) and web.

---

## Target Audience

* Teenagers and young girls seeking menstrual education.
* Parents and guardians guiding adolescents.
* Schools, NGOs, and institutions promoting menstrual health education.

---

## Tech Stack

* **Frontend & Backend:** Flutter (Dart)
* **Backend Services:** Firebase Authentication, Firestore Database
* **Platforms:** Android, iOS, Web

---

## Installation & Setup

1. **Clone the repository:**

```bash
git clone <repository-url>
cd know_your_flow
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Setup Firebase:**

* Add your Firebase project configuration (`google-services.json` for Android, `GoogleService-Info.plist` for iOS, and `firebase_options.dart` for Flutter).
* Ensure Firestore and Firebase Authentication are enabled.

4. **Run the app:**

* For Web:

```bash
flutter run -d chrome
```

* For Android:

```bash
flutter run -d <device-id>
```

* For iOS:

```bash
flutter run -d <device-id>
```

---

## Future Plans

* **Institutional Dashboard:** Allow schools and organizations to monitor usage and track engagement.
* **Gamification:** Add badges or rewards for completing lessons to encourage learning.
* **Custom Insights:** Provide AI-generated tips based on tracked cycles and symptoms.
* **Offline Mode:** Enable tracking and lessons without internet connection.

---

## AI-Powered Development & Learning

**Know Your Flow** was not only built as a menstrual health education platform but also as a capstone project demonstrating AI-assisted learning and development. AI was used to improve the codebase, learn best practices in Flutter, and ensure production-level quality.

### How AI Was Used

* **Code Improvement:** AI (Cursor/GPT) assisted in refactoring deprecated APIs, fixing lint warnings, and ensuring Flutter 3.13+ compatibility across multiple screens.
* **Error Diagnosis:** Permission errors, asynchronous context issues, and form field deprecations were diagnosed and corrected using AI-guided prompts.
* **Prompt-Based Learning:** Each AI interaction was carefully designed with precise instructions, including:

  * Avoiding behavior or UI changes.
  * Minimizing diffs to maintain project stability.
  * Explaining each change for learning purposes.

### Learning Ideology

This project demonstrates a human-AI collaborative approach:

* **Iterative Learning:** Each AI prompt served as a learning session, helping the developer understand Flutter best practices, deprecated API replacements, and secure Firebase usage.
* **Documentation of AI Reasoning:** All AI-generated changes were documented with explanations, turning the project into a learning artifact.
* **Safe AI Integration:** By committing changes incrementally and validating each modification, the project maintained stability and security.
* **Skill Amplification:** AI acted as a mentor, assisting in debugging, code refactoring, and modern Flutter practices, allowing the developer to focus on core functionality and design.

---

## AI Prompts & Methodology

Throughout the development of **Know Your Flow**, AI was used to improve the codebase, fix errors, and learn best practices in Flutter. Below is a structured record of the prompts used:

### 1️⃣ Fixing Flutter Warnings & Deprecated APIs

**File-specific (example: `auth_screen.dart`):**

```
Fix the unused_local_variable warning in this file.

If the variable is not needed, remove it safely.
If it should be used, use it meaningfully (e.g., checking user or uid),
without changing authentication behavior.
```

**Master prompt (project-wide cleanup):**

```
Go through this Flutter project and fix all reported analyzer warnings:
- deprecated_member_use
- unused_local_variable
- prefer_final_fields
- use_build_context_synchronously

Rules:
- No behavior, UI, or navigation changes
- Minimal diffs
- Flutter 3.13+ compatible
- Explain changes per file after completion
```

---

### 2️⃣ Fixing Firestore Permission Errors

```
There is a Firestore permission-denied error when saving a user profile.

Task:
- Identify why saving the profile fails with "Missing or insufficient permissions".
- Ensure the user is authenticated before writing to Firestore.
- Ensure the Firestore document path matches security rules (e.g., users/{uid}).
- Fix the Flutter code OR Firestore rules so that:
  - A signed-in user can create/update ONLY their own profile.
  - No other users' data can be accessed.

Rules:
- Do NOT weaken security (no public read/write).
- Do NOT change UI or navigation.
- Keep changes minimal.
- Explain the root cause and each fix clearly.
```

---

### 3️⃣ Refactoring Deprecated API Usage (`withOpacity`, `value`, `activeColor`)

```
Replace all deprecated Color.withOpacity() usages with Color.withValues() equivalent,
preserving the same opacity and visual appearance. Do not change any other UI element.
```

*For form fields:*

```
Replace deprecated FormField 'value' parameters with 'initialValue'.
Ensure form behavior remains unchanged.
```

---

### 4️⃣ Handling Async Context Warnings (`use_build_context_synchronously`)

```
Fix use_build_context_synchronously warnings by adding mounted checks
after async gaps.

Do not restructure async logic.
Do not move navigation or context usage.
Only guard with `if (!mounted) return;`.
```

---

### AI Prompting Philosophy

1. **Clear Context:** Each prompt included file path, warning/error type, and desired safe behavior.
2. **Incremental Fixes:** AI was prompted file by file before applying any project-wide fixes.
3. **Safety First:** Prompts explicitly restricted AI from changing UI, navigation, or business logic.
4. **Explain & Learn:** AI was always asked to provide explanations for changes, turning every fix into a learning opportunity.
5. **Validated & Committed:** All AI-generated fixes were reviewed, tested, and committed incrementally to maintain code stability.

---

## Contact

**Developer:** Hibaq Adan

* Email: [hibaqku7@gmail.com](mailto:hibaqku7@gmail.com)
* Phone: 0707301008

/// Application‑wide user‑visible strings.
///
/// Centralising strings makes localisation straightforward and avoids
/// hard‑coded text scattered across the codebase.
library;

/// All user‑facing string constants used in the TODO app.
///
/// Grouped logically by feature area. Every string that appears in the
/// UI should be defined here so it can later be swapped for l10n.
sealed class AppStrings {
  // ── General ──────────────────────────────────────────────────────────

  /// The application display name.
  static const String appName = 'TODO';

  // ── Splash / Onboarding ─────────────────────────────────────────────

  /// Splash screen headline.
  static const String splashTitle = 'Get things done with TODO';

  /// Splash screen description paragraph.
  static const String splashDescription =
      'Turn your thoughts into tangible accomplishments. '
      'Every task you complete is a step toward achieving your greater goals. '
      'Start now and feel the power of accomplishment.';

  /// Call‑to‑action on the onboarding / splash screen.
  static const String getStarted = 'Get Started';

  // ── Authentication ──────────────────────────────────────────────────

  /// Login page greeting.
  static const String welcomeBack = 'Welcome Back';

  /// Registration page greeting.
  static const String welcomeOnboard = 'Welcome Onboard';

  /// Registration page subtitle.
  static const String signUpSubtitle = 'Lets help you in completing your tasks';

  /// Email field label.
  static const String email = 'Email';

  /// Password field label.
  static const String password = 'Password';

  /// Confirm‑password field label.
  static const String confirmPassword = 'Confirm Password';

  /// Full‑name field label.
  static const String fullName = 'Full Name';

  /// Login button text.
  static const String login = 'Login';

  /// Register button text.
  static const String register = 'Register';

  /// Sign‑in link text.
  static const String signIn = 'Sign In';

  /// Forgot‑password link text.
  static const String forgotPassword = 'Forgot Password?';

  /// Prompt shown when the user has no account yet.
  static const String noAccount = "Don't have an account?";

  /// Prompt shown when the user already has an account.
  static const String haveAccount = 'Already have an account?';

  /// Generic "click here" link text.
  static const String clickHere = 'Click Here';

  // ── Dashboard / Tasks ───────────────────────────────────────────────

  /// App‑bar title on the main task list screen.
  static const String tasksList = 'Tasks List';

  /// Section header for the daily tasks view.
  static const String dailyTasks = 'Daily Tasks';

  /// Placeholder when no tasks exist.
  static const String noTasks = 'No tasks yet. Tap + to add one!';

  /// Add‑task dialog / screen title.
  static const String addTask = 'Add Task';

  /// Edit‑task dialog / screen title.
  static const String editTask = 'Edit Task';

  /// Delete confirmation prompt.
  static const String deleteTask = 'Delete Task';

  /// Generic save button.
  static const String save = 'Save';

  /// Generic cancel button.
  static const String cancel = 'Cancel';

  /// Generic delete button.
  static const String delete = 'Delete';

  /// Logout button.
  static const String logout = 'Logout';
}

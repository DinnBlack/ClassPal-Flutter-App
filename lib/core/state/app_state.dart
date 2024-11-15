class AppState {
  static String currentRole = "";

  static String getRole() {
    return currentRole;
  }

  static void setRole(String role) {
    currentRole = role;
  }
}
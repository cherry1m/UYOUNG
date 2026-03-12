class SupabaseConfig {
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const String inviteBaseUrl = String.fromEnvironment(
    'MEMORY_INVITE_BASE_URL',
    defaultValue: 'https://momenture.app/invite',
  );

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}

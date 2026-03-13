class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://osfczxtmmwhixgpuljgd.supabase.co',
  );
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_UNOYiEZ_6hUFn5J3sg31iA_Kbi8cZqt',
  );
  static const String inviteBaseUrl = String.fromEnvironment(
    'MEMORY_INVITE_BASE_URL',
    defaultValue: 'https://momenture.app/invite',
  );

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}

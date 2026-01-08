import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tcp/features/student/home/presentation/pages/student_home_page.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../auth_injection.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _mainAnimationController = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  late final AnimationController _backgroundAnimationController =
      AnimationController(duration: const Duration(seconds: 20), vsync: this);

  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimationController,
          curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
        ),
      );

  late final Animation<Offset> _slideAnimation =
      Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _mainAnimationController,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
        ),
      );

  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimationController,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
        ),
      );

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _backgroundAnimationController.repeat();
    _mainAnimationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mainAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Moving/Animated Background
          _buildAnimatedBackground(size),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Language Selector at top right
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildLanguageSelector(context),
                  ),

                  const Spacer(flex: 1),

                  // Logo and Title
                  _buildHeader(),

                  const SizedBox(height: 16),

                  // Glassmorphic Login Card
                  Flexible(
                    flex: 8,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: _buildGlassCard(context, l10n),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Footer
                  _buildFooter(l10n),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(Size size) {
    return AnimatedBuilder(
      animation: _backgroundAnimationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Base Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB71C1C),
                    Color(0xFF8E0000),
                    Color(0xFF4A0000),
                  ],
                ),
              ),
            ),

            // Animated Blobs
            _buildBlob(
              size: size.width * 0.8,
              color: Colors.white.withOpacity(0.08),
              top: -100 + (20 * _backgroundAnimationController.value),
              left: -50 + (30 * _backgroundAnimationController.value),
              rotation: _backgroundAnimationController.value * 2 * 3.14159,
            ),

            _buildBlob(
              size: size.width * 0.6,
              color: Colors.white.withOpacity(0.05),
              bottom: 100 - (40 * _backgroundAnimationController.value),
              right: -80 + (20 * _backgroundAnimationController.value),
              rotation: -_backgroundAnimationController.value * 2 * 3.14159,
            ),

            _buildBlob(
              size: size.width * 0.4,
              color: Colors.black.withOpacity(0.1),
              bottom: size.height * 0.2,
              left: size.width * 0.1,
              rotation: _backgroundAnimationController.value * 3.14159,
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlob({
    required double size,
    required Color color,
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double rotation,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.4),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'TCP',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The Connect Plus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'EduConnect',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.loginTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email Field
                  _buildModernField(
                    controller: _emailController,
                    hint: l10n.emailHint,
                    icon: Icons.alternate_email_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 12),

                  // Password Field
                  _buildModernField(
                    controller: _passwordController,
                    hint: l10n.passwordHint,
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onTogglePassword: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        l10n.forgotPassword,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Login Button
                  _buildSubmitButton(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 20,
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF5F5F5)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Color(0xFFB71C1C),
                  strokeWidth: 3,
                ),
              )
            : Text(
                l10n.loginButton.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFB71C1C),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }

  void _handleLogin() {
    setState(() => _isLoading = true);

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const StudentHomePage(
              userName: 'Bandana Rana',
              userRole: 'Student',
              userAvatar: 'assets/avatar.png',
            ),
          ),
        );
      }
    });
  }

  Widget _buildFooter(AppLocalizations l10n) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Text(
            l10n.schoolContactMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: Text(
              l10n.contactSupport,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final localeProvider = getLocaleProvider();
    final languages = [
      {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
      {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
      {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
      {'code': 'hi', 'name': 'हिंदी', 'flag': '🇮🇳'},
      {'code': 'ne', 'name': 'नेपाली', 'flag': '🇳🇵'},
    ];

    return ListenableBuilder(
      listenable: localeProvider,
      builder: (context, _) {
        final currentLangCode = localeProvider.locale.languageCode;

        return PopupMenuButton<String>(
          offset: const Offset(0, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onSelected: (String languageCode) {
            localeProvider.setLanguageByCode(languageCode);
          },
          itemBuilder: (BuildContext context) => languages
              .map(
                (lang) => PopupMenuItem<String>(
                  value: lang['code'] as String,
                  child: Row(
                    children: [
                      Text(
                        lang['flag'] as String,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        lang['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  currentLangCode.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

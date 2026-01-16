import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'dart:async'; // 1. Add this import at the very top of your file
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCYkT62xc7bvkUvszzqlNIps2w1i-DTiCs",
        authDomain: "jlstudios-custom-cards.firebaseapp.com",
        projectId: "jlstudios-custom-cards",
        storageBucket: "jlstudios-custom-cards.firebasestorage.app",
        messagingSenderId: "517030096782",
        appId: "1:517030096782:web:e822239c2e58751f5cfedf",
        measurementId: "G-6DD22GDJYP"
    ),
  );


  runApp(const JLStudiosApp());
}

class JLStudiosApp extends StatelessWidget {
  const JLStudiosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JLStudios | Custom Pokémon Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        primaryColor: const Color(0xFFD4AF37), // Gold
        // textTheme: Google_Fonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  // Helper to scroll to sections
  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _holoKey = GlobalKey();
  final GlobalKey _purchaseKey = GlobalKey();
   String githubBase = "https://raw.githubusercontent.com/JonathanLam12345/JLStudios.Custom.Pokemon.Cards/main/assets/";
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(



        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        title: Text(
          'JLStudios',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          if (!isMobile) ...[
            _navButton("About Us", _aboutKey),
            _navButton("Our Services", _servicesKey),
            _navButton("Holo Patterns", _holoKey),
            _navButton("Order Now", _purchaseKey),
          ],
          // Replace the old IconButton with this:
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => _launchURL('https://instagram.com/JLStudios416'),
              child: Image.network(
                '${githubBase}instagram_logo.png', // Switched to network
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.link, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(),
            _buildAboutSection(isMobile, _aboutKey),
            _buildServicesSection(isMobile, _servicesKey),
            _buildHoloSelector(_holoKey),
            _buildHowToPurchase(isMobile, _purchaseKey),
            _buildHowMadeSection(isMobile),
            _buildCareTips(),
            _buildAIFeedback(),
            _buildFooter(),
          ],
        ),
      ),

      // PASTE THE CODE HERE:
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _launchURL('https://instagram.com/JLStudios416'),
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(Icons.send, color: Colors.black),
        label: const Text(
            "DM TO ORDER",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ).animate().fadeIn(delay: 10.seconds).slideY(begin: 0.5),


    );
  }

  Widget _navButton(String text, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  // --- SECTION BUILDERS ---

  Widget _buildHeroSection() {
    return Container(
      height: 550,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "BRING DIGITAL BEAUTY TO LIFE",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 4,
              color: Color(0xFFD4AF37),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
          const SizedBox(height: 20),
          Text(
            "Premium Custom TCGP Cards",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
          ).animate().fadeIn(delay: 400.ms).scale(),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            onPressed: () => _scrollTo(_aboutKey),
            child: const Text("START YOUR COLLECTION"),
          ).animate().shake(delay: 1500.ms),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isMobile, GlobalKey key) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(60),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: const CardSlideshow(), // Your new animated slideshow
          ),

          const SizedBox(width: 60, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: "About Us",
                  subtitle: "Crafting Physical Legends",
                ),
                const Text(
                  "Ever wished you could hold those stunning digital cards from Pokémon TCGP mobile app game in real life? Now you can! "
                  "Our team offers high-end printed proxy cards that bring your favorite designs to life with premium ink and selective holo technology.",
                  style: TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 20),
                _featurePoint("Authentic backs for that genuine feel."),
                _featurePoint(
                  "Selective Holo: We mask characters so they pop!",
                ),
                _featurePoint("Professional-grade vinyl and ink."),
              ],
            ).animate().fadeIn(delay: 200.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(bool isMobile, GlobalKey key) {
    return Container(
      key: key,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const SectionHeader(title: "Services", subtitle: "Choose Your Tier"),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _serviceCard(
                "TCG Full Art Proxy",
                "\$25",
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                    children: [
                      const TextSpan(text: "We recommend selecting a full art Pokémon card. You can find the complete list of TCGP Pokémon from the game "),
                      TextSpan(
                        text: "here",
                        style: const TextStyle(color: Color(0xFFF6E05E), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchURL('https://www.pokemon-zone.com/cards/'),
                      ),
                      const TextSpan(text: ". For Pokémon cards not from the game, you can find the list "),
                      TextSpan(
                        text: "here",
                        style: const TextStyle(color: Color(0xFFF6E05E), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchURL('https://www.pokemon.com/us/pokemon-tcg/pokemon-cards'),
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
                Icons.style,
              ),
              _serviceCard(
                "Provide Your Full Art",
                "\$25",
                const Text(
                  "Provide your own art. Recommended 50% subject, 50% background. We will work together to build the Pokémon card your artwork.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                Icons.auto_awesome,
              ),
              _serviceCard(
                "Gemini AI Custom",
                "\$35",
                const Text(
                  "We will design your full art for you using AI prompts, then we will work together to build the Pokémon card. Perfect for turning pets or people into custom Pokémon cards!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                Icons.psychology,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoloSelector(GlobalKey key) {
    // Use a smaller padding for mobile
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;

    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: 20,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: "Holographic Patterns",
            subtitle: "Select Your Shine",
          ),
          const SizedBox(height: 40),

          // Constrain the width so the images don't spread too far apart on wide monitors
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Wrap(
              spacing: 25,
              // Space between images horizontally
              runSpacing: 30,
              // Space between images vertically (the "next row" gap)
              alignment: WrapAlignment.center,
              // Centers items in the row
              children: [
                _holoType("Scattered Glass", "scattered_glass.jpg"),
                _holoType(
                  "Reflective Rainbow",
                  "reflective_rainbow.jpg",
                ),
                _holoType("Fine Sparkle", "fine_sprakle.jpg"),
                _holoType("Scattered Stars", "scattered_stars.jpg"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToPurchase(bool isMobile, GlobalKey key) {
    return Container(
      key: key,
      padding: EdgeInsets.all(isMobile ? 40 : 80),
      color: const Color(0xFF151515),
      child: Column(
        children: [
          const SectionHeader(
            title: "How To Purchase",
            subtitle: "Simple 4-Step Process",
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _stepCircle(
                "1",
                "DM us on Instagram @JLStudios416",
                onHandleTap: () => _launchURL('https://instagram.com/JLStudios416'),
              ),
              _stepCircle("2", "Choose Pickup (Bayview Ave & Elgin Mills Rd E, Richmond Hill, Ontario, Canada) or Shipping (\$5)"),
              _stepCircle("3", "Payment in Full via E-Transfer"),
              _stepCircle("4", "Production Begins (Ready in ~1 week)"),
            ],
          ),
          const SizedBox(height: 50),

          // --- SUBTLE DISCLAIMER SECTION ---
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // Very faint border so it doesn't draw the eye away from the services
              border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Muted icon color
                Icon(
                    Icons.info_outline,
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    size: 20
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      // white24 makes this look like secondary "fine print"
                      style: const TextStyle(
                          color: Colors.white24,
                          fontSize: 13,
                          height: 1.5
                      ),
                      children: [
                        TextSpan(
                          text: "Disclaimer: ",
                          style: TextStyle(
                              color: const Color(0xFFD4AF37).withOpacity(0.4),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const TextSpan(
                          text: "For shipping, delivery times may vary depending on your location and the time of year (it may take a few weeks). If you plan on giving the card as a gift for a specific date, please reach out to us early and let us know so we can work according to your plan.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 1000.ms), // Appears last to keep focus on services
        ],
      ),
    );
  }

  Widget _buildHowMadeSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          const SectionHeader(
            title: "How It's Made",
            subtitle: "The Craftsmanship",
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              // Default style for the whole sentence
              style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              children: [
                const TextSpan(text: "We are active members of "),
                TextSpan(
                  text: "r/customtradingcard",
                  style: const TextStyle(
                    color: Colors.white, // Using the lighter yellow we discussed
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  // This makes it clickable
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchURL('https://www.reddit.com/r/customtradingcard/'),
                ),
                const TextSpan(
                  text: ". Our process involves pressing two vinyl sheets onto a real Pokémon card base.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            '${githubBase}how_cards_made.png', // Switched to network
            width: 340,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 340,
                height: 200, // Approximate height while loading
                child: Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
          ),
        ),
          const SizedBox(height: 20),
          const Text(
            "Note: We use a white marker technique for selective holo. Small air bubbles or slight 'bulges' may occur due to the layering process, but we use silicon air blowers and dust covers to minimize these.",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCareTips() {
    return Container(
      padding: const EdgeInsets.all(60),
      color: Colors.black,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user, color: Color(0xFFD4AF37), size: 50),
          const SizedBox(height: 20),
          const Text(
            "Handling & Storage",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "• Keep the card in a protective sleeve at all times. (card sleeve included)\n"
            "• Do NOT use wet wipes as the ink of the card may smear.\n"
            "• Avoid direct sunlight for extended periods.",
            style: TextStyle(fontSize: 18, height: 1.8),
          ),
        ],
      ),
    );
  }

  Widget _buildAIFeedback() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          const SectionHeader(
            title: "AI Art Philosophy",
            subtitle: "Adapting to the Future",
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const Text(
                  "Our team is aware of the negative feedback regarding what Gemini AI can do. Unfortunately, we don’t offer a service where an illustrator can sketch the full art. However, you can have someone create the artwork for you and then reach back out to us; we can proceed with Service \"Provided Custom Full Art\" from there.",
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Without this technology, our project wouldn’t have progressed as far as it has. Instead of resisting, the best approach is to learn to adapt and find ways to work alongside this growing technology.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          const Text("©2025 JLStudios"),
          const SizedBox(height: 10),

          // Clickable Instagram Logo
          InkWell(
            onTap: () => _launchURL('https://instagram.com/JLStudios416'),
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              '${githubBase}instagram_logo.png', // Switched to network
              width: 25,
              height: 25,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.camera_alt, size: 25),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _featurePoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFD4AF37), size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _serviceCard(String title, String price, Widget descWidget, IconData icon) {
    return InkWell( // Added InkWell for tap detection
      onTap: title.contains("Gemini")
          ? () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const GeminiDetailPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Cool transition: Fade + Slide Up + Blur
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(Tween(begin: const Offset(0, 0.1), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
                child: child,
              ),
            );
          },
        ),
      )
          : null,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            // Make the Gemini card border glow slightly to show it is clickable
            color: title.contains("Gemini") ? const Color(0xFFD4AF37).withOpacity(0.5) : Colors.white10,
            width: title.contains("Gemini") ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: const Color(0xFFD4AF37)),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Text(price, style: const TextStyle(fontSize: 24, color: Color(0xFFD4AF37))),
            const SizedBox(height: 15),
            descWidget,
            if (title.contains("Gemini"))
               Padding(
                 padding: EdgeInsets.only(top: 10),
                child: Text("(Click for details)", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontStyle: FontStyle.italic)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _holoType(String name, String fileName) {
    // Use the same githubBase defined in your class
     String githubBase = "https://raw.githubusercontent.com/JonathanLam12345/JLStudios.Custom.Pokemon.Cards/refs/heads/main/assets/";
    final String fullImageUrl = "$githubBase$fileName";

    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              fullImageUrl,
              height: 180,
              width: 180,
              fit: BoxFit.cover,
              // Shows a spinner while the holo pattern loads
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 180,
                  width: 180,
                  color: Colors.white.withOpacity(0.05),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD4AF37),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: 180,
                color: Colors.grey[900],
                child: const Icon(Icons.broken_image, color: Colors.white24),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat()) // This repeats the glint
              .shimmer(delay: 4000.ms, duration: 1800.ms, color: Colors.white24), // The actual "flash"
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(String num, String text, {VoidCallback? onHandleTap}) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFD4AF37),
            child: Text(num, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),

          // Use RichText to allow partial styling and clicking
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              children: [
                // Check if it's the Instagram step
                if (text.contains("@")) ...[
                  TextSpan(text: text.split("@")[0]), // "DM on Instagram "
                  TextSpan(
                    text: "@${text.split("@")[1]}", // "@JLStudios416"
                    style: const TextStyle(
                      color: Colors.white, // Gold link color
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onHandleTap,
                  ),
                ] else
                  TextSpan(text: text), // Just regular text for other steps
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(width: 60, height: 2, color: const Color(0xFFD4AF37)),
      ],
    );
  }
}

class CardSlideshow extends StatefulWidget {
  const CardSlideshow({super.key});

  @override
  State<CardSlideshow> createState() => _CardSlideshowState();
}

class _CardSlideshowState extends State<CardSlideshow> {
  final PageController _pageController = PageController();
  Timer? _timer; // 2. Declare a Timer variable
   String githubBase = "https://raw.githubusercontent.com/JonathanLam12345/JLStudios.Custom.Pokemon.Cards/refs/heads/main/assets/";

  late final List<String> cardImages = [
    '${githubBase}elsie.png',
    '${githubBase}charizard1.jpg',
    '${githubBase}rowan.jpg',
    '${githubBase}pikachu.jpg',
    '${githubBase}vlad.jpg',
    '${githubBase}charizard.jpg',
    '${githubBase}jason.png',
    '${githubBase}espeon.png',
    '${githubBase}hiro.jpg',
    '${githubBase}charizard_with_stand.jpg',
    '${githubBase}serena.jpg',
    '${githubBase}raz.jpg',
    '${githubBase}philip.jpg',
    '${githubBase}costco.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer(); // 3. Start the initial timer
    //Future.delayed(const Duration(seconds: 10), _autoPlay);
  }

  @override
  void dispose() {
    _timer?.cancel(); // 4. Always cancel timers when the widget is destroyed
    _pageController.dispose();
    super.dispose();
  }

  // 5. This handles the auto-play logic and the "Reset"
  void _startTimer() {
    _timer?.cancel(); // Stop the current countdown
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) % cardImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  // 6. Navigation Logic now includes a call to _startTimer()
  void _moveNext() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      _startTimer(); // This resets the 6-second clock
    }
  }

  void _movePrevious() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      _startTimer(); // This resets the 6-second clock
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 1. UI Elements (The first things users see)
    precacheImage(NetworkImage('${githubBase}instagram_logo.png'), context);
    precacheImage(NetworkImage('${githubBase}how_cards_made.png'), context);

    // 2. Slideshow Images
    // We use the list you already defined
    for (String url in cardImages) {
      precacheImage(NetworkImage(url), context);
    }

    // 3. Holo Pattern Images
    List<String> holoFiles = [
      "scattered_glass.jpg",
      "reflective_rainbow.jpg",
      "fine_sprakle.jpg",
      "scattered_stars.jpg",
    ];

    for (String fileName in holoFiles) {
      precacheImage(NetworkImage('$githubBase$fileName'), context);
    }
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // 1. The Image Slider
            PageView.builder(
              controller: _pageController,
              itemCount: cardImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  cardImages[index],
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child; // Image is finished loading
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFFD4AF37),
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.red),
                );
              },
            ),

            // 2. Left Arrow
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Center(
                child: _navArrow(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: _movePrevious,
                ),
              ),
            ),

            // 3. Right Arrow
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Center(
                child: _navArrow(
                  icon: Icons.arrow_forward_ios,
                  onPressed: _moveNext,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: -0.1);
  }

  // Helper widget for the arrow buttons
  Widget _navArrow({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.3), // Dark subtle circle background
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFFD4AF37), size: 24),
        onPressed: onPressed,
      ),
    );
  }
}

//=====================================

class GeminiDetailPage extends StatelessWidget {
  const GeminiDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can swap this with a specific reference image URL from your GitHub
    const String refCardUrl = "https://raw.githubusercontent.com/JonathanLam12345/JLStudios.Custom.Pokemon.Cards/main/assets/vlad.jpg";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Gemini AI Custom Service"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // Reference Image with a glow effect
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(refCardUrl, height: 400, fit: BoxFit.contain),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),

            const SizedBox(height: 40),

            // Text Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoSection("Process", "Please provide as much information as possible, including reference images of the person and/or pet, full-art design details. Also, include the following card information below. I’ll generate the design using an AI prompt, guiding you throughout the process to ensure it turns out perfect."),
                const SizedBox(height: 20),
                _bulletPoint("Card Name"),
                _bulletPoint("Energy Type & Card HP"),
                // Updated points for Attack/Ability
                _bulletPoint("Attack/Ability names, descriptions, energy type and cost, and damage amounts. (We recommend including only one ability or attack to prevent your full art to be covered.)"),


                _bulletPoint("Weakness, Resistance, and Retreat Cost"),

                const SizedBox(height: 20),
                _infoSection("A Note on Specificity", "We are happy to do minor edits on the generated image. When requesting edits, please be as specific as possible, as it takes time for us to make changes to an image. For example, we once had a customer ask us to 'make the ear brown', but after a day, it turned out to be a typo; they meant 'make the beard brown'."),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("BACK TO SERVICES"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoSection(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 8),
        Text(body, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70)),
      ],
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Increased spacing for readability
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align icon with the top of the text
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFD4AF37), size: 16),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
                  text,
                  style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.white)
              )
          ),
        ],
      ),
    );
  }
}
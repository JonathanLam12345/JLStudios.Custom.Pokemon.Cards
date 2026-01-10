import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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
              child: Image.asset(
                'assets/instagram_logo.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
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
                  "Provide your own art. Recommended 50% subject, 50% background. We will work together to build the Pokémon card for your art.",
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
                  "We will design your full art for you using AI prompts, then we will work together to build the Pokémon theme card. Perfect for turning pets or people into custom Pokémon cards!",
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
                _holoType("Scattered Glass", "assets/scattered_glass.jpg"),
                _holoType(
                  "Reflective Rainbow",
                  "assets/reflective_rainbow.jpg",
                ),
                _holoType("Fine Sparkle", "assets/fine_sprakle.jpg"),
                _holoType("Scattered Stars", "assets/scattered_stars.jpg"),
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
      padding: const EdgeInsets.all(80),
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
          Image.asset(
            'assets/how_cards_made.png',
            width:340, // Adjust this number until it looks right
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Note: We use a white marker technique for selective holo. Small air bubbles or slight 'bulges' may occur due to the layering process, but we use silicon air blowers and dust covers to minimize these.",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            textAlign: TextAlign.center,
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
            textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
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
            // Optional: rounds the splash effect


              child: Image.asset(
                'assets/instagram_logo.png',
                // Ensure this file is in your assets folder
                width: 25,
                height: 25,

                fit: BoxFit.contain,
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
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color(0xFFD4AF37)),
          const SizedBox(height: 20),
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center
          ),
          Text(price, style: const TextStyle(fontSize: 24, color: Color(0xFFD4AF37))),
          const SizedBox(height: 15),
          // Use the widget passed in instead of a plain Text widget
          descWidget,
        ],
      ),
    );
  }

  Widget _holoType(String name, String imgPath) {
    // Renamed imgUrl to imgPath for clarity
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // Changed Image.network to Image.asset
            child: Image.asset(
              imgPath,
              height: 180,
              width: 180,
              fit: BoxFit.cover,
              // Optional: adds a placeholder if the image fails to load
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: 180,
                color: Colors.grey[900],
                child: const Icon(Icons.broken_image, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(name,textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),

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

  final List<String> cardImages = [
    'assets/charizard.jpg',
    'assets/rowan.jpg',
    'assets/pikachu.jpg',
    'assets/vlad.jpg',
    'assets/jason.png',
    'assets/espeon.png',
    'assets/hiro.jpg',
    'assets/serena.jpg',
    'assets/raz.jpg',
    'assets/philip.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), _autoPlay);
  }

  void _autoPlay() {
    if (_pageController.hasClients) {
      int nextPage = (_pageController.page!.toInt() + 1) % cardImages.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
    Future.delayed(const Duration(seconds: 6), _autoPlay); // Slightly faster auto-play
  }

  // Navigation Logic
  void _moveNext() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void _movePrevious() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
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
                return Image.asset(cardImages[index], fit: BoxFit.contain);
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

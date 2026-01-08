import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
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
        title: Text('JLStudios | HoloX',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          if (!isMobile) ...[
            _navButton("About Us", _aboutKey),
            _navButton("Our Services", _servicesKey),
            _navButton("Holo Patterns", _holoKey),
            _navButton("Order Now", _purchaseKey),
          ],
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Color(0xFFD4AF37)),
            onPressed: () => _launchURL('https://instagram.com/JLStudios416'),
          ),
          const SizedBox(width: 20),
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
            style: TextStyle(fontSize: 16, letterSpacing: 4, color: Color(0xFFD4AF37)),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
          const SizedBox(height: 20),
          Text(
            "Premium Custom TCGP Cards",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 50, fontWeight: FontWeight.w900),
          ).animate().fadeIn(delay: 400.ms).scale(),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            onPressed: () => _scrollTo(_purchaseKey),
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
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/400x600/222/D4AF37?text=Card+Showcase'),
                  fit: BoxFit.cover,
                ),
              ),
            ).animate().slideX(begin: -0.1),
          ),
          const SizedBox(width: 60, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "About Us", subtitle: "Crafting Physical Legends"),
                const Text(
                  "Ever wished you could hold those stunning digital cards from Pokémon TCGP mobile app game in real life? Now you can! "
                      "Our team offers high-end printed proxy cards that bring your favorite designs to life with premium ink and selective holo technology.",
                  style: TextStyle(fontSize: 18, height: 1.6),
                ),
                const SizedBox(height: 20),
                _featurePoint("Authentic backs for that genuine feel."),
                _featurePoint("Selective Holo: We mask characters so they pop!"),
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
              _serviceCard("Pokemon TCG Full Art Proxy", "\$25", "We remove the holo from TCGP designs for a crisp, premium look.", Icons.style),
              _serviceCard("Custom Full Art", "\$25", "Provide your own art. Recommended 50% subject, 50% background.", Icons.auto_awesome),
              _serviceCard("Gemini AI Custom", "\$35", "We design your pet or person as a Pokémon using AI prompts.", Icons.psychology),
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
          horizontal: 20
      ),
      child: Column(
        children: [
          const SectionHeader(
              title: "Holographic Patterns",
              subtitle: "Select Your Shine"
          ),
          const SizedBox(height: 40),

          // Constrain the width so the images don't spread too far apart on wide monitors
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Wrap(
              spacing: 25,      // Space between images horizontally
              runSpacing: 30,   // Space between images vertically (the "next row" gap)
              alignment: WrapAlignment.center, // Centers items in the row
              children: [
                _holoType("Scattered Glass", "assets/scattered_glass.jpg"),
                _holoType("Reflective Rainbow", "assets/reflective_rainbow.jpg"),
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
          const SectionHeader(title: "How To Purchase", subtitle: "Simple 4-Step Process"),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _stepCircle("1", "DM on Instagram @JLStudios416"),
              _stepCircle("2", "Choose Pickup (Bayview) or Shipping (\$5)"),
              _stepCircle("3", "50% Deposit via E-Transfer/Cash"),
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
          const SectionHeader(title: "How It's Made", subtitle: "The Craftsmanship"),
          const SizedBox(height: 30),
          const Text(
            "We are active members of r/customtradingcard. Our process involves pressing two vinyl sheets onto a real Pokémon card base.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          Image.network('https://via.placeholder.com/800x400/222/D4AF37?text=Layers+Diagram+Image'),
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
        children: [
          const Icon(Icons.verified_user, color: Color(0xFFD4AF37), size: 50),
          const SizedBox(height: 20),
          const Text("Handling & Storage", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text(
            "• Keep in the included sleeve at all times.\n"
                "• Do NOT use wet wipes (ink may smear).\n"
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
          const SectionHeader(title: "AI Art Philosophy", subtitle: "Adapting to the Future"),
          const SizedBox(height: 20),
          const Text(
            "We use Gemini AI to bring your visions to life. We offer minor edits on generated images. "
                "Please be specific! (One client asked for a brown 'ear' when they meant 'beard'—precision saves time!)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
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
          const Text("© 2025 JLSTUDIOS | RICHMOND HILL, CA"),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Color(0xFFD4AF37)),
            onPressed: () => _launchURL('https://instagram.com/JLStudios416'),
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

  Widget _serviceCard(String title, String price, String desc, IconData icon) {
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
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(fontSize: 24, color: Color(0xFFD4AF37))),
          const SizedBox(height: 15),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _holoType(String name, String imgPath) { // Renamed imgUrl to imgPath for clarity
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 180,
      child: Column(
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
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _stepCircle(String num, String text) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFD4AF37),
            child: Text(num, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          Text(text, textAlign: TextAlign.center),
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
        Text(title.toUpperCase(),
            style: const TextStyle(color: Color(0xFFD4AF37), letterSpacing: 4, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(subtitle, style: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Container(width: 60, height: 2, color: const Color(0xFFD4AF37)),
      ],
    );
  }
}
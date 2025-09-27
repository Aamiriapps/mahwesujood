import 'dart:ui';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.brown[900],
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.transparent),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'About Us',
          style: GoogleFonts.cormorantGaramond(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                //Colors.brown.shade900,
                Color(0xFF92772C),
                Color(0xFF2F2005),

                //Color(0xFF2F2005),
              ],
              radius: 0.9,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: 90),
                // Centered big image
                Center(child: Image.asset('assets/g14636.png', height: 200)),
                const SizedBox(height: 30),

                // Title
                Text(
                  'Habibi Foundation (R)',
                  style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Silsila-e-Aamiria\nBangalore, Karnataka, India',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.white54),
                const SizedBox(height: 20),

                Text(
                  'Website:',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'www.habibifoundation.org',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.lightBlueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact:',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '+91 96202 02474',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

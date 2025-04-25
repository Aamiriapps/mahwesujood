import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'About Us',
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.brown.shade900,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Centered big image
            Center(
              child: Image.asset(
                'assets/g14636.png',
                height: 200,
              ),
            ),
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
    );
  }
}

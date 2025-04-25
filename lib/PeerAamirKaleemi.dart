import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PeerAamirKaleemiScreen extends StatelessWidget {
  const PeerAamirKaleemiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Peer Aamir Kaleemi RA',
          style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.brown.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''
        Shamasul Mufassireen Faridul Asr Allama Alhaaj Syed Muhammed Omer Aamir Kaleemi Shah Hasni-Ul-Hussaini Jafari-Ul-Jeelani Chishti Qadri Noori Khwaja Faqeer Nawaz (رحمة الله عليه) was a revered Sufi saint, scholar, and spiritual guide based in South India. He is renowned for founding the Silsila-e-Aamiria, a spiritual lineage rooted in the Chishti and Qadiri orders. He was a descendant of the esteemed Sufi master Sheikh Abdul Qadir Jilani, being his 30th-generation grandson.
        ''',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
          
              // Centered image after the first paragraph
              Center(
                child: Image.asset(
                  'assets/sarkar.png', // adjust path as per your structure
                  height: 350,
                  fit: BoxFit.contain,
                ),
              ),
          
              const SizedBox(height: 20),
          
              Text(
                '''
          Hazrat Aamir Kaleemi Shah Noori was a disciple (murid) of the renowned Sufi saint Noor-ul-Mashaikh Sayyid Ahmed Muhiyuddin Jeelani Noori Shah (رحمة الله عليه), a prominent figure in the Chishti-Qadiri Sufi tradition. Under his guidance, Hazrat Aamir Kaleemi Shah Noori underwent extensive spiritual training and was appointed as a khalifa (spiritual successor), leading to the establishment of the Silsila-e-Aamiria.
          
          He was a prolific author, with works such as Mehwe Sujood, a collection of Urdu spiritual poetry encompassing Hamd (praise of Allah), Naat (praise of the Prophet Muhammad ﷺ), Manqabat (praise of saints), and Rubaiyat (quatrains). His writings reflect deep insights into Tasawwuf (Sufism) and Islamic spirituality.
          
          Hazrat Aamir Kaleemi Shah Noori was known for his profound knowledge of Islamic sciences, including Fiqh (Islamic jurisprudence), Hadith (Prophetic traditions), and Tafsir (Quranic exegesis). He was honored with titles such as "Shams-ul-Mufassireen" (Sun of the Exegetes) and "Sultan-ul-Arifeen" (King of the Gnostics) for his scholarly contributions and spiritual teachings.
          ''',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

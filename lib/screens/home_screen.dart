// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'payment_screen.dart';
import 'multi_equipment_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featuredEquipment = [
      {
        'name': 'Tractor',
        'price': 'NGN 8000/hour',
        'image': 'assets/tractor.png',
        'location': 'Kano',
        'owner': 'John Doe',
        'rating': '4.5'
      },
      {
        'name': 'Thresher',
        'price': 'NGN 10000/hour',
        'image': 'assets/thresher.png',
        'location': 'Ebonyi',
        'owner': 'Amina Bello',
        'rating': '4.8'
      },
      {
        'name': 'Irrigation Pump',
        'price': 'NGN 5000/hour',
        'image': 'assets/pump.png',
        'location': 'Kaduna',
        'owner': 'Musa Ibrahim',
        'rating': '4.2'
      },
    ];

    final additionalEquipment = [
      {
        'name': 'Power Tiller',
        'price': 'NGN 6000/hour',
        'image': 'assets/tiller.png',
        'location': 'Ebonyi',
        'owner': 'Fatima Usman',
        'rating': '4.0'
      },
      {
        'name': 'Seed Planter',
        'price': 'NGN 7000/hour',
        'image': 'assets/seedplanter.png',
        'location': 'Kano',
        'owner': 'Yusuf Ali',
        'rating': '4.3'
      },
      {
        'name': 'Harvester',
        'price': 'NGN 12000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Hassan Sani',
        'rating': '4.7'
      },
      {
        'name': 'Sprayer',
        'price': 'NGN 4000/hour',
        'image': 'assets/sprayer.png',
        'location': 'Kano',
        'owner': 'Aisha Mohammed',
        'rating': '4.1'
      },
      {
        'name': 'Harrow',
        'price': 'NGN 5500/hour',
        'image': 'assets/harrow.png',
        'location': 'Ebonyi',
        'owner': 'Ibrahim Sani',
        'rating': '4.4'
      },
      {
        'name': 'Combine Harvester',
        'price': 'NGN 15000/hour',
        'image': 'assets/combine_harvester.png',
        'location': 'Kano',
        'owner': 'Fatima Ali',
        'rating': '4.6'
      },
      {
        'name': 'Plows',
        'price': 'NGN 4500/hour',
        'image': 'assets/plows.png',
        'location': 'Kano',
        'owner': 'Yusuf Bello',
        'rating': '4.0'
      },
      {
        'name': 'Cultivator',
        'price': 'NGN 5000/hour',
        'image': 'assets/cultivator.png',
        'location': 'Kaduna',
        'owner': 'Hassan Musa',
        'rating': '4.2'
      },
      {
        'name': 'Loaders',
        'price': 'NGN 9000/hour',
        'image': 'assets/loader.png',
        'location': 'Kano',
        'owner': 'Aminu Sani',
        'rating': '4.5'
      },
      {
        'name': 'Sprinkler',
        'price': 'NGN 3000/hour',
        'image': 'assets/sprinkler.png',
        'location': 'Kano',
        'owner': 'Maryam Ali',
        'rating': '4.1'
      },
      {
        'name': 'Baler',
        'price': 'NGN 7000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Abdullahi Sani',
        'rating': '4.4'
      },
      {
        'name': 'Rake',
        'price': 'NGN 3500/hour',
        'image': 'assets/rake.png',
        'location': 'Kano',
        'owner': 'Fatima Yusuf',
        'rating': '4.2'
      },
      {
        'name': 'Manure Spreader',
        'price': 'NGN 6000/hour',
        'image': 'assets/tractor.png',
        'location': 'Kano',
        'owner': 'Amina Musa',
        'rating': '4.3'
      },
      {
        'name': 'Planter',
        'price': 'NGN 6500/hour',
        'image': 'assets/seedplanter.png',
        'location': 'Kano',
        'owner': 'Hassan Bello',
        'rating': '4.4'
      },
      {
        'name': 'Thresher',
        'price': 'NGN 10000/hour',
        'image': 'assets/thresher.png',
        'location': 'Kano',
        'owner': 'Zainab Sani',
        'rating': '4.8'
      },
      {
        'name': 'Cultipacker',
        'price': 'NGN 4000/hour',
        'image': 'assets/tiller.png',
        'location': 'Kano',
        'owner': 'Maryam Yusuf',
        'rating': '4.1'
      },
      {
        'name': 'Farm Truck',
        'price': 'NGN 8000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Abdullahi Musa',
        'rating': '4.5'
      },
      {
        'name': 'Fertilizer Injecter',
        'price': 'NGN 4500/hour',
        'image': 'assets/fertilizer_injecter.png',
        'location': 'Kano',
        'owner': 'Aisha Ali',
        'rating': '4.2'
      },
      {
        'name': 'Mower',
        'price': 'NGN 3500/hour',
        'image': 'assets/mower.png',
        'location': 'Kano',
        'owner': 'Yusuf Sani',
        'rating': '4.0'
      },
    ];

    void _navigateToPayment(Map<String, String> equipment) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            equipmentName: equipment['name']!,
            equipmentPrice: equipment['price']!,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green[700],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gradient Header
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green[800]!, Colors.green[400]!],
                  ),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.asset('assets/agrishare_logo2.png', height: 60),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search equipment...',
                            prefixIcon: const Icon(Icons.search, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Searching for $value')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Featured Equipment Carousel
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MultiEquipmentSelectionScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[600],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Need more than one equipment? Click here'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Featured Equipment',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.55,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: true,
                      ),
                      items: featuredEquipment.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                    child: Image.asset(
                                      item['image']!,
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name']!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['price']!,
                                          style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Location: ${item['location']}',
                                          style: TextStyle(color: Colors.grey[600]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            Text(
                                              'Rating: ${item['rating']}',
                                              style: TextStyle(color: Colors.grey[600]),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () => _navigateToPayment(item),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber[600],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              minimumSize: const Size(100, 36),
                                            ),
                                            child: const Text('Book Now', style: TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    // Additional Equipment Grid
                    const Text(
                      'More Equipment',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.55,
                      ),
                      itemCount: additionalEquipment.length,
                      itemBuilder: (context, index) {
                        final item = additionalEquipment[index];
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.asset(
                                  item['image']!,
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    color: Colors.grey[300],
                                    child: const Center(child: Text('Image not found')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            item['price']!,
                                            style: TextStyle(
                                              color: Colors.green[700],
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Location: ${item['location']}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, color: Colors.amber, size: 12),
                                              Flexible(
                                                child: Text(
                                                  'Rating: ${item['rating']}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () => _navigateToPayment(item),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[600],
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            minimumSize: const Size(80, 30),
                                          ),
                                          child: const Text(
                                            'Book Now',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> with SingleTickerProviderStateMixin {
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

  void _openTrainingDetail(BuildContext context, Map<String, String> resource) {
    showDialog(
      context: context,
      builder: (context) => TrainingDetailDialog(resource: resource),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingResources = [
      {
        'id': '1',
        'title': 'Tractor Usage Guide',
        'type': 'Video',
        'image': 'assets/tractor_training.jpg',
        'duration': '10 min',
        'description': 'Learn how to operate a tractor efficiently for plowing and tilling.',
      },
      {
        'id': '2',
        'title': 'Climate-Smart Farming',
        'type': 'Guide',
        'image': 'assets/climate_smart_training.jpg',
        'duration': '15 min',
        'description': 'Adopt sustainable practices to improve crop yields in Kano.',
      },
    ];

    return Scaffold(
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
                            hintText: 'Search training resources...',
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
              // Training Resources
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Training Resources',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trainingResources.length,
                      itemBuilder: (context, index) {
                        final resource = trainingResources[index];
                        return GestureDetector(
                          onTap: () => _openTrainingDetail(context, resource),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: Image.asset(
                                    resource['image']!,
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
                                        resource['title']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Type: ${resource['type']}',
                                        style: TextStyle(color: Colors.grey[600]),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Duration: ${resource['duration']}',
                                        style: TextStyle(color: Colors.grey[600]),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.play_circle,
                                      color: Colors.green[700],
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20), // Bottom padding
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

class TrainingDetailDialog extends StatelessWidget {
  final Map<String, String> resource;

  const TrainingDetailDialog({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[200]!, Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8, // Limit dialog height
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      resource['image']!,
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  resource['title']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                _buildDetailItem('Type', resource['type']!),
                const Divider(),
                _buildDetailItem('Duration', resource['duration']!),
                const Divider(),
                _buildDetailItem('Description', resource['description']!),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Playing ${resource['title']}')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.play_circle, color: Colors.white),
                    label: const Text('Start Training'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 3, // Allow description to wrap if needed
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({Key? key}) : super(key: key);

  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {

  

  double rating = 4.9;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1515378792082-1076c0944940'),
            ),
          ),
          const Text(
            '★ 4.9',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '(531 reviews)',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rate Your Experience as a rider ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Add Description:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter your description here...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

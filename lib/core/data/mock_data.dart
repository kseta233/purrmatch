/// Mock data for testing the app without backend
class MockData {
  MockData._();

  /// Sample cat profiles for the swipe feed
  static List<Map<String, dynamic>> get cats => [
    {
      'id': '1',
      'name': 'Mochi',
      'breed': 'British Shorthair',
      'birthDate': DateTime(2022, 3, 15),
      'gender': 'Male',
      'location': 'Jakarta Selatan',
      'distance': '2 km away',
      'photos': [
        'https://placekitten.com/400/600',
        'https://placekitten.com/401/601',
      ],
      'isVerified': true,
      'isSterilized': false,
      'vaccinationStatus': 'Full',
      'tags': ['Playful', 'Cuddly', 'Active'],
      'about': 'Mochi loves to play fetch and cuddle on cold nights. Very friendly with other cats!',
      'owner': {
        'id': 'owner1',
        'name': 'Sarah Kusuma',
        'photo': 'https://i.pravatar.cc/150?img=1',
        'instagram': '@sarahkusuma',
      },
    },
    {
      'id': '2',
      'name': 'Luna',
      'breed': 'Persian',
      'birthDate': DateTime(2021, 8, 20),
      'gender': 'Female',
      'location': 'Bandung',
      'distance': '5 km away',
      'photos': [
        'https://placekitten.com/402/602',
        'https://placekitten.com/403/603',
      ],
      'isVerified': true,
      'isSterilized': true,
      'vaccinationStatus': 'Partial',
      'tags': ['Calm', 'Independent', 'Chill'],
      'about': 'Luna is a gentle soul who enjoys sunbathing by the window. Perfect for a calm companion.',
      'owner': {
        'id': 'owner2',
        'name': 'Budi Santoso',
        'photo': 'https://i.pravatar.cc/150?img=3',
        'instagram': '@budisantoso',
      },
    },
    {
      'id': '3',
      'name': 'Simba',
      'breed': 'Maine Coon',
      'birthDate': DateTime(2020, 12, 1),
      'gender': 'Male',
      'location': 'Jakarta Pusat',
      'distance': '3 km away',
      'photos': [
        'https://placekitten.com/404/604',
        'https://placekitten.com/405/605',
      ],
      'isVerified': false,
      'isSterilized': false,
      'vaccinationStatus': 'Full',
      'tags': ['Active', 'Vocal', 'Playful'],
      'about': 'Simba is the king of the house! He loves to explore and play with toys.',
      'owner': {
        'id': 'owner3',
        'name': 'Dewi Lestari',
        'photo': 'https://i.pravatar.cc/150?img=5',
        'instagram': '@dewilestari',
      },
    },
    {
      'id': '4',
      'name': 'Cleo',
      'breed': 'Siamese',
      'birthDate': DateTime(2023, 1, 10),
      'gender': 'Female',
      'location': 'Depok',
      'distance': '8 km away',
      'photos': [
        'https://placekitten.com/406/606',
        'https://placekitten.com/407/607',
      ],
      'isVerified': true,
      'isSterilized': false,
      'vaccinationStatus': 'Not yet',
      'tags': ['Vocal', 'Cuddly', 'Friendly'],
      'about': 'Cleo is very talkative and loves to follow you around the house!',
      'owner': {
        'id': 'owner4',
        'name': 'Andi Wijaya',
        'photo': 'https://i.pravatar.cc/150?img=8',
        'instagram': '@andiwijaya',
      },
    },
    {
      'id': '5',
      'name': 'Oliver',
      'breed': 'Scottish Fold',
      'birthDate': DateTime(2022, 6, 25),
      'gender': 'Male',
      'location': 'Tangerang',
      'distance': '12 km away',
      'photos': [
        'https://placekitten.com/408/608',
        'https://placekitten.com/409/609',
      ],
      'isVerified': true,
      'isSterilized': true,
      'vaccinationStatus': 'Full',
      'tags': ['Chill', 'Independent', 'Calm'],
      'about': 'Oliver is the most chill cat you\'ll ever meet. Loves naps and treats!',
      'owner': {
        'id': 'owner5',
        'name': 'Maya Putri',
        'photo': 'https://i.pravatar.cc/150?img=9',
        'instagram': '@mayaputri',
      },
    },
  ];

  /// Calculate age from birth date
  static String calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final years = now.year - birthDate.year;
    final months = now.month - birthDate.month;
    
    if (years == 0) {
      return '$months months';
    } else if (years == 1) {
      return '1 year';
    } else {
      return '$years years';
    }
  }

  /// Simulate a match (50% chance)
  static bool checkForMatch() {
    return DateTime.now().millisecond % 2 == 0;
  }

  /// Current user profile (mock)
  static Map<String, dynamic> get currentUser => {
    'id': 'current_user',
    'name': 'You',
    'photo': 'https://i.pravatar.cc/150?img=12',
    'cats': [
      {
        'id': 'my_cat_1',
        'name': 'Whiskers',
        'photo': 'https://placekitten.com/200/200',
      }
    ],
  };
}

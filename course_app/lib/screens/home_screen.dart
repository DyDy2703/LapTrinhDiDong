import 'package:flutter/material.dart';
import 'package:course_app/utils/theme.dart';
import 'package:course_app/screens/course_detail_screen.dart';
import 'package:course_app/widgets/course_card.dart';
import 'package:course_app/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Dữ liệu mẫu cho danh mục
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Lập trình',
      'icon': Icons.code,
      'color': Colors.blue[100],
    },
    {
      'title': 'Marketing',
      'icon': Icons.trending_up,
      'color': Colors.green[100],
    },
    {
      'title': 'Thiết kế',
      'icon': Icons.design_services,
      'color': Colors.purple[100],
    },
    {
      'title': 'Ngoại ngữ',
      'icon': Icons.language,
      'color': Colors.orange[100],
    },
    {
      'title': 'Kinh doanh',
      'icon': Icons.business,
      'color': Colors.red[100],
    },
    {
      'title': 'Phát triển',
      'icon': Icons.psychology,
      'color': Colors.teal[100],
    },
  ];

  // Dữ liệu mẫu cho khóa học phổ biến
  final List<Map<String, dynamic>> _popularCourses = [
    {
      'title': 'Flutter - Học xây dựng ứng dụng di động',
      'instructor': 'Nguyễn Văn A',
      'rating': 4.8,
      'reviews': 1523,
      'price': 599000,
      'discountPrice': 299000,
      'image': 'https://picsum.photos/id/1/200/300',
    },
    {
      'title': 'React Native cho người mới bắt đầu',
      'instructor': 'Trần Thị B',
      'rating': 4.5,
      'reviews': 1208,
      'price': 699000,
      'discountPrice': 349000,
      'image': 'https://picsum.photos/id/2/200/300',
    },
    {
      'title': 'Python từ cơ bản đến nâng cao',
      'instructor': 'Lê Văn C',
      'rating': 4.9,
      'reviews': 2105,
      'price': 799000,
      'discountPrice': 399000,
      'image': 'https://picsum.photos/id/3/200/300',
    },
  ];

  // Dữ liệu mẫu cho khóa học mới
  final List<Map<String, dynamic>> _newCourses = [
    {
      'title': 'Machine Learning với TensorFlow',
      'instructor': 'Phạm Văn D',
      'rating': 4.7,
      'reviews': 523,
      'price': 899000,
      'discountPrice': 449000,
      'image': 'https://picsum.photos/id/4/200/300',
    },
    {
      'title': 'Thiết kế UX/UI cho người mới',
      'instructor': 'Hoàng Thị E',
      'rating': 4.6,
      'reviews': 428,
      'price': 499000,
      'discountPrice': 249000,
      'image': 'https://picsum.photos/id/5/200/300',
    },
    {
      'title': 'Digital Marketing từ A-Z',
      'instructor': 'Ngô Văn F',
      'rating': 4.8,
      'reviews': 856,
      'price': 599000,
      'discountPrice': 299000,
      'image': 'https://picsum.photos/id/6/200/300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? _buildHomeTab() : _buildOtherTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Khóa học',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào,',
                        style: AppTheme.captionStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Học viên',
                        style: AppTheme.headingStyle,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.accentColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm khóa học...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Show filter options
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Danh mục',
                style: AppTheme.subheadingStyle,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return CategoryCard(
                    title: category['title'],
                    icon: category['icon'],
                    color: category['color'],
                    onTap: () {
                      // Navigate to category screen
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Popular Courses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Khóa học phổ biến',
                    style: AppTheme.subheadingStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all popular courses
                    },
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _popularCourses.length,
                itemBuilder: (context, index) {
                  final course = _popularCourses[index];
                  return CourseCard(
                    title: course['title'],
                    instructor: course['instructor'],
                    rating: course['rating'],
                    reviews: course['reviews'],
                    price: course['price'],
                    discountPrice: course['discountPrice'],
                    imageUrl: course['image'],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: course),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // New Courses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Khóa học mới',
                    style: AppTheme.subheadingStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all new courses
                    },
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _newCourses.length,
                itemBuilder: (context, index) {
                  final course = _newCourses[index];
                  return CourseCard(
                    title: course['title'],
                    instructor: course['instructor'],
                    rating: course['rating'],
                    reviews: course['reviews'],
                    price: course['price'],
                    discountPrice: course['discountPrice'],
                    imageUrl: course['image'],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: course),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherTab() {
    // Placeholder for other tabs
    return Center(
      child: Text(
        'Chức năng đang được xây dựng',
        style: AppTheme.subheadingStyle,
      ),
    );
  }
}

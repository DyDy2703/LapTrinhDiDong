import 'package:flutter/material.dart';
import 'package:course_app/utils/theme.dart';
import 'package:course_app/widgets/lesson_card.dart';
import 'package:course_app/screens/video_player_screen.dart';

  class CourseDetailScreen extends StatefulWidget {
    final Map<String, dynamic> course;

    const CourseDetailScreen({
      super.key,
      required this.course,
    });

    @override
    CourseDetailScreenState createState() => CourseDetailScreenState();
  }

class CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isExpanded = false;

  // Dữ liệu mẫu cho các bài học
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Giới thiệu khóa học',
      'duration': '05:30',
      'isPreview': true,
    },
    {
      'title': 'Cài đặt môi trường phát triển',
      'duration': '12:45',
      'isPreview': false,
    },
    {
      'title': 'Tạo dự án đầu tiên',
      'duration': '18:20',
      'isPreview': false,
    },
    {
      'title': 'Các thành phần cơ bản',
      'duration': '22:15',
      'isPreview': false,
    },
    {
      'title': 'Layout và thiết kế giao diện',
      'duration': '25:30',
      'isPreview': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.course['title'],
                child: Image.network(
                  widget.course['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Title and Info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course['title'],
                        style: AppTheme.headingStyle,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Giảng viên: ${widget.course['instructor']}',
                            style: AppTheme.captionStyle,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.course['rating']}',
                                style: AppTheme.captionStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${widget.course['reviews']} đánh giá)',
                                style: AppTheme.captionStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '${_formatCurrency(widget.course['discountPrice'])} đ',
                            style: AppTheme.subheadingStyle.copyWith(
                              color: AppTheme.accentColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_formatCurrency(widget.course['price'])} đ',
                            style: AppTheme.captionStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.successColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-${_calculateDiscount(widget.course['price'], widget.course['discountPrice'])}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Course Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildStatItem(Icons.video_library, '14 bài học'),
                      _buildStatItem(Icons.access_time, '5 giờ học'),
                      _buildStatItem(Icons.downloading, 'Tải xuống'),
                      _buildStatItem(Icons.phonelink, 'Đa nền tảng'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Divider
                const Divider(),

                // Course Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mô tả khóa học',
                        style: AppTheme.subheadingStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Đây là khóa học toàn diện giúp bạn nắm vững kỹ năng phát triển ứng dụng di động. Bạn sẽ học cách xây dựng ứng dụng từ đầu đến cuối, từ thiết kế giao diện đến triển khai lên các nền tảng. Khóa học này phù hợp cho cả người mới bắt đầu và những người đã có kinh nghiệm lập trình.\n\nBạn sẽ học được cách tạo các ứng dụng đẹp mắt và chức năng đầy đủ, hợp với tiêu chuẩn của thị trường. Bên cạnh đó, khóa học còn giới thiệu các kỹ thuật tối ưu và các phương pháp hay nhất trong ngành.',
                        style: AppTheme.bodyStyle,
                        maxLines: _isExpanded ? null : 3,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? 'Thu gọn' : 'Xem thêm',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                const Divider(),

                // Curriculum
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nội dung khóa học',
                        style: AppTheme.subheadingStyle,
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        _lessons.length,
                        (index) => LessonCard(
                          title: _lessons[index]['title'],
                          duration: _lessons[index]['duration'],
                          isPreview: _lessons[index]['isPreview'],
                          onTap: () {
                            if (_lessons[index]['isPreview']) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoPlayerScreen(
                                    lessonTitle: _lessons[index]['title'],
                                  ),
                                ),
                              );
                            } else {
                              // Show dialog to buy the course
                              _showBuyDialog();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    // Show preview
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(
                          lessonTitle: 'Giới thiệu khóa học',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Xem thử'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _showBuyDialog,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('MUA NGAY'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.secondaryTextColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTheme.captionStyle,
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }

  int _calculateDiscount(int originalPrice, int discountPrice) {
    return ((originalPrice - discountPrice) / originalPrice * 100).round();
  }

  void _showBuyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mua khóa học'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bạn có muốn mua khóa học này?'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Giá:'),
                const Spacer(),
                Text(
                  '${_formatCurrency(widget.course['discountPrice'])} đ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to checkout screen
            },
            child: const Text('Mua ngay'),
          ),
        ],
      ),
    );
  }
}
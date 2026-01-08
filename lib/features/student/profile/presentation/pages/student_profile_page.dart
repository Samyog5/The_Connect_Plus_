// import 'package:flutter/material.dart';
// import 'package:tcp/features/student/widgets/custom_navbar.dart';
// import 'student_schedule_page.dart';
// import 'student_notices_page.dart';

// class StudentProfilePage extends StatefulWidget {
//   final String userName;
//   final String userRole;
//   final String userAvatar;
//   final String className;

//   const StudentProfilePage({
//     super.key,
//     required this.userName,
//     required this.userRole,
//     required this.userAvatar,
//     this.className = 'Class 10 - A',
//   });

//   @override
//   State<StudentProfilePage> createState() => _StudentProfilePageState();
// }

// class _StudentProfilePageState extends State<StudentProfilePage> {
//   // int _selectedNavIndex = ;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         elevation: 8,
//         toolbarHeight: 72,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//         ),
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProfileHeader(),
//             const SizedBox(height: 32),
//             _buildProfileSection('Personal Information', [
//               _buildProfileItem('Full Name', widget.userName, Icons.person),
//               _buildProfileItem('Role', widget.userRole, Icons.school),
//               _buildProfileItem('Class', widget.className, Icons.class_),
//               _buildProfileItem('Roll Number', '12345', Icons.tag),
//             ]),
//             const SizedBox(height: 24),
//             _buildProfileSection('Contact Information', [
//               _buildProfileItem('Email', 'student@school.com', Icons.email),
//               _buildProfileItem('Phone', '+977-1234567890', Icons.phone),
//               _buildProfileItem(
//                 'Address',
//                 'Kathmandu, Nepal',
//                 Icons.location_on,
//               ),
//             ]),
//             const SizedBox(height: 24),
//             _buildProfileSection('Academic Information', [
//               _buildProfileItem(
//                 'School',
//                 'EduConnect High School',
//                 Icons.school,
//               ),
//               _buildProfileItem('Board', 'National Board', Icons.verified),
//               _buildProfileItem('Session', '2025-2026', Icons.calendar_today),
//             ]),
//             const SizedBox(height: 32),
//             _buildActionButtons(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomNavBar(
//         selectedIndex: _selectedNavIndex,
//         onTabChanged: (index) {
//           if (index == 0) {
//             // Navigate to Home
//             Navigator.pushReplacementNamed(context, '/');
//           } else if (index == 1) {
//             // Navigate to Schedule
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => StudentSchedulePage(
//                   userName: widget.userName,
//                   userAvatar: widget.userAvatar,
//                 ),
//               ),
//             );
//           } else if (index == 2) {
//             // Navigate to Notices
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => StudentNoticesPage(
//                   userName: widget.userName,
//                   userAvatar: widget.userAvatar,
//                 ),
//               ),
//             );
//           } else if (index == 3) {
//             // Stay on Profile
//           }
//         },
//         isBottomNav: true,
//       ),
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.white, Colors.grey[50]!],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey[200]!, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.06),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: const Color(0xFFB71C1C), width: 3),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: CircleAvatar(backgroundImage: AssetImage(widget.userAvatar)),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             widget.userName,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFB71C1C).withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               widget.className,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFFB71C1C),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileSection(String title, List<Widget> items) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey[200]!, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 4,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFB71C1C),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           ...items
//               .map(
//                 (item) => Column(children: [item, const SizedBox(height: 12)]),
//               )
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileItem(String label, String value, IconData icon) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: const Color(0xFFB71C1C).withValues(alpha: 0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: const Color(0xFFB71C1C), size: 20),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButtons() {
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFB71C1C),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.edit, size: 18),
//                 SizedBox(width: 8),
//                 Text(
//                   'Edit Profile',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           child: OutlinedButton(
//             onPressed: () {},
//             style: OutlinedButton.styleFrom(
//               side: const BorderSide(color: Color(0xFFB71C1C), width: 2),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.logout, size: 18, color: Color(0xFFB71C1C)),
//                 SizedBox(width: 8),
//                 Text(
//                   'Logout',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFFB71C1C),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

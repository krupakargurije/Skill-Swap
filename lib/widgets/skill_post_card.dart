import 'package:flutter/material.dart';
import '../models/skill_post.dart';

class SkillPostCard extends StatelessWidget {
  final SkillPost post;
  final bool isMatched;
  final VoidCallback? onTap;

  const SkillPostCard({
    super.key,
    required this.post,
    this.isMatched = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: isMatched 
            ? Border.all(color: const Color(0xFF48BB78), width: 2)
            : Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with user info and match badge
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF4299E1),
                          Color(0xFF667EEA),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        post.userName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatDate(post.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                                   if (isMatched)
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                       gradient: const LinearGradient(
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                         colors: [
                           Color(0xFF48BB78),
                           Color(0xFF38A169),
                         ],
                       ),
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(
                           color: const Color(0xFF48BB78).withOpacity(0.3),
                           blurRadius: 8,
                           spreadRadius: 0,
                           offset: const Offset(0, 2),
                         ),
                       ],
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         const Icon(
                           Icons.favorite,
                           size: 14,
                           color: Colors.white,
                         ),
                         const SizedBox(width: 4),
                         const Text(
                           'Matched',
                           style: TextStyle(
                             fontSize: 10,
                             fontWeight: FontWeight.w600,
                             color: Colors.white,
                           ),
                         ),
                       ],
                     ),
                   ),
                ],
              ),
              const SizedBox(height: 16),

              // Skills section
              Row(
                children: [
                  // Skill offered
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                                             decoration: BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [
                             const Color(0xFF48BB78).withOpacity(0.1),
                             const Color(0xFF38A169).withOpacity(0.1),
                           ],
                         ),
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(
                           color: const Color(0xFF48BB78).withOpacity(0.2),
                           width: 1,
                         ),
                       ),
                      child: Column(
                        children: [
                          Text(
                            'Offering',
                                                       style: TextStyle(
                             fontSize: 10,
                             fontWeight: FontWeight.w500,
                             color: Color(0xFF48BB78),
                           ),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           post.skillOffered,
                           style: TextStyle(
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                             color: Color(0xFF48BB78),
                           ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Exchange arrow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.swap_horiz,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                  ),
                  
                  // Skill wanted
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                                             decoration: BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [
                             const Color(0xFFED8936).withOpacity(0.1),
                             const Color(0xFFDD6B20).withOpacity(0.1),
                           ],
                         ),
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(
                           color: const Color(0xFFED8936).withOpacity(0.2),
                           width: 1,
                         ),
                       ),
                      child: Column(
                        children: [
                          Text(
                            'Wants',
                                                       style: TextStyle(
                             fontSize: 10,
                             fontWeight: FontWeight.w500,
                             color: Color(0xFFED8936),
                           ),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           post.skillWanted,
                           style: TextStyle(
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                             color: Color(0xFFED8936),
                           ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Availability (if provided)
              if (post.availability != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                   decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                     colors: [
                       const Color(0xFF4299E1).withOpacity(0.1),
                       const Color(0xFF667EEA).withOpacity(0.1),
                     ],
                   ),
                   borderRadius: BorderRadius.circular(12),
                   border: Border.all(
                     color: const Color(0xFF4299E1).withOpacity(0.2),
                     width: 1,
                   ),
                 ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                                             color: Color(0xFF4299E1),
                   ),
                   const SizedBox(width: 8),
                   Text(
                     'Available: ${post.availability}',
                     style: TextStyle(
                       fontSize: 12,
                       color: Color(0xFF4299E1),
                       fontWeight: FontWeight.w500,
                     ),
                      ),
                    ],
                  ),
                ),
              ],

              // Action button
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.message, size: 16),
                  label: const Text('View Details'),
                                   style: OutlinedButton.styleFrom(
                   foregroundColor: const Color(0xFF4299E1),
                   side: const BorderSide(color: Color(0xFF4299E1)),
                   padding: const EdgeInsets.symmetric(vertical: 12),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                   ),
                 ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
} 
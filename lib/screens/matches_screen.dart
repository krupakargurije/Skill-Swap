import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/skill_provider.dart';
import '../providers/auth_provider.dart';
import '../models/match.dart';

class MatchesScreen extends StatefulWidget {
  final VoidCallback? onNavigateToAddPost;
  
  const MatchesScreen({super.key, this.onNavigateToAddPost});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: Consumer<SkillProvider>(
        builder: (context, skillProvider, child) {
          final currentUserId = Provider.of<AuthProvider>(context, listen: false).currentUserId;
          final matches = skillProvider.getMatchesForUser(currentUserId ?? '');

          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No matches yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'When your skills match with others,\n they\'ll appear here!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to add post screen using callback
                      widget.onNavigateToAddPost?.call();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Skill Post'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildMatchCard(match, currentUserId!),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMatchCard(Match match, String currentUserId) {
    final isUser1 = match.user1Id == currentUserId;
    final otherUser = isUser1 ? match.user2Name : match.user1Name;
    final mySkillOffered = isUser1 ? match.user1SkillOffered : match.user2SkillOffered;
    final mySkillWanted = isUser1 ? match.user1SkillWanted : match.user2SkillWanted;
    final theirSkillOffered = isUser1 ? match.user2SkillOffered : match.user1SkillOffered;
    final theirSkillWanted = isUser1 ? match.user2SkillWanted : match.user1SkillWanted;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Perfect Match!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(match.matchedAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Users and Skills
            Row(
              children: [
                // Your side
                Expanded(
                  child: _buildUserSkillSection(
                    'You',
                    mySkillOffered,
                    mySkillWanted,
                    Colors.blue,
                  ),
                ),
                
                // Exchange arrow
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.swap_horiz,
                        color: Colors.grey,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      const Icon(
                        Icons.swap_horiz,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ],
                  ),
                ),

                // Other user side
                Expanded(
                  child: _buildUserSkillSection(
                    otherUser,
                    theirSkillOffered,
                    theirSkillWanted,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showMessageDialog(otherUser),
                    icon: const Icon(Icons.message),
                    label: const Text('Message'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showMatchDetails(match, currentUserId),
                    icon: const Icon(Icons.info),
                    label: const Text('Details'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSkillSection(String userName, String skillOffered, String skillWanted, Color color) {
    return Column(
      children: [
        // User name
        Text(
          userName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        
        // Skill offered
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Offers',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                skillOffered,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // Skill wanted
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Wants',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange.shade700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                skillWanted,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessageDialog(String otherUserName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Message'),
        content: Text(
          'This is a demo app. In a real app, this would open a chat with $otherUserName.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Message sent to $otherUserName! (Demo)'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showMatchDetails(Match match, String currentUserId) {
    final isUser1 = match.user1Id == currentUserId;
    final otherUser = isUser1 ? match.user2Name : match.user1Name;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Match title
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 48,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Perfect Match!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Matched on ${_formatDate(match.matchedAt)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Match details
              _buildDetailRow('You', isUser1 ? match.user1Name : match.user2Name),
              _buildDetailRow('Other User', otherUser),
              const SizedBox(height: 16),
              
              const Divider(),
              const SizedBox(height: 16),
              
              _buildDetailRow('You Offer', isUser1 ? match.user1SkillOffered : match.user2SkillOffered),
              _buildDetailRow('You Want', isUser1 ? match.user1SkillWanted : match.user2SkillWanted),
              _buildDetailRow('They Offer', isUser1 ? match.user2SkillOffered : match.user1SkillOffered),
              _buildDetailRow('They Want', isUser1 ? match.user2SkillWanted : match.user1SkillWanted),

              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessageDialog(otherUser);
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Start Conversation'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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
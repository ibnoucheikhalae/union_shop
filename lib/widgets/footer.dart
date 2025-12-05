import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 24 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- UPPER FOOTER CONTENT ----
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Opening Hours
                    const Text(
                      "Opening Hours",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "❄️ Winter Break Closure Dates ❄️\n"
                      "\nClosing 4pm 19/12/2025\n"
                      "Reopening 10am 05/01/2026\n"
                      "\nLast post date: 12pm on 18/12/2025\n"
                      "-------------------------\n"
                      "\n(Term Time)\n"
                      "Monday - Friday 10am – 4pm\n"
                      "\n(Outside of Term Time)\n"
                      "Monday - Friday 10am – 3pm\n"
                      "\nPurchase online 24/7",
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Help & Info
                    const Text(
                      "Help and Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("Search"),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("Terms & Conditions"),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("Policy"),
                    ),
                    const SizedBox(height: 24),

                    // Newsletter
                    const Text(
                      "Latest Offers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Email address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: const Text("SUBSCRIBE"),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Opening Hours
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Opening Hours",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "❄️ Winter Break Closure Dates ❄️\n"
                            "\nClosing 4pm 19/12/2025\n"
                            "Reopening 10am 05/01/2026\n"
                            "\nLast post date: 12pm on 18/12/2025\n"
                            "-------------------------\n"
                            "\n(Term Time)\n"
                            "Monday - Friday 10am – 4pm\n"
                            "\n(Outside of Term Time / Consolidation Weeks)\n"
                            "Monday - Friday 10am – 3pm\n"
                            "\nPurchase online 24/7",
                            style: TextStyle(
                              height: 1.4,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 32),

                    // Help & Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Help and Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/search');
                            },
                            child: const Text("Search"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Terms & Conditions of Sale"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Policy"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 32),

                    // Newsletter
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Latest Offers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Email address",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4d2963),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                ),
                                child: const Text("SUBSCRIBE"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

          const SizedBox(height: 40),
          const Divider(),

          // ---- LOWER FOOTER ----
          const SizedBox(height: 20),
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Social icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook, color: Colors.grey[700], size: 24),
                        const SizedBox(width: 16),
                        Icon(Icons.camera_alt, color: Colors.grey[700], size: 24),
                        const SizedBox(width: 16),
                        Icon(Icons.local_post_office, color: Colors.grey[700], size: 24),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "© 2025 Student Shop",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Social icons (dummy)
                    Row(
                      children: [
                        Icon(Icons.facebook, color: Colors.grey[700]),
                        const SizedBox(width: 12),
                        Icon(Icons.camera_alt, color: Colors.grey[700]), // fake IG
                        const SizedBox(width: 12),
                        Icon(Icons.local_post_office, color: Colors.grey[700]),
                      ],
                    ),

                    const Text(
                      "© 2025, Student Shop — Demo Footer",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

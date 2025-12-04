import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- UPPER FOOTER CONTENT ----
          Row(
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

              
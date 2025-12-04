import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../services/cart_service.dart';
import '../models/product.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

    // Product type & colour
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _productType,
                          decoration: const InputDecoration(
                            labelText: 'Product',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'hoodie',
                              child: Text('Hoodie'),
                            ),
                            DropdownMenuItem(
                              value: 'tshirt',
                              child: Text('T-Shirt'),
                            ),
                            DropdownMenuItem(
                              value: 'sweatshirt',
                              child: Text('Sweatshirt'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other garment'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _productType = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _garmentColour,
                          decoration: const InputDecoration(
                            labelText: 'Garment colour',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'navy',
                              child: Text('Navy'),
                            ),
                            DropdownMenuItem(
                              value: 'black',
                              child: Text('Black'),
                            ),
                            DropdownMenuItem(
                              value: 'grey',
                              child: Text('Grey'),
                            ),
                            DropdownMenuItem(
                              value: 'white',
                              child: Text('White'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _garmentColour = v);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

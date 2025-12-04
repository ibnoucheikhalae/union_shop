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

    // Print position & number of lines
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _printPosition,
                          decoration: const InputDecoration(
                            labelText: 'Print position',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'front',
                              child: Text('Front'),
                            ),
                            DropdownMenuItem(
                              value: 'back',
                              child: Text('Back'),
                            ),
                            DropdownMenuItem(
                              value: 'sleeve',
                              child: Text('Sleeve (demo)'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _printPosition = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _numLines,
                          decoration: const InputDecoration(
                            labelText: 'Number of lines',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('1 line'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('2 lines'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('3 lines'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _numLines = v);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
 // Dynamic text fields
                  _buildLineField(
                    label: 'Line 1 text',
                    value: _line1,
                    onChanged: (t) => _line1 = t,
                  ),
                  if (_numLines >= 2)
                    _buildLineField(
                      label: 'Line 2 text',
                      value: _line2,
                      onChanged: (t) => _line2 = t,
                    ),
                  if (_numLines >= 3)
                    _buildLineField(
                      label: 'Line 3 text',
                      value: _line3,
                      onChanged: (t) => _line3 = t,
                    ),
      
      // Font style & colour
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _fontStyle,
                          decoration: const InputDecoration(
                            labelText: 'Font style',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'block',
                              child: Text('Block'),
                            ),
                            DropdownMenuItem(
                              value: 'script',
                              child: Text('Script'),
                            ),
                            DropdownMenuItem(
                              value: 'sport',
                              child: Text('Sport'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _fontStyle = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _fontColour,
                          decoration: const InputDecoration(
                            labelText: 'Print colour',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'white',
                              child: Text('White'),
                            ),
                            DropdownMenuItem(
                              value: 'gold',
                              child: Text('Gold'),
                            ),
                            DropdownMenuItem(
                              value: 'purple',
                              child: Text('Union purple'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _fontColour = v);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
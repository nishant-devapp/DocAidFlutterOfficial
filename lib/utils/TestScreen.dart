import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Add uuid package

class Testscreen extends StatefulWidget {
  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  List<CardModel> cardList = [CardModel()]; // Start with one card

  void addCard() {
    setState(() {
      cardList.add(CardModel()); // Add a new card with a unique ID
    });
  }

  void removeCard(String id) {
    setState(() {
      cardList.removeWhere(
          (card) => card.id == id); // Removes only the specific card
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Cards")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return DynamicCard(
              key: ValueKey(cardList[index].id),
              // Ensures each card is uniquely identified
              model: cardList[index],
              onDelete: () => removeCard(cardList[index].id),
              // Pass the ID of the card
              onAdd: addCard,
              showDelete: cardList.length > 1,
              // Always show delete button if more than 1 card
              showAdd: index ==
                  cardList.length - 1, // Show add button only on last card
            );
          },
        ),
      ),
    );
  }
}

// Model with a unique ID
class CardModel {
  final String id;
  String dropdownValue1;
  String dropdownValue2;
  TextEditingController textController1;
  TextEditingController textController2;

  CardModel({
    String? id,
    this.dropdownValue1 = 'Option 1',
    this.dropdownValue2 = 'Option A',
    String textField1 = '',
    String textField2 = '',
  })  : id = id ?? Uuid().v4(),
        textController1 = TextEditingController(text: textField1),
        textController2 = TextEditingController(text: textField2);
}

// Dynamic Card Widget
class DynamicCard extends StatefulWidget {
  final CardModel model;
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  final bool showDelete;
  final bool showAdd;

  const DynamicCard({
    Key? key,
    required this.model,
    required this.onDelete,
    required this.onAdd,
    required this.showDelete,
    required this.showAdd,
  }) : super(key: key);

  @override
  _DynamicCardState createState() => _DynamicCardState();
}

class _DynamicCardState extends State<DynamicCard> {
  String? dropdownValue1;
  String? dropdownValue2;
  String? selectedDose, selectedWhen, selectedFreq;
  TextEditingController? nameController, durationController;

  final List<String> doses = [
    '0-0-0',
    '1-0-1',
    '1-1-0',
    '0-1-1',
    '0-0-1',
    '0-1-0',
    '1-0-0',
    '1-1-1'
  ];

  final List<String> whens = [
    'After food',
    'Before Meal',
    'After Meal',
    'Empty Stomach',
    'Bed Time'
  ];

  final List<String> frequencies = [
    'Daily',
    'After 2 Days',
    'Weekly',
    'Fortnightly',
    'Monthly',
    'Stat',
    'SOS'
  ];

  @override
  void initState() {
    super.initState();
    dropdownValue1 = widget.model.dropdownValue1.isNotEmpty
        ? widget.model.dropdownValue1
        : null;
    dropdownValue2 = widget.model.dropdownValue2.isNotEmpty
        ? widget.model.dropdownValue2
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter medicine name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: DropdownButtonFormField<String>(
                  value: selectedDose,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Dose',
                  ),
                  hint: const Text('Select Dose'),
                  // This shows when value is null
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text("Select Dose"),
                    ),
                    ...doses.map((dose) => DropdownMenuItem<String>(
                          value: dose,
                          child: Text(dose),
                        )),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedDose = value;
                    });
                  },
                )),
                const SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedWhen,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'When',
                    ),
                    hint: const Text('Select When'),
                    // This shows when value is null
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text("Select When"),
                      ),
                      ...whens.map((when) => DropdownMenuItem<String>(
                            value: when,
                            child: Text(when),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedWhen = value;
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFreq,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Frequency',
                    ),
                    hint: const Text('Select Frequency'),
                    // This shows when value is null
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text("Select Frequency"),
                      ),
                      ...frequencies.map((freq) => DropdownMenuItem<String>(
                            value: freq,
                            child: Text(freq),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFreq = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: durationController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('Duration'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter duration';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Delete Button (Show if there are more than 1 cards)
                if (widget.showDelete)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: widget.onDelete,
                  ),

                // Add Button (Only on the last card)
                if (widget.showAdd)
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("Add"),
                    onPressed: widget.onAdd,
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
      cardList.removeWhere((card) => card.id == id); // Removes only the specific card
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
              key: ValueKey(cardList[index].id), // Ensures each card is uniquely identified
              model: cardList[index],
              onDelete: () => removeCard(cardList[index].id), // Pass the ID of the card
              onAdd: addCard,
              showDelete: cardList.length > 1, // Always show delete button if more than 1 card
              showAdd: index == cardList.length - 1, // Show add button only on last card
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

  @override
  void initState() {
    super.initState();
    dropdownValue1 = widget.model.dropdownValue1.isNotEmpty ? widget.model.dropdownValue1 : null;
    dropdownValue2 = widget.model.dropdownValue2.isNotEmpty ? widget.model.dropdownValue2 : null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown 1
            DropdownButtonHideUnderline(
            child: DropdownButton<String>(
            value: null,  // Ensures no option is selected initially
              isExpanded: true,
            hint: Text("Select Dose"), // Shows when no option is selected
            items: [
              DropdownMenuItem<String>(
                value: null, // Disable selection of the placeholder
                child: Text("Select Dose"),
              ),
              DropdownMenuItem<String>(
                value: "0-0-0",
                child: Text("0-0-0"),
              ),
              DropdownMenuItem<String>(
                value: "Option 2",
                child: Text("Option 2"),
              ),
              DropdownMenuItem<String>(
                value: "Option 3",
                child: Text("Option 3"),
              ),
            ],
            onChanged: (val) {
              setState(() {
                dropdownValue1 = val ?? '';  // Update with the selected value or keep it empty
                widget.model.dropdownValue1 = val ?? ''; // Update model
              });
            },
            ),
          ),


          SizedBox(height: 8),

            // Dropdown 2 (Select When)
            DropdownButtonFormField<String>(
              value: dropdownValue2,
              hint: Text("Select When..."), // Show this when value is null
              items: ['Option A', 'Option B', 'Option C']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  dropdownValue2 = val;
                  widget.model.dropdownValue2 = val ?? ''; // Store only if selected
                });
              },
              decoration: InputDecoration(labelText: "When"),
            ),

            SizedBox(height: 8),

            // Text Field 1
            TextField(
              controller: widget.model.textController1,
              decoration: InputDecoration(labelText: "Enter Text 1"),
            ),

            SizedBox(height: 8),

            // Text Field 2
            TextField(
              controller: widget.model.textController2,
              decoration: InputDecoration(labelText: "Enter Text 2"),
            ),

            SizedBox(height: 12),

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
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

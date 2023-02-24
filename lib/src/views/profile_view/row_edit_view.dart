// описание экрана редактирования поле профиля
import 'package:flutter/material.dart';
import 'package:joyvee/src/widgets/buttons.dart';
import 'package:joyvee/src/widgets/text_fields.dart';

class RowEditView extends StatefulWidget {
  RowEditView({
    super.key, 
    required this.callback, 
    required this.rowData, 
    required this.rowName,
    this.maxLines = 1,
    this.maxLength = 30
  });
  final Function(dynamic) callback;
  final String rowName;
  final String rowData;
  final int maxLines;
  final int maxLength;
  @override
  State<RowEditView> createState() => _RowEditViewState();
}

class _RowEditViewState extends State<RowEditView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.rowData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(widget.rowName),
        centerTitle: true,
        actions: [
          JoyveeTextButton(
            func: () {
              widget.callback(_controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save", 
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: JoyveeDefaultTextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17 * MediaQuery.textScaleFactorOf(context), fontWeight: FontWeight.w400),
          hintText: "Aa",
          showSuffix: true,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          suffixIcon: IconButton(
            onPressed: () => setState(() => _controller.clear()),
            icon: const Icon(Icons.clear)
          ),
        ),
      ),
    );
  }
}
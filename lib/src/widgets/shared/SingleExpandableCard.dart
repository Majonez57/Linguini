import 'package:flutter/material.dart';

class SingleExpandablePanel extends StatefulWidget {
  final Widget Function(BuildContext, bool) headerBuilder;
  final Widget body;

  const SingleExpandablePanel(
      {super.key, required this.headerBuilder, required this.body});

  @override
  State<SingleExpandablePanel> createState() => _SingleExpandablePanelState();
}

class _SingleExpandablePanelState extends State<SingleExpandablePanel> {
  bool isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          isPanelOpen = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
            headerBuilder: widget.headerBuilder,
            body: widget.body,
            canTapOnHeader: true,
            isExpanded: isPanelOpen),
      ],
    ));
  }
}

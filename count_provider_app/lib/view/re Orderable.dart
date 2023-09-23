import 'package:count_provider_app/control/ordrprovider.dart';
import 'package:count_provider_app/modle/reor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReOrdeable extends StatefulWidget {
  const ReOrdeable({super.key});

  @override
  State<ReOrdeable> createState() => _ReOrdeableState();
}

class _ReOrdeableState extends State<ReOrdeable> {
  update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    print("$oldIndex $newIndex");
    final k = Provider.of<ReOdProvider>(context,listen: false).del(oldIndex);
    Provider.of<ReOdProvider>(context,listen: false).insert(newIndex, k);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Re-Orderable",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: ReorderableListView(
            //key: ,
            children: [
              ...Provider.of<ReOdProvider>(context).re.map(
                    (e) => Card(
                      color: Colors.deepPurple.withOpacity(0.7),
                      key: ValueKey(e),
                      child: ListTile(
                        leading: Text(
                          "$e",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        //focusColor: Colors.deepPurple,
                      ),
                    ),
                  ),
            ],
            onReorder: (int oldIndex, int newIndex) =>
                update(oldIndex, newIndex),
          ),
        ),
      ),
    );
  }
}

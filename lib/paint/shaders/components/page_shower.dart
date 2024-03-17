import 'package:flutter/material.dart';

class PageShower extends StatelessWidget {
  final int activePage;
  final int maxPage;
  final VoidCallback prev;
  final VoidCallback next;
  final Widget child;
  final String? msg;

  const PageShower({
    super.key,
    required this.activePage,
    required this.prev,
    required this.next,
    required this.maxPage,
    required this.child,
    this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: activePage == 0 ? null : prev,
                  icon: const Icon(Icons.navigate_before)),
              Expanded(
                child: Center(
                  child: child,
                ),
              ),
              IconButton(
                  onPressed: activePage == maxPage - 1 ? null : next,
                  icon: const Icon(Icons.navigate_next_sharp)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: msg != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        '${activePage + 1}/$maxPage',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                        Text(
                          msg!,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                    ],
                  )
                : Text(
                    '${activePage + 1}/$maxPage',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          )
        ],
      ),
    );
  }
}

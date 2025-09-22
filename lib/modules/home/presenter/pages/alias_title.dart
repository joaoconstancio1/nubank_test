import 'package:flutter/material.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';

class AliasTile extends StatelessWidget {
  final AliasModel alias;
  final VoidCallback? onCopy;

  const AliasTile({super.key, required this.alias, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(alias.alias),
      subtitle: Text(alias.original),
      trailing: IconButton(icon: const Icon(Icons.copy), onPressed: onCopy),
    );
  }
}

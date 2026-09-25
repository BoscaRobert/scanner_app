import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/networking/connection.dart';
import 'package:scanner_app/widgets/snack_bar_message.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  final TextEditingController _hostController = TextEditingController();
  bool _testing = false;

  @override
  void initState() {
    super.initState();
    _hostController.text = ServerConnection.serverHost;
  }

  @override
  void dispose() {
    _hostController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    final host = _hostController.text.trim();
    if (host.isEmpty) {
      showMessage(
        context,
        text: AppLocalizations.of(context)!.enterHostWarning,
        icon: Icons.warning_amber_outlined,
      );
      return;
    }

    ServerConnection.changeHost(host);
    setState(() => _testing = true);

    final succeeded = await ServerConnection.test();

    if (!mounted) return;
    setState(() => _testing = false);

    showMessage(
      context,
      text: succeeded
          ? AppLocalizations.of(context)!.connectionTestYes
          : AppLocalizations.of(context)!.connectionTestNo,
      background: succeeded ? Colors.green : Colors.red,
      icon: succeeded ? Icons.check_circle_outline : Icons.error_outline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.connections)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _hostController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.hostAddress,
                  hintText: '127.0.0.1',
                  hintStyle: TextStyle(color:Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.storage),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _testConnection(),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _testing ? null : _testConnection,
                icon: _testing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.wifi_tethering),
                label: Text(_testing ? 'Testing...' : 'Test connection'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
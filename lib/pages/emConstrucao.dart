import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmConstrucaoPage extends StatefulWidget {
  const EmConstrucaoPage({super.key});

  @override
  State<EmConstrucaoPage> createState() => _EmConstrucaoPageState();
}

class _EmConstrucaoPageState extends State<EmConstrucaoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Area secreta do caos'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF4D8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '404: pedreiro saiu pra almocar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        final wobble =
                            (_animationController.value - 0.5) * 0.16;

                        return Transform.rotate(angle: wobble, child: child);
                      },
                      child: Image.asset(
                        'assets/Tijolinho.png',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'Calma, chefe. Essa pagina ainda ta no cimento.',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: const Color(0xFF2B2118),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 0.55 + (_animationController.value * 0.45),
                          child: child,
                        );
                      },
                      child: Text(
                        'Prometeram entregar "rapidinho". Ou seja: talvez hoje, talvez em 2037.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF5A4636),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _MemeTag(text: 'Status: quase indo'),
                        _MemeTag(text: 'Bug: sim'),
                        _MemeTag(text: 'Cafe: insuficiente'),
                        _MemeTag(text: 'Deploy: nem pensar'),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF2B2118),
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x332B2118),
                            offset: Offset(5, 5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        'Enquanto isso, uma planilha chora em silencio e um botao finge que funciona.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2B2118),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/home');
                      },
                      icon: const Icon(Icons.keyboard_return),
                      label: const Text('Fugir antes que piore'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MemeTag extends StatelessWidget {
  const _MemeTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD166),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2B2118), width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2B2118),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

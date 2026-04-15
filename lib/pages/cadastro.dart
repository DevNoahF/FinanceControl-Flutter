import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(child: Image.asset("assets/Fundo.jpeg")),
            ),
          ),
        ],
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Fundo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withValues(alpha: 0.18),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 720;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.98),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 28,
                          offset: Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Left panel — logo
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: const Color(0xFFF7F6F3),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 36,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                                const Text(
                                  'Crie sua conta',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 41,
                                    height: 1.04,
                                    color: Color(0xFF111111),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Image.asset(
                                  'assets/logo.png',
                                  width: 290,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Right panel — cadastro form
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: const Color(0xFF363B43),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 28,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Cadastre-se',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 34,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 22),

                                // Row: Nome + Sobrenome
                                Row(
                                  children: const [
                                    Expanded(
                                      child: _FieldColumn(
                                        label: 'Nome',
                                        hintText: '',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _FieldColumn(
                                        label: 'Sobrenome',
                                        hintText: '',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                // Row: Profissão + Data de nascimento
                                Row(
                                  children: const [
                                    Expanded(
                                      child: _FieldColumn(
                                        label: 'Profissão',
                                        hintText: '',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _FieldColumn(
                                        label: 'Data de nascimento',
                                        hintText: '',
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                // Email (full width)
                                const _FieldColumn(
                                  label: 'Email',
                                  hintText: '',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 14),

                                // Senha (full width)
                                const _FieldColumn(
                                  label: 'Senha',
                                  hintText: '',
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),

                                // Cadastrar button
                                SizedBox(
                                  height: 38,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF3A3A3A),
                                      elevation: 0,
                                      shape: const StadiumBorder(),
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    child: const Text('Cadastrar'),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Divider(
                                  color: Colors.white54,
                                  thickness: 1,
                                  height: 1,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Ou faça login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Label + TextField empilhados verticalmente
class _FieldColumn extends StatelessWidget {
  const _FieldColumn({
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        _CadastroField(
          hintText: hintText,
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ],
    );
  }
}

class _CadastroField extends StatelessWidget {
  const _CadastroField({
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
  });

  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFFB9C9D8),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

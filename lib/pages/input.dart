import 'package:flutter/material.dart';
import 'package:finance_control/core/auth/auth_service.dart';
import 'package:go_router/go_router.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Center(
        child: Container(
          width: 1100,
          height: 650,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(35, 0, 0, 0),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // LADO ESQUERDO
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBFD0C5),
                        Color(0xFFAEBFB4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Color(0xFF2F5D50),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              'Finance Control',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF20322D),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          'Controle suas finanças\ncom clareza e elegância.',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: Color(0xFF20322D),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Registre entradas, despesas e transferências em uma tela simples, limpa e pronta para desktop.',
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            color: Color(0xFF32453F),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                color: Color(0xFF2F5D50),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Organização hoje, paz amanhã. Milagre não, método.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF20322D),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),

              // LADO DIREITO
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 45,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Novo lançamento',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Preencha os campos abaixo para registrar uma movimentação.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 35),

                      const _CustomLabel('Transferências'),
                      const SizedBox(height: 10),
                      const _CustomInput(
                        hintText: 'Digite o valor da transferência',
                        icon: Icons.swap_horiz_rounded,
                      ),

                      const SizedBox(height: 22),

                      const _CustomLabel('Despesas'),
                      const SizedBox(height: 10),
                      const _CustomInput(
                        hintText: 'Digite o valor da despesa',
                        icon: Icons.arrow_downward_rounded,
                      ),

                      const SizedBox(height: 22),

                      const _CustomLabel('Entrada'),
                      const SizedBox(height: 10),
                      const _CustomInput(
                        hintText: 'Digite o valor da entrada',
                        icon: Icons.arrow_upward_rounded,
                      ),

                      const SizedBox(height: 22),

                      const _CustomLabel('Descrição'),
                      const SizedBox(height: 10),
                      const _CustomInput(
                        hintText: 'Ex: salário, mercado, pagamento...',
                        icon: Icons.edit_note_rounded,
                      ),

                      const Spacer(),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFCAD5E2),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Limpar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF374151),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF111827),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Salvar lançamento',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomLabel extends StatelessWidget {
  final String text;

  const _CustomLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2937),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const _CustomInput({
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF111827),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF9CA3AF),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF6B7280),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF2F5D50),
            width: 1.6,
          ),
        ),
      ),
    );
  }
}
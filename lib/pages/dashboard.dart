import 'package:flutter/material.dart';

class Transacao {
  final String titulo;
  final String descricao;
  final double valor;
  final bool isEntrada;

  Transacao({
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.isEntrada,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transacao> transacoes = [
    Transacao(titulo: 'Salário', descricao: 'Pagamento mensal', valor: 300, isEntrada: false),
    Transacao(titulo: 'Freelance', descricao: 'Projeto web', valor: 300, isEntrada: true),
    Transacao(titulo: 'Consultoria', descricao: 'Reunião cliente', valor: 300, isEntrada: true),
    Transacao(titulo: 'Conta de luz', descricao: 'Fatura de maio', valor: 300, isEntrada: false),
  ];

  double get totalEntradas =>
      transacoes.where((t) => t.isEntrada).fold(0, (sum, t) => sum + t.valor);

  double get totalSaidas =>
      transacoes.where((t) => !t.isEntrada).fold(0, (sum, t) => sum + t.valor);

  double get restante => totalEntradas - totalSaidas;

  void _excluirTransacao(int index) {
    setState(() => transacoes.removeAt(index));
  }

  void _adicionarTransacao() {
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();
    final valorController = TextEditingController();
    bool isEntrada = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Nova Transação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: tituloController, decoration: const InputDecoration(labelText: 'Título')),
              TextField(controller: descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
              TextField(
                controller: valorController,
                decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Tipo: '),
                  ChoiceChip(
                    label: const Text('Entrada'),
                    selected: isEntrada,
                    selectedColor: Colors.green,
                    onSelected: (_) => setDialogState(() => isEntrada = true),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Saída'),
                    selected: !isEntrada,
                    selectedColor: Colors.red,
                    onSelected: (_) => setDialogState(() => isEntrada = false),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final valor = double.tryParse(valorController.text);
                if (tituloController.text.isNotEmpty && valor != null) {
                  setState(() {
                    transacoes.add(Transacao(
                      titulo: tituloController.text,
                      descricao: descricaoController.text,
                      valor: valor,
                      isEntrada: isEntrada,
                    ));
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text('Olá, Maria!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                SizedBox(width: 8),
                CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47')),
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
                SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cards de resumo
            Row(
              children: [
                _CardResumo(titulo: 'Entradas', valor: totalEntradas, cor: Colors.green),
                const SizedBox(width: 12),
                _CardResumo(titulo: 'Saídas', valor: totalSaidas, cor: Colors.red),
                const SizedBox(width: 12),
                _CardResumo(titulo: 'Restante', valor: restante, cor: Colors.blue[800]!),
              ],
            ),
            const SizedBox(height: 24),
            // Tabela de transações
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Cabeçalho
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          SizedBox(width: 40, child: Text('status', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                          Expanded(child: Text('título', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                          Expanded(child: Text('descrição', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                          SizedBox(width: 70, child: Text('valor', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                          SizedBox(width: 60),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Lista
                    Expanded(
                      child: ListView.separated(
                        itemCount: transacoes.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (ctx, i) {
                          final t = transacoes[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Icon(
                                    t.isEntrada ? Icons.add_circle : Icons.remove_circle,
                                    color: t.isEntrada ? Colors.green : Colors.red,
                                  ),
                                ),
                                Expanded(child: Text(t.titulo, style: const TextStyle(fontSize: 13))),
                                Expanded(child: Text(t.descricao, style: const TextStyle(fontSize: 13))),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'R\$ ${t.valor.toStringAsFixed(0)}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                // Botões editar/excluir
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.orange, size: 20),
                                      onPressed: () {}, // implementar edição
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel, color: Colors.red, size: 20),
                                      onPressed: () => _excluirTransacao(i),
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTransacao,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CardResumo extends StatelessWidget {
  final String titulo;
  final double valor;
  final Color cor;

  const _CardResumo({required this.titulo, required this.valor, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'R\$ ${valor.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
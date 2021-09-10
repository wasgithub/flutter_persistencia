class Balance {
  final double valor;

  Balance(this.valor);

  @override
  String toString() {
    return 'R\$ $valor';
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CasaInteligente {
    address public donoAtual;
    address public donoAnterior;
    string public localizacao;
    uint256 public valorCasa;

    event CasaVendida(address indexed comprador, uint256 valor, string novaLocalizacao);

    constructor(string memory _localizacao, uint256 _valorInicial) {
        donoAtual = msg.sender;
        localizacao = _localizacao;
        valorCasa = _valorInicial;
    }

    function venderCasa(address _novoDono, uint256 _valorCompra, string memory _novaLocalizacao) public payable {
        require(msg.sender == donoAtual, "Somente o dono atual pode vender a casa.");
        require(_novoDono != address(0), "Endereco do novo dono invalido.");
        require(_valorCompra > valorCasa, "O valor de compra e menor do que o valor atual.");

        donoAnterior = donoAtual;
        donoAtual = _novoDono;
        localizacao = _novaLocalizacao;
        valorCasa = _valorCompra;

        emit CasaVendida(_novoDono, _valorCompra, _novaLocalizacao);
    }

    function obterDetalhes() public view returns (address, address, string memory, uint256) {
        return (donoAtual, donoAnterior, localizacao, valorCasa);
    }
}

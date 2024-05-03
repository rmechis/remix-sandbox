// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CasaInteligente {
    address public donoAtual;
    address public donoAnterior;
    string public localizacao;

    // event CasaVendida(address indexed comprador, uint256 valor, string novaLocalizacao);
    event CasaVendida(address indexed comprador, string novaLocalizacao);

    constructor(string memory _localizacao) {
        donoAtual = msg.sender;
        localizacao = _localizacao;
    }

    // function venderCasa(address _novoDono, uint256 _valor, string memory _novaLocalizacao) public payable {
    function venderCasa(address _novoDono, string memory _novaLocalizacao) public {
        require(msg.sender == donoAtual, "Somente o dono atual pode vender a casa.");
        require(_novoDono != address(0), "Endereco do novo dono invalido.");
        // require(msg.value == _valor, "O valor enviado nao corresponde ao preco da casa.");

        donoAnterior = donoAtual;
        donoAtual = _novoDono;
        localizacao = _novaLocalizacao;

        // emit CasaVendida(_novoDono, _valor, _novaLocalizacao);
        emit CasaVendida(_novoDono, _novaLocalizacao);
    }

    function obterDetalhes() public view returns (address, address, string memory) {
        return (donoAtual, donoAnterior, localizacao);
    }
}

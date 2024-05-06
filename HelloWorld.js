window.addEventListener('load', async () => {
    // Conexão com o nó Ethereum
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
    } else if (window.web3) {
        window.web3 = new Web3(window.web3.currentProvider);
    } else {
        console.log('Nenhum provedor Web3 detectado. Você precisa instalar o MetaMask ou outro provedor Web3 para interagir com este DApp.');
        return;
    }

    // Carregar contrato
    const contractAddress = 'COLOQUE_O_ENDEREÇO_DO_CONTRATO_AQUI';
    const contractABI = [
        // Coloque aqui o ABI do contrato
    ];
    window.contract = new web3.eth.Contract(contractABI, contractAddress);

    // Exibir a mensagem atual
    updateMessage();
});

async function updateMessage() {
    const mensagem = await window.contract.methods.displayMessage().call();
    document.getElementById('mensagem').innerText = mensagem;
}

async function alterarMensagem() {
    const novaMensagem = document.getElementById('novaMensagem').value;
    const accounts = await window.web3.eth.getAccounts();
    await window.contract.methods.changeMessage(novaMensagem).send({ from: accounts[0] });
    updateMessage();
}

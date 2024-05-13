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
    const contractAddress = '0x80552669208ef34ea88c62288a9e98bdf7125a7f';
    const contractABI = [
        [
        	{
        		"inputs": [],
        		"stateMutability": "nonpayable",
        		"type": "constructor"
        	},
        	{
        		"inputs": [
        			{
        				"internalType": "string",
        				"name": "newMessage",
        				"type": "string"
        			}
        		],
        		"name": "changeMessage",
        		"outputs": [],
        		"stateMutability": "nonpayable",
        		"type": "function"
        	},
        	{
        		"inputs": [],
        		"name": "displayMessage",
        		"outputs": [
        			{
        				"internalType": "string",
        				"name": "",
        				"type": "string"
        			}
        		],
        		"stateMutability": "view",
        		"type": "function"
        	}
        ]
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

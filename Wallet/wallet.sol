pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
    
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		tvm.accept();
		_;
	}

    // Отправить без оплаты комиссии за свой счет
    function sendTransactionWithoutCommission(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 64 + 2);
    }

    // Отправить с оплатой комисси за свой счет
    function sendTransactionWithCommission(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 0 + 1);
    }

    // Отправить все деньги и уничтожить кошелек
    function sendTransactioAndDestroyWallet(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 128 + 32);
    }
}
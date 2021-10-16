pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplication {

    // переменная для хранения результата умножения 
	uint public result = 1;

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    // функция умножения
	function mul(uint value) public checkOwnerAndAccept {
		require(value >= 1 && value <= 10, 102);// если чесло не в промежутке [1, 10], то ошибка
		result *= value;// умножаем 
	}
}
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract QueueStore {

    // переменная для хранения результата умножения 
	string[] public queue;

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

    // функция добавления
	function add(string Customer) public checkOwnerAndAccept {
        queue.push(Customer);
	}

    // функция извлечения первого
	function getFirst() public checkOwnerAndAccept returns (string){  
		require(queue.length != 0, 101);
        string first = queue[0];//получаем первого
        for (uint i = 0; i < queue.length-1; i++){//смещаем занчения
            queue[i] = queue[i+1];
        }
        queue.pop();//удаляем лишний
        return first;
	}
}

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TaskList {

    // структура таск
    struct Task {
        string name;
        uint32 timestamp;
        bool done;
    }

    mapping (uint8 => Task) public TasksList;
    uint8 public keys = 0;

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

    function addTask(uint8 index, string name) public checkOwnerAndAccept { 
        Task t = Task(name, now, false);
        TasksList[index]=t;
        keys++;
	}

    function getCountDoneTask() public checkOwnerAndAccept returns (uint){  
        uint count = 0;
        for(uint8 i = 0; i < keys; i++){
            if (TasksList[i].done){
                count++;
            }
        }
        return count;
	}

    function getTaskList() public checkOwnerAndAccept returns (mapping (uint8 => Task)){  
        return TasksList;
	}

    function getTaskByIndex(uint8 index) public checkOwnerAndAccept returns (Task){ 
        return TasksList[index];
	}

    function removeTaskByIndex(uint8 index) public checkOwnerAndAccept{
        delete TasksList[index];
        keys--;
	}

    function doneTask(uint8 index) public checkOwnerAndAccept{
        TasksList[index].done = true;
	}

}

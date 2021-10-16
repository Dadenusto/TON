
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TaskList {

    // структура таск
    struct Task {
        string name;
        uint32 timestamp;
        bool done;
    }

    // map для хранения id и task'ов
    mapping (uint8 => Task) public TasksList;
    uint8 public keys = 0;//кол-во тасков

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
    // добаление таска
    function addTask(uint8 index, string name) public checkOwnerAndAccept { 
        Task t = Task(name, now, false);//создаем переменную
        TasksList[index]=t;//добавляем в map
        keys++;//увеличиваем кол-во элементов
	}

    //кол-во выполненых задач
    function getCountDoneTask() public checkOwnerAndAccept returns (uint){  
        uint count = 0;//переменная для хранения кол-ва
        for(uint8 i = 0; i < keys; i++){
            if (TasksList[i].done){//если done==true
                count++;// увеличиваем
            }
        }
        return count;
	}

    // получаем весь список задач
    function getTaskList() public checkOwnerAndAccept returns (mapping (uint8 => Task)){  
        return TasksList;
	}

    // получаем задачу по индексу
    function getTaskByIndex(uint8 index) public checkOwnerAndAccept returns (Task){ 
        return TasksList[index];
	}

    // удаляем по индексу
    function removeTaskByIndex(uint8 index) public checkOwnerAndAccept{
        delete TasksList[index];//удаляем
        keys--;//уменьшаем кол-во
	}

    // по id устанавливаем выполненую задачу
    function doneTask(uint8 index) public checkOwnerAndAccept{
        if (!TasksList[index].done){//если не выполнен
            TasksList[index].done = true;// устанавливаем как выполненый
        }
	}
}


pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
contract Datatypes {
    // типы данных
    uint32 public timestamp;
    uint8 public shortuInt;
    int256 public longInt;
    int public my256Int;

    //инициализация массива
    int[] myArray = [int256(0), 0];

    // структура
    struct Student {
        uint8 age;
        string name;  
    }

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

        // варианты инициализации
        int[] myArray2;
        myArray2[0] = 77;


        uint16[3] myArray3 = [uint16(1), 2, 3];

        // длина массива
        myArray3.length;

        // проверка массива на пустоту
        if (myArray2.empty()){
            myArray2.push(55);//добавляем в конец
        }
        else {
            myArray2.pop();//извлекаем последний
        }

        //байты
        byte myOnlyOneByte = 'a';
        // массивы байт
        byte[] bytesArray1;
        bytes bytesArray2 = "abcdefg";

        bytes slice = bytesArray2[1:3];

        //сторки 
        string sampleString = "asdasd";
        // подстрока
        sampleString.substr(1, 5);
        // добавить в строку
        sampleString.append("sdad");
        // найти подстроку
        sampleString.find("asd");
        // найти последнеее взождение подстроки
        sampleString.findLast(byte('d'));
        // приведение строки к int
        stoi(sampleString);

        // инициализация структуры
        Student myStudent = Student(21, "Evgeny");
        // извлечение данных из структуры
        uint8 age = myStudent.age;

        // map
        mapping (string => string) assocArray;
        assocArray["passport123"] = "Ivan";
        mapping (Student => uint8) studentsMark;
        studentsMark[myStudent] = 5;
        
        timestamp = now;

    }

}

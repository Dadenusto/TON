
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameInterface.sol";


// This is class that describes you smart contract.
contract gameObject is gameInterface{
    // свойство жизней
    int private health = 5;

    function getHealth() public view returns (int){
        tvm.accept();
        return health;
    }

    // получить атаку
    function getAttack(int value) virtual external override{
        tvm.accept();
        require(msg.sender != address(this), 102);
        tvm.accept();
        health -= value;// уменьшвем значение жизни
        checkAlive();
    }
    
    // проверить жив ли
    function checkAlive() public virtual{
        tvm.accept();
        if(health<=0){//если жизнь 0<=, то уничтожаем 
            sendTransactioAndDestroyWallet(msg.sender);
        }
    }

    // обработка смерти отправка всех денег и уничтожение
    function sendTransactioAndDestroyWallet(address dest) public pure{
        tvm.accept();
        dest.transfer(address(this).balance, true, 128 + 32);
    }
}

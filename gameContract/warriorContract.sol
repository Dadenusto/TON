
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'militaryUnit.sol';

contract warriorContract is militaryUnit{
    constructor(baseStation bS) public override{
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        gameObject gO = gameObject(this);
        bS.addUnit(gO);
        myBS = bS;
        setAttackValue(3);
        setDefenseValue(3);
        tvm.accept();
    }
}

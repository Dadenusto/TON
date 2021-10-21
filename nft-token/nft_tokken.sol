
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract nft_tokken {

    struct Token {
        string name;//имя
        string faculty;//факультет
        uint age;//возраст
    }

    Token[] tokensArr;//хранение токенов
    mapping (string=>uint) tokenToSale; //цены токена по имени(тк оно уникально по условию)

    // создания токена
    function createTokken(string name, string faculty, uint age) public{
        bool checkName = true;// переменная для проверки уникальности имени
        for (uint i = 0; i<tokensArr.length; i++) {
            if (tokensArr[i].name == name){// если имя совпадает с каким-либо
                checkName = false;// переменная проверки false
            }
        }
        require(checkName, 101);// проверка
        tvm.accept();
        tokensArr.push(Token(name, faculty, age));
        uint lastKeyNum = tokensArr.length - 1;
    }

    // выставить токен на продажу
    function tokkenToSale(string name, uint value) public{
        bool checkName = false;//существует ли имя в токенах
        for (uint i = 0; i < tokensArr.length; i++) {
            if (tokensArr[i].name == name){// если имя совпадает с каким-либо
                checkName = true;// переменная проверки true
            }
        }
        require(checkName, 101);
        tvm.accept();
        tokenToSale[name] = value;//добавляем цену для токена
    }

    // ДОП ФУНКЦИИ ДЛЯ ПРОВЕРКИ

    // получаем цену токена по имени
    function getTokenSale(string tokenName) public view returns (uint) {
        return tokenToSale[tokenName];
    }

    // получаем тнформацию о токене
    function getTokeninfo(uint tokenId) public view returns (string tokenName,string tokenFaculty, uint tokenAge) {
        tvm.accept();
        tokenName = tokensArr[tokenId].name;
        tokenFaculty = tokensArr[tokenId].faculty;
        tokenAge = tokensArr[tokenId].age;
    }

        /// @dev Contract constructor.
    constructor() public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
}

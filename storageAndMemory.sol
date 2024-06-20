// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageAndMemoryExample {
    uint256[] public numbers;

    function addNumber(uint256 num) public {
        numbers.push(num);
    }

    function getSum() public view returns (uint256) {
        uint256 sum = 0;
        
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }

        return sum;
    }

    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index];
    }

    function getNumbers() public view returns (uint256[] memory) {
        uint256[] memory tempNumbers = new uint256[](numbers.length);
        
        for (uint256 i = 0; i < numbers.length; i++) {
            tempNumbers[i] = numbers[i];
        }

        return tempNumbers;
    }
}

pragma solidity 0.8.20;


import {Test} from "../lib/forge-std/src/Test.sol";
import {psm} from "../src/PSM.sol";
import {Stablecoin} from "../src/Stablecoin.sol";

contract psmTest is Test{
    psm psmInstance;
    function setup() public {
        psmInstance = psm("0x50EEf481cae4250d252Ae577A09bF514f224C6C4");
    }


    function test_checkinitialze() public {
       assertEq(psmInstance.underlyingToStable(),0);
    }
}

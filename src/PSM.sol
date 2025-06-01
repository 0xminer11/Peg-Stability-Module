pragma solidity 0.8.20;

import "./Stablecoin.sol";
import "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
contract psm is OwnableUpgradeable{

Stablecoin public stable;

Stablecoin public underlying;

uint256 public DECIMAL_DIFF;

error NotEnoughLiquidity(address contractAddress,uint256 StableLiquidity, uint256 stableAmount);

function initialize(address _stable, address _underlaying) initializer public{
    stable = Stablecoin(_stable);
    underlying = Stablecoin(_underlaying);
    __Ownable_init(msg.sender);
    DECIMAL_DIFF =10 ** (stable.decimals() -Stablecoin(underlying).decimals());
}

function mint(address _to,uint256 _underlyingAmount) external returns (uint256 stableAmount){
    uint256 balance = underlying.balanceOf(address(this));
    
    underlying.transferFrom(msg.sender,address(this),_underlyingAmount);

    uint256 transferredUnderlyingAmount = underlying.balanceOf(address(this)) - balance;

    stableAmount = _underlyingToStable(transferredUnderlyingAmount);

    uint256 StableLiquidity = stable.balanceOf(address(this));

    if(StableLiquidity < stableAmount) revert NotEnoughLiquidity(address(this),StableLiquidity,stableAmount);

    stable.transfer(_to, stableAmount);
}



function redeem(address _to, uint256 _underlyingAmount) external returns(uint256 stableAmount){
    stableAmount = _stableToUnderlying(_underlyingAmount);

    stable.transferFrom(msg.sender,address(this), stableAmount);

    uint256 underlyingLiquidity = underlying.balanceOf(address(this));

    if (underlyingLiquidity < _underlyingAmount) revert NotEnoughLiquidity(address(this),underlyingLiquidity,_underlyingAmount);

    underlying.transfer(_to, _underlyingAmount);

}

function underlyingToStable(uint256 _underlyingAmount) external view returns(uint256){
    return _underlyingToStable(_underlyingAmount);
}

function _underlyingToStable(uint256 _underlyingAmount) internal view returns(uint256){
    return _underlyingAmount * DECIMAL_DIFF;
}

function stableToUnderlying(uint256 _underlyingAmount) external view returns(uint256){
    return _underlyingToStable(_underlyingAmount);
}

function _stableToUnderlying(uint256 _underlyingAmount) internal view returns(uint256){
    return _underlyingAmount / DECIMAL_DIFF;
}


function getUnderlyingLiquidity() external view returns(uint256 _underlyingAmount){
    return(underlying.balanceOf(address(this)));
}

function getStableLiquidity() external view returns(uint256 stableAmount){
    return(stable.balanceOf(address(this)));
}

function removeLiquidity(uint256 _stableAmount) external onlyOwner {
    stable.transfer(msg.sender,_stableAmount);
}

}
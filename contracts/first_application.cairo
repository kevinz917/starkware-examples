%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func wizard() -> (res : felt):
end

@storage_var
func balance() -> (res : felt):
end

@storage_var
func paused() -> (res : felt):
end

# basically a mapping: id -> number
@storage_var
func user_stat(id : felt) -> (res : felt):
end

###################
# CONSTRUCTOR
###################

# initialize with owner address
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        owner_address : felt):
    wizard.write(owner_address)
    return ()
end

###################
# GAMEPLAY FUNCTION
###################

# function to get current balance
@view
func get{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (value : felt):
    let (caller) = get_caller_address()
    let (value) = user_stat.read(caller)

    # let (value) = balance.read()
    return (value)
end

# function to increase balance by 1
@external
func increase{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    only_live()

    let (caller) = get_caller_address()
    let (res) = user_stat.read(caller)

    user_stat.write(caller, res + 1)

    # balance.write(res + 1)
    return ()
end

###################
# ADMIN ROLES
###################

# set game live state to 1 or 0
func set_game_state{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        state : felt):
    only_owner()

    paused.write(state)

    return ()
end

###################
# MODIFIERS
###################

# assert that when game is live
func only_live{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    alloc_locals
    let (local isLive) = paused.read()
    assert isLive = 1
    return ()
end

# assert only owner can make change
func only_owner{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    alloc_locals
    let (local caller) = get_caller_address()
    let (local owner) = wizard.read()
    assert caller = owner
    return ()
end

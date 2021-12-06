%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func persistent_state() -> (res : felt):
end

@external
func use_variables{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # needed for local variables
    alloc_locals

    # transient, revocable felt (Reference)
    # what does this mean lol
    let my_reference = 50
    let my_reference = 51

    tempvar my_tempvar = 2 * my_reference

    tempvar my_tempvar = 3 * my_reference

    # const cannot be redefined
    const my_const = 60

    local my_local = 70

    # persistent contract store
    persistent_state.write(80)
    # Redefine state.
    persistent_state.write(81)

    # todo: figure out the differences
    let (my_reference_2) = persistent_state.read()
    let (local my_local_2) = persistent_state.read()

    assert my_local_2 = 81

    return ()
end

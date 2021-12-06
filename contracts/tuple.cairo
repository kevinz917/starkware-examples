%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func store(idx : felt) -> (res : (felt, felt, felt)):
end

# function to get the storate tuple
@view
func get{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(idx : felt) -> (
        res_1 : felt, res_2 : felt, res_3 : felt):
    let (tuple) = store.read(idx)
    let res1 = tuple[0]
    let res2 = tuple[1]
    let res3 = tuple[2]

    return (res_1=res1, res_2=res2, res_3=res3)
end

@external
func set{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        idx : felt, first : felt, second : felt, third : felt) -> ():
    store.write(idx, (first, second, third))
    return ()
end

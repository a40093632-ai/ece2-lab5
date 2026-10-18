open_vcd piano.vcd
log_vcd [get_objects -r *]
run all
close_vcd
quit
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Inputs /conv_tb/uut/clk
add wave -noupdate -expand -group Inputs /conv_tb/uut/rst
add wave -noupdate -expand -group Inputs -radix decimal /conv_tb/uut/in_img_stream
add wave -noupdate -expand -group Inputs /conv_tb/uut/in_valid
add wave -noupdate -expand -group Inputs -radix decimal /conv_tb/uut/Kernal_weights
add wave -noupdate -expand -group Outputs -radix decimal /conv_tb/uut/out_img_stream
add wave -noupdate -expand -group Outputs /conv_tb/uut/out_valid
add wave -noupdate -radix decimal -childformat {{{/conv_tb/uut/in_read_addr[0]} -radix decimal} {{/conv_tb/uut/in_read_addr[1]} -radix decimal} {{/conv_tb/uut/in_read_addr[2]} -radix decimal} {{/conv_tb/uut/in_read_addr[3]} -radix decimal} {{/conv_tb/uut/in_read_addr[4]} -radix decimal} {{/conv_tb/uut/in_read_addr[5]} -radix decimal} {{/conv_tb/uut/in_read_addr[6]} -radix decimal} {{/conv_tb/uut/in_read_addr[7]} -radix decimal} {{/conv_tb/uut/in_read_addr[8]} -radix decimal} {{/conv_tb/uut/in_read_addr[9]} -radix decimal} {{/conv_tb/uut/in_read_addr[10]} -radix decimal} {{/conv_tb/uut/in_read_addr[11]} -radix decimal}} -subitemconfig {{/conv_tb/uut/in_read_addr[0]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[1]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[2]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[3]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[4]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[5]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[6]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[7]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[8]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[9]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[10]} {-height 15 -radix decimal} {/conv_tb/uut/in_read_addr[11]} {-height 15 -radix decimal}} /conv_tb/uut/in_read_addr
add wave -noupdate -radix decimal -childformat {{{/conv_tb/uut/current_conv_addr[0]} -radix decimal} {{/conv_tb/uut/current_conv_addr[1]} -radix decimal} {{/conv_tb/uut/current_conv_addr[2]} -radix decimal} {{/conv_tb/uut/current_conv_addr[3]} -radix decimal} {{/conv_tb/uut/current_conv_addr[4]} -radix decimal} {{/conv_tb/uut/current_conv_addr[5]} -radix decimal} {{/conv_tb/uut/current_conv_addr[6]} -radix decimal} {{/conv_tb/uut/current_conv_addr[7]} -radix decimal} {{/conv_tb/uut/current_conv_addr[8]} -radix decimal} {{/conv_tb/uut/current_conv_addr[9]} -radix decimal} {{/conv_tb/uut/current_conv_addr[10]} -radix decimal} {{/conv_tb/uut/current_conv_addr[11]} -radix decimal}} -subitemconfig {{/conv_tb/uut/current_conv_addr[0]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[1]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[2]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[3]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[4]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[5]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[6]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[7]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[8]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[9]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[10]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv_addr[11]} {-height 15 -radix decimal}} /conv_tb/uut/current_conv_addr
add wave -noupdate -radix decimal -childformat {{{/conv_tb/uut/current_conv[0]} -radix decimal} {{/conv_tb/uut/current_conv[1]} -radix decimal} {{/conv_tb/uut/current_conv[2]} -radix decimal} {{/conv_tb/uut/current_conv[3]} -radix decimal} {{/conv_tb/uut/current_conv[4]} -radix decimal} {{/conv_tb/uut/current_conv[5]} -radix decimal} {{/conv_tb/uut/current_conv[6]} -radix decimal} {{/conv_tb/uut/current_conv[7]} -radix decimal} {{/conv_tb/uut/current_conv[8]} -radix decimal} {{/conv_tb/uut/current_conv[9]} -radix decimal} {{/conv_tb/uut/current_conv[10]} -radix decimal} {{/conv_tb/uut/current_conv[11]} -radix decimal}} -subitemconfig {{/conv_tb/uut/current_conv[0]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[1]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[2]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[3]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[4]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[5]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[6]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[7]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[8]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[9]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[10]} {-height 15 -radix decimal} {/conv_tb/uut/current_conv[11]} {-height 15 -radix decimal}} /conv_tb/uut/current_conv
add wave -noupdate -radix decimal /conv_tb/uut/flattened_weights
add wave -noupdate -radix decimal /conv_tb/uut/in_write_addr
add wave -noupdate -radix decimal /conv_tb/uut/temp_result
add wave -noupdate -radix decimal /conv_tb/uut/current_pixel
add wave -noupdate -radix decimal /conv_tb/uut/last_result
add wave -noupdate -radix decimal /conv_tb/uut/save_pixel
add wave -noupdate /conv_tb/uut/set
add wave -noupdate /conv_tb/uut/last
add wave -noupdate -expand -group Memory -radix decimal /conv_tb/uut/internal_buffer/in_addr
add wave -noupdate -expand -group Memory -radix decimal /conv_tb/uut/internal_buffer/in_data
add wave -noupdate -expand -group Memory -radix decimal /conv_tb/uut/internal_buffer/read_addr
add wave -noupdate -expand -group Memory -radix decimal /conv_tb/uut/internal_buffer/read_data
add wave -noupdate -expand -group Memory -radix decimal /conv_tb/uut/internal_buffer/buffer
add wave -noupdate -group {Internal Signals} /conv_tb/uut/index
add wave -noupdate -group {Internal Signals} /conv_tb/uut/sum_i
add wave -noupdate -group PARAMETERS /conv_tb/uut/KERNEL_DIM
add wave -noupdate -group PARAMETERS /conv_tb/uut/KERNEL_CH
add wave -noupdate -group PARAMETERS /conv_tb/uut/IMG_DIM
add wave -noupdate -group PARAMETERS /conv_tb/uut/IMG_CH
add wave -noupdate -group PARAMETERS /conv_tb/uut/OUT_DIM
add wave -noupdate -group PARAMETERS /conv_tb/uut/INPUT_PREC
add wave -noupdate -group PARAMETERS /conv_tb/uut/OUTPUT_PREC
add wave -noupdate -group PARAMETERS /conv_tb/uut/BUFFER_SIZE
add wave -noupdate -group PARAMETERS /conv_tb/uut/KERNEL_SIZE
add wave -noupdate -group PARAMETERS /conv_tb/uut/IMG_SIZE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1537 ps} {1673 ps}

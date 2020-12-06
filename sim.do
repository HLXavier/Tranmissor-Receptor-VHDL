if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work pkg_tp6.vhd
vcom -work work tx_tp6.vhd
vcom -work work arbitro_tp6.vhd
vcom -work work transmissores.vhd
vcom -work work receptor.vhd
vcom -work work tb.vhd

vsim -voptargs=+acc=lprn -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 2500 ns
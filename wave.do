onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/TXS/clock
add wave -noupdate /tb/TXS/reset
add wave -noupdate -divider TX0
add wave -noupdate /tb/palavra(0)
add wave -noupdate /tb/TXS/send(0)
add wave -noupdate /tb/TXS/req(0)
add wave -noupdate /tb/TXS/grant(0)
add wave -noupdate /tb/busy(0)
add wave -noupdate -divider TX1
add wave -noupdate /tb/palavra(1)
add wave -noupdate /tb/TXS/send(1)
add wave -noupdate /tb/TXS/req(1)
add wave -noupdate /tb/TXS/grant(1)
add wave -noupdate /tb/busy(1)
add wave -noupdate -divider TX2
add wave -noupdate /tb/palavra(2)
add wave -noupdate /tb/TXS/send(2)
add wave -noupdate /tb/TXS/req(2)
add wave -noupdate /tb/TXS/grant(2)
add wave -noupdate /tb/busy(2)
add wave -noupdate -divider TX3
add wave -noupdate /tb/palavra(3)
add wave -noupdate /tb/TXS/send(3)
add wave -noupdate /tb/TXS/req(3)
add wave -noupdate /tb/TXS/grant(3)
add wave -noupdate /tb/busy(3)
add wave -noupdate -divider {LINHA DE DADOS}
add wave -noupdate /tb/TXS/linha
add wave -noupdate -divider RECEPTOR
add wave -noupdate /tb/RXT/endereco
add wave -noupdate /tb/RXT/palavra
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {6088 ns}

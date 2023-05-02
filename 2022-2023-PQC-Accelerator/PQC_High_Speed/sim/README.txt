#########################################################
#   Simulation of System and Subsystem Components       #
#########################################################
Requires a project to be created in ModelSim.  The project must
include the PQC_High_Speed vhdl files and they must be compiled.

*NOTE* enc_dec is 0 for encryption, 1 for decryption

* Top Level:
1.) Run top_lvl_wave.do to display the system's signals in a cle
2.) top_lvl_enc produces two cyphertexts and contains the following input vectors:
    A_in: [0, 1, 0, 1, 0, 1, 1, 1, ...]
    B_in: [0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, ...]
    P_in: [5, 5, 5, ...]
3.) top_lvl_dec produces the decrypted text and contains the following input vectors:
    A_in: [0, 1, 0, 1, 0, 1, 1, 1, ...]
    B_in: [0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, ...]
    P_in: [5, 5, 5, ...] // P_in is never used in decryption

* Load A:
1.) Compile top level design with N_SIZE = 8 in global_pkg.vhd
2.) Drag signals from load_a into wave view and run load_a.do
2.) Observe how the input vector is circularly shifted when enc_dec is 0 and 1

* Load B:
1.) Compile top level design with an N_SIZE >= 32 in global_pkg.vhd
2.) Drag signals from load_b into wave view and run load_b.do
2.) Observe how the input vector is circularly shifted when enc_dec is 0 and 1

* PE_CHAIN:
1.) Run top_lvl_wave.do to display signals
2.) if simulating a singular element run either PE_i.do, PE_n.do
3.) if simulating whole pe_chain run PE_chain_new.do

* Data Shift IN:
1.) Compile top level design with N_SIZE = 8 in global_pkg.vhd
2.) Run top_lvl_wave.do to display signals
3.) For simulation use dsin.do

* Data Shift OUT:
1.) Compile top level design with N_SIZE = 8 in global_pkg.vhd
2.) Run top_lvl_wave.do to display signals
3.) For simulation use dso.do
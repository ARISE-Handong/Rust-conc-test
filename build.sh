export LLVM=/usr/lib/llvm-13
export TARGET_HOME_DIR=$PWD/testing_target/
export TESTING_DIR=$PWD
export RUSTFLAGS=--emit=llvm-ir
export RUSTUP_NIGHTLY=/home/uja/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu

rm -rf TLE
rm -rf build
mkdir TLE
mkdir build

cd $TARGET_HOME_DIR
cargo clean
cargo +nightly build

for entry in ./target/debug/deps/*.ll
do
	cp $entry $TESTING_DIR/build/
done

cd $TESTING_DIR/build
cmake -DLT_LLVM_INSTALL_DIR=$LLVM ../opt_pass
make

for entry in *.ll
do
	echo $entry
	$LLVM/bin/opt -o target_rse_$entry -load-pass-plugin ./libpass.so -passes=RSE_pass $entry
	$LLVM/bin/opt -o target_tle_$entry -load-pass-plugin ./libpass.so -passes=TLE_pass $entry
done

rustc --crate-type=lib --emit=obj -o probe_rse.o ../probe/probe_RSE.rs
rustc --crate-type=lib --emit=obj -o probe_tle.o ../probe/probe_TLE.rs

#read_none
$LLVM/bin/clang -o rse $RUSTUP_NIGHTLY/lib/libstd-91db243dd05c003b.so -lpthread -pthread -lrt -lm target_rse_*.ll probe_rse.o 
$LLVM/bin/clang -o ../TLE/tle $RUSTUP_NIGHTLY/lib/libstd-91db243dd05c003b.so -lpthread -pthread -lrt -lm target_tle_*.ll probe_tle.o 

rm *.ll

unset LLVM
unset TARGET_HOME_DIR
unset TESTING_DIR
unset RUSTFLAGS
unset FUNC_IDENTIFIER

cd ..
#./run_random.sh
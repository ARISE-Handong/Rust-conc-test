# Rust-conc-test
Rust-conc-test is a testing framework that uses the random testing technique for multi-threaded programs written in Rust. 

### Random testing technique
The random testing technique aims to shuffle and distort the usual thread execution scenario. By executing the randomized threading scenario, one can observe unexpected behaviors and crashes caused by concurrency bugs. 

### Random Scheduling Execution
Rust-conc-test inserts probe functions to the target program through LLVM opt-pass, and they are inserted before the non-deterministic points (or the usages of threading syncing primitives). Via the inserted probe functions, it injects random timing noise and creates a randomized thread scheduling scenario. One can observe hidden bugs by executing randomized scheduling scenarios repeatedly.

### Error Replay Execution
When a bug is observed, the problematic scheduling scenario is recorded explicitly for the "replay". The error replay module will read the problematic scenario and replay the unexpected behavior. The module will also provide human-readable threading scenarios and program structures to help one to understand the cause of the unexpected behavior. 

## Referenced
* Shin Hong, Jaemin Ahn, Sangmin Park, Moonzoo Kim, and Mary Jean Harrold. 2012. [Testing concurrent programs to achieve high synchronization coverage. In Proceedings of the 2012 International Symposium on Software Testing and Analysis (ISSTA 2012)](https://dl.acm.org/doi/10.1145/2338965.2336779). Association for Computing Machinery, New York, NY, USA, 210–220. doi: 10.1145/2338965.2336779
* O. Edelstein, E. Farchi, Y. Nir, G. Ratsaby and S. Ur, ["Multithreaded Java program test generation,"](https://ieeexplore.ieee.org/abstract/document/5386903) in IBM Systems Journal, vol. 41, no. 1, pp. 111-125, 2002, doi: 10.1147/sj.411.0111.

## About Us
Rust-conc-test is built by [Eunchan Park](https://github.com/euncharm1ng) and [Kieun Kim](https://github.com/eunice-nxn) under the direction of [Professor Hong](https://github.com/hongshin) at Handong Global University.

## Trophies
* [sharkdp/fd#1060](https://github.com/sharkdp/fd/issues/1060): *"a race between spawn_receiver() and spawn_sender()"*

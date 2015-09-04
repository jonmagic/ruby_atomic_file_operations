# Atomic file operations in Ruby

This is just a quick experiment to see how long it takes to do [atomic](https://en.wikipedia.org/wiki/Atomicity_(database_systems)) file operations in Ruby.

## Running the experiment

```bash
$ rake
```

Please note this also updates the results tables in this README.

## Results

### open-lock-write-results.csv

| test_name       | MB  | ms  |
|-----------------|-----|-----|
| open-lock-write | 1   | 0   |
| open-lock-write | 2   | 1   |
| open-lock-write | 4   | 3   |
| open-lock-write | 8   | 8   |
| open-lock-write | 16  | 15  |
| open-lock-write | 32  | 32  |
| open-lock-write | 64  | 60  |
| open-lock-write | 128 | 128 |
| open-lock-write | 256 | 256 |
| open-lock-write | 512 | 729 |


### write-move-results.csv

| test_name  | MB  | ms |
|------------|-----|----|
| write-move | 1   | 0  |
| write-move | 2   | 1  |
| write-move | 4   | 1  |
| write-move | 8   | 1  |
| write-move | 16  | 1  |
| write-move | 32  | 2  |
| write-move | 64  | 4  |
| write-move | 128 | 8  |
| write-move | 256 | 16 |
| write-move | 512 | 30 |

t

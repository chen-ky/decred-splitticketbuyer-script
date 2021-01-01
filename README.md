# decred-splitticketbuyer-script
A shell script to buy Decred split ticket interactively.

## Features
* Enter your password without displaying it in the terminal in plain text.
* Auto retry if failed to buy split ticket.

## Usage
1. Download the `splitticketbuyer` binary [here](https://github.com/matheusd/dcr-split-ticket-matcher/releases).
2. Place `ticket_buyer.sh` in the same directory as your `splitticketbuyer` binary.
3. Navigate to the directory `cd <splitticketbuyer_directory_path>`.
4. Run the shell script using `./ticket_buyer.sh` or `sh ticket_buyer.sh`.
    * If this is your first time using `splitticketbuyer`, please modify your configuration file before proceeding.

## FAQ

### Permission denied
* Make sure you have given both `ticket_buyer.sh` and `splitticketbuyer` permission to execute.
* View file permission: `ls -l`
* Add execute permission to both file: `chmod u+x ticket_buyer.sh splitticketbuyer`
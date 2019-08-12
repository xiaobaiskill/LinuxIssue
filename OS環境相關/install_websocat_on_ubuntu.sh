sudo apt-get update -y && sudo apt-get install -y curl build-essential libssl-dev pkg-config
curl https://sh.rustup.rs -sSf | sh
export PATH=$HOME/.cargo/bin:$PATH
cargo install --features=ssl websocat
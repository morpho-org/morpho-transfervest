# Transferable Vestings

## Setup

After cloning the repo, run:
```bash
git submodule update --init --recursive
```

## Deploy Vester contract in local

Run in one terminal:
```bash
anvil
```

And in another one:
```bash
bash ./deploy_vester <owner_address>
```

## Create vestings' data

To create vesting data, you should import vesting params in [`vestin_params.csv`](./vesting_params.csv). The first column must be the address of the receiver and the second one is the total amount of tokens vested (with 18 decimals).

To create vestings' data, you first need to populate your `.env` file with the right parameters (check the `env.exmaple` file). You can do it by running:
```bash
 cp .env.example .env
```

Then, you just need to run:
```bash
bash ./vestings_data.sh <vester-address> <signer-address>
```

# Reproducibility repository for the FUOTA-Automation framework


# Reproducibility of experiments

- Simulation results are replicable. Follow the instructions below to install ns-3 and run the bash scripts to launch simulations and parse results
  - ⚠ experiments continuous and scale generate GB of logs (7.7G for logs_continuous, 29G for logs_scale)

- Real experiments should be reproducible if you have access to STM32NUCLEO-WL55JC1

# Simulations
## Simulations: Install ns-3 and the LoRaWAN module

[ns-3 LoRaWAN modification](https://github.com/klementc/lorawan)

The install script downloads and compiles ns-3 v3.41 with our ns-3 LoRaWAN modifications on branch classA-open-windows. Running the following installs ns-3 locally under [./deps/ns-allinone-3.41](./deps/ns-allinone-3.41/)
```sh
bash install_ns3.sh
```

## Run Simulations

Simulations are executed by running the bash scripts in [./scripts](./scripts/). Logs are parsed after execution using awk.


- Single end-device simulations (fig.4,5)
  Simulates the duration of FUOTA with a single End-device. Does not use any random computation, so we only run a single time each experiment. We run experiments with different SF used for the transmission of fragments
  ```sh
  cd scripts
  bash launcher_singleed.sh
  ```
  Logs and csv files are located in [./logs_singleed](./logs_singleed/)
- 4 EDs simulations (fig.6, table 1)
  Simulates the duration of FUOTA with 4 End-devices. We run experiments with different update policies for comparison.
  ```sh
  cd scripts
  bash launcher_4ed.sh
  ```
  Logs and csv files are located in [./logs_4ed](./logs_4ed/)
- Scalability simulations (fig.7,8,9)
  Simulates between 50 and 300 EDs, doing FUOTA between 2 and 6 kb, with policies {All, Energy-first, Threshold-2, Threshold-3}. Since there are random waiting times after message loss to avoid all EDs from sending messages simultaneously, we run simulations with 10 different seeds.
  ```sh
  cd scripts
  bash launcher_scale.sh
  ```
  Logs and csv files are located in [./logs_scale](./logs_scale/)
- Continuous simulations (fig.7,8,9)
  Simulations betwwen 100 and 200 EDs during 1 week, to receive every day an update of 2kb. Using 5 different seeds, and the same policies as log_scale
  ```sh
  cd scripts
  bash launcher_continuous.sh
  ```
  Logs and csv files are located in [./logs_continuous](./logs_continuous/)


# Real experiments
## Real experiments: Install FUOTAA

[FUOTAA repository](https://github.com/klementc/fuotaa)

```sh
bash install_fuotaa.sh
```
## Run Real experiments:
You need to install different tools to compile the code and flash it on the devices:
- stm32cubeIDE (IDE)
- stm32programmer (flash firmware on device)
- stm32cubemonitor (energy measurements)

Firmware code locations:

[STM32 FUOTA experiment code](./stmcube_projects/LoRaWAN_FUOTA/)

[STM32 ML experiment code](./stmcube_projects/ml_libtest/)

ML experiments do not need a LoRaWAN server.

FUOTA experiments necessitate:
- A running chirpstack server [github repo](https://github.com/chirpstack/chirpstack)
- A running chirpstack-fuota server [github repo](https://github.com/chirpstack/chirpstack-fuota-server)
- A running FUOTAA server [./deps/fuotaa](./deps/fuotaa)

Instructions for singleed experiments are available on [./methodology_singleed.md](./methodology_singleed.md).
Experiment 4 ED is similar, but you need 4 EDs configured with 4 different DR (DR2 to DR5 in our experiments).

## Paper's figures

After running experiments and parsing logs, Figures can be generated using Jupyter R notebooks (ggplot):
- Singleed: [notebook_singleed.ipynb](./notebook_singleed.ipynb)
- 4ed: [notebook_4ed.ipynb](./notebook_4ed.ipynb)
- continuous: [notebook_singleed.ipynb](./notebook_continuous.ipynb)
- scale: [notebook_singleed.ipynb](./notebook_scale.ipynb)
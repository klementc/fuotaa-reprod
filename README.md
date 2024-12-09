
# Reproducibility repository for the FUOTA-Automation framework


## Repository layout

[FUOTA experiment code](./stmcube_projects/LoRaWAN_FUOTA/)

[ML experiment code](./stmcube_projects/ml_libtest/)

## Reproduce experiments

### Simulations: Install ns-3 and the LoRaWAN module

```sh
bash install_ns3.sh
```

### Real experiments:
You need to install different tools to compile the code and flash it on the devices:
- stm32cubeIDE (IDE)
- stm32programmer (flash firmware on device)
- stm32cubemonitor (energy measurements)

## Paper's figures
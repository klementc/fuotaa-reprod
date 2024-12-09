In this experiment, I use a single end-device connected to a gateway. This device will send requests for an object of size 2kB. After receiving requests, the FUOTAutomater will schedule a FUOTA round.
We execute experiments with each spreading factor, by modifying the DataRate of the device between DR_0 and DR_5.

# Tools

## End-device
Flashing the LoRaWAN-FUOTA firmware on a nucleo WL55-JC1
Settings in `lora_app.h`:
```C
#define APP_TX_DUTYCYCLE                            30000 //60000

/*!
 * LoRaWAN User application port
 * @note do not use 224. It is reserved for certification
 */
#define LORAWAN_USER_APP_PORT                       1
#define LORAWAN_FUOTA_REQ_PORT						24

/*!
 * LoRaWAN Switch class application port
 * @note do not use 224. It is reserved for certification
 */
#define LORAWAN_SWITCH_CLASS_PORT                   3

/*!
 * LoRaWAN default class
 */
#define LORAWAN_DEFAULT_CLASS                       CLASS_A

/*!
 * LoRaWAN default confirm state
 */
#define LORAWAN_DEFAULT_CONFIRMED_MSG_STATE         LORAMAC_HANDLER_UNCONFIRMED_MSG

/*!
 * LoRaWAN Adaptive Data Rate
 * @note Please note that when ADR is enabled the end-device should be static
 */
#define LORAWAN_ADR_STATE                           LORAMAC_HANDLER_ADR_OFF

/*!
 * LoRaWAN Default Data Rate
 * @note Please note that LORAWAN_DEFAULT_DATA_RATE is used only when LORAWAN_ADR_STATE is disabled
 */
#define LORAWAN_DEFAULT_DATA_RATE                   DR_3

/*!
 * LoRaWAN Default Tx output power
 * @note LORAWAN_DEFAULT_TX_POWER must be defined in the [XXXX_MIN_TX_POWER - XXXX_MAX_TX_POWER] range,
         else the end-device uses the XXXX_DEFAULT_TX_POWER value
 */
#define LORAWAN_DEFAULT_TX_POWER                    TX_POWER_1

/*!
 * LoRaWAN default activation type
 */
#define LORAWAN_DEFAULT_ACTIVATION_TYPE             ACTIVATION_TYPE_OTAA

/*!
 * LoRaWAN force rejoin even if the NVM context is restored
 * @note useful only when context management is enabled by CONTEXT_MANAGEMENT_ENABLED
 */
#define LORAWAN_FORCE_REJOIN_AT_BOOT                true

```
The only parameter to vary between experiments is `LORAWAN_DEFAULT_DATA_RATE` between DR_0 and DR_5

## Network server

- Chirpstack v
- Chirpstack-fuota-server v
- FUOTAutomation server: automation_server/test.py

FUOTAutomation configuration (you need to change app_ID to your need):
```yaml
general:
  # time before calling the FUOTA server and the actual emission of the object
  unicast_timeout_seconds: 300
  # time the device remains in continuous RX before switching back to class A
  multicast_timeout: 12
  unicast_attempt_count: 2
  # to match the theoretical case where we download N+2 fragments to finish (theoretical number of fragments for successful reception)
  redundancy: 0
  # Application ID executed on the network server
  app_ID: "0df08e90-1180-40c3-b731-d3c345bb24ca"
  # True to enforce the inter-arrival time of packets to respect duty cycle regulation
  enforce_DC_downlink: True
  # MQTT detail to receive uplink messages
  mqtt:
    Addr: "localhost"
    Port: 1883
  # GRPC endpoint of the chirpstack-FUOTA server
  grpc_endpoint: "localhost:8070"
  # minimal duration between FUOTA rounds
  inter_FUOTA_interval: 300
  # FPort devices use to send uplink requests
  uplink_FPort: 24
  # do not start a FUOTA round if the app is younger than min_age
  min_pool_dur: 300
# details of the objects used by the app synthetic data means we generate fake data (for performance measurement purpose)
objects:
  1:
    type: "synthetic"
    size: 2000
  2:
    type: "path"
    filepath: "path/to/file.bin"

```

# Protocol

1. Flash the firmware using stmprogrammer `STM32Cube_FW_WL_V1.3.0/Projects/NUCLEO-WL55JC/Applications/LoRaWAN_FUOTA/LoRaWAN_End_Node/STM32CubeIDE/Binary/BFU_LoRaWAN_End_Node.bin`
2. Start chirpstack on your computer (I dont use docker): `chirpstack --config code/gitlab.umu.se/application_fuota_stm32/automation_server/chirpstack_config`
3. Start chirpstack-fuota-server (from the git repository): `./build/chirpstack-fuota-server --config packaging/files/chirpstack-fuota-server.toml`
4. Start the FUOTAutomation server from the automation_server repository: `python test.py`
5. Connect the power monitor to the Nucleo end-device
6. Start a screen session: `screen -L -Logfile log_fuota_dr4_2000_clean_s5.log /dev/ttyACM1 115200` (change to the right serial port and file name)
7. Start acquisition in stmpowermonitor. It will start the device automatically. Settings:
  - Sampling frequency: 500Hz
  - Acquisition time: Inf
  - Current threshold: 50000 mua
  - Trigger source: sw
  - Trigger delay: 1ms
  - Input voltage: 3000mV
8. When the end device is connected to the NS, press button 1 to start sending uplinks

# Analysis of results

## Energy results:

File: `singleed_timeonair_power.csv`

Results are stored by hand. For each sample we note the energy consumed during the experiment using stmpowermonitor, and add the result inside the file. Power files are stored in `log_singleed/power_dr<N>_2000_clean_s<K>.stpm`, where N in the datarate, and K is the sample (total of 5). These archives can be opened to view csv, or within stmpowermonitor for direct visualization.

## Communication results:

File: `singleed_timeonair_real_dur.csv`

Results are parsed from the log files using `real_fuota_parser_dur.awk`. Since when the node is not synchronized with the NS we get wrong timestamps, we process the original log file in `log_singleed/log_fuota_dr<N>_2000_clean_s<K>.log` to remove the first few timestamps (before sync packet that is the first after the join) and last few timestamps (after rebooting).
the results are in the same file name with the `_processed.log` suffix.

We use the command: `awk -v sample=<K> -f real_fuota_parser_dur.awk ./log_singleed/log_fuota_dr<N>_2000_clean_s<K>_processed.log >> singleed_timeonair_real_dur.csv` to put the results in a csv file

# Simulation

You need ns-3 installed. This can be done using the script [./install_ns3.sh](./install_ns3.sh)
```sh
bash install_ns3.sh
```

Then we run the bulk_comm_app_multicast for each datarate. You need awk to parse the logs

```sh
cd scripts
bash launcher_singleed.sh
```

The results are located in ../logs_singleed

# Generate figures

The notebook to reproduce the Figures of the paper for this experiment are located in [./notebook_singleed.ipynb](./notebook_singleed.ipynb)
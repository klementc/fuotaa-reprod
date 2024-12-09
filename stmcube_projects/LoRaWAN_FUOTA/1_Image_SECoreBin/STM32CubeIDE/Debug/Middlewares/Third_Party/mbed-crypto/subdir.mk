################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/Third_Party/mbed-crypto/library/sha256.c 

OBJS += \
./Middlewares/Third_Party/mbed-crypto/sha256.o 

C_DEPS += \
./Middlewares/Third_Party/mbed-crypto/sha256.d 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/mbed-crypto/sha256.o: /home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/Third_Party/mbed-crypto/library/sha256.c Middlewares/Third_Party/mbed-crypto/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 '-DMBEDTLS_CONFIG_FILE=<mbed_crypto_config.h>' -DDEBUG -DIT_MANAGEMENT_DISABLED -c -I.. -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Projects/NUCLEO-WL55JC/Applications/LoRaWAN_FUOTA/1_Image_SECoreBin/Inc -I../../Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Key_Management_Services/Core -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Secure_Engine/Key -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Key_Management_Services/Core -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Secure_Engine/Core -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Key_Management_Services/Interface -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Key_Management_Services/Interface/CryptoApi -I/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Middlewares/ST/STM32_Key_Management_Services/Modules -I../../../../../../../Middlewares/Third_Party/mbed-crypto/include -I../../../../../../../Middlewares/Third_Party/LoRaWAN/Mac -I../../../1_Image_BFU/BFU/App -I../../../1_Image_BFU/BFU/Target -I../../../Linker_Common/STM32CubeIDE -I../../../LoRaWAN_End_Node/LoRaWAN/App -I../../../LoRaWAN_End_Node/LoRaWAN/Target -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-mbed-2d-crypto

clean-Middlewares-2f-Third_Party-2f-mbed-2d-crypto:
	-$(RM) ./Middlewares/Third_Party/mbed-crypto/sha256.cyclo ./Middlewares/Third_Party/mbed-crypto/sha256.d ./Middlewares/Third_Party/mbed-crypto/sha256.o ./Middlewares/Third_Party/mbed-crypto/sha256.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-mbed-2d-crypto


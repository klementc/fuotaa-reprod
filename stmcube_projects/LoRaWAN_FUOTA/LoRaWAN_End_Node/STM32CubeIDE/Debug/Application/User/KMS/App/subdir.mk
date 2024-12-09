################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/LoRaWAN_End_Node/KMS/App/app_kms.c 

OBJS += \
./Application/User/KMS/App/app_kms.o 

C_DEPS += \
./Application/User/KMS/App/app_kms.d 


# Each subdirectory must supply rules for building sources it contributes
Application/User/KMS/App/app_kms.o: /home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/LoRaWAN_End_Node/KMS/App/app_kms.c Application/User/KMS/App/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DCORE_CM4 -DSTM32WL55xx -DUSE_HAL_DRIVER -DKMS_ENABLED -DDISABLE_IMAGE_STATE_HANDLING -c -I../../Core/Inc -I../../LoRaWAN/App -I../../LoRaWAN/Target -I../../KMS/App -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Utilities/trace/adv_trace -I../../../../../../../Utilities/misc -I../../../../../../../Utilities/sequencer -I../../../../../../../Utilities/timer -I../../../../../../../Utilities/lpm/tiny_lpm -I../../../../../../../Middlewares/Third_Party/LoRaWAN/LmHandler/Packages -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Middlewares/Third_Party/LoRaWAN/Crypto -I../../../../../../../Middlewares/Third_Party/LoRaWAN/Mac/Region -I../../../../../../../Middlewares/Third_Party/LoRaWAN/Mac -I../../../../../../../Middlewares/Third_Party/LoRaWAN/LmHandler -I../../../../../../../Middlewares/Third_Party/LoRaWAN/Utilities -I../../../../../../../Middlewares/Third_Party/SubGHz_Phy -I../../../../../../../Middlewares/Third_Party/SubGHz_Phy/stm32_radio_driver -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Interface -I../../../1_Image_SECoreBin/Inc -I../../../1_Image_BFU/BFU/App -I../../../Linker_Common/STM32CubeIDE -Os -ffunction-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Application-2f-User-2f-KMS-2f-App

clean-Application-2f-User-2f-KMS-2f-App:
	-$(RM) ./Application/User/KMS/App/app_kms.cyclo ./Application/User/KMS/App/app_kms.d ./Application/User/KMS/App/app_kms.o ./Application/User/KMS/App/app_kms.su

.PHONY: clean-Application-2f-User-2f-KMS-2f-App


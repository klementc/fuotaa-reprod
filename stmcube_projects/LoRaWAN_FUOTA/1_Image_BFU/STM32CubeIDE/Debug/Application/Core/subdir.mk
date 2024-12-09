################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/main.c \
../Application/Core/sfu_secorebin_inc.c \
/home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/stm32wlxx_hal_msp.c \
/home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/stm32wlxx_it.c \
../Application/Core/syscalls.c \
../Application/Core/sysmem.c 

OBJS += \
./Application/Core/main.o \
./Application/Core/sfu_secorebin_inc.o \
./Application/Core/stm32wlxx_hal_msp.o \
./Application/Core/stm32wlxx_it.o \
./Application/Core/syscalls.o \
./Application/Core/sysmem.o 

C_DEPS += \
./Application/Core/main.d \
./Application/Core/sfu_secorebin_inc.d \
./Application/Core/stm32wlxx_hal_msp.d \
./Application/Core/stm32wlxx_it.d \
./Application/Core/syscalls.d \
./Application/Core/sysmem.d 


# Each subdirectory must supply rules for building sources it contributes
Application/Core/main.o: /home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/main.c Application/Core/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../Core/Inc -I../../BFU/App -I../../BFU/Target -I../../../1_Image_SECoreBin/Inc -I../../../Linker_Common/STM32CubeIDE -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Interface -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -Os -ffunction-sections -fdata-sections -Wall -Wno-format -Wno-strict-aliasing -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"
Application/Core/%.o Application/Core/%.su Application/Core/%.cyclo: ../Application/Core/%.c Application/Core/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../Core/Inc -I../../BFU/App -I../../BFU/Target -I../../../1_Image_SECoreBin/Inc -I../../../Linker_Common/STM32CubeIDE -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Interface -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -Os -ffunction-sections -fdata-sections -Wall -Wno-format -Wno-strict-aliasing -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"
Application/Core/stm32wlxx_hal_msp.o: /home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/stm32wlxx_hal_msp.c Application/Core/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../Core/Inc -I../../BFU/App -I../../BFU/Target -I../../../1_Image_SECoreBin/Inc -I../../../Linker_Common/STM32CubeIDE -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Interface -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -Os -ffunction-sections -fdata-sections -Wall -Wno-format -Wno-strict-aliasing -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"
Application/Core/stm32wlxx_it.o: /home/clementc/code/gitlab.umu.se/reprod_fuota_automatic/expe_fuota/LoRaWAN_FUOTA/1_Image_BFU/Core/Src/stm32wlxx_it.c Application/Core/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../Core/Inc -I../../BFU/App -I../../BFU/Target -I../../../1_Image_SECoreBin/Inc -I../../../Linker_Common/STM32CubeIDE -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Interface -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -Os -ffunction-sections -fdata-sections -Wall -Wno-format -Wno-strict-aliasing -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Application-2f-Core

clean-Application-2f-Core:
	-$(RM) ./Application/Core/main.cyclo ./Application/Core/main.d ./Application/Core/main.o ./Application/Core/main.su ./Application/Core/sfu_secorebin_inc.cyclo ./Application/Core/sfu_secorebin_inc.d ./Application/Core/sfu_secorebin_inc.o ./Application/Core/sfu_secorebin_inc.su ./Application/Core/stm32wlxx_hal_msp.cyclo ./Application/Core/stm32wlxx_hal_msp.d ./Application/Core/stm32wlxx_hal_msp.o ./Application/Core/stm32wlxx_hal_msp.su ./Application/Core/stm32wlxx_it.cyclo ./Application/Core/stm32wlxx_it.d ./Application/Core/stm32wlxx_it.o ./Application/Core/stm32wlxx_it.su ./Application/Core/syscalls.cyclo ./Application/Core/syscalls.d ./Application/Core/syscalls.o ./Application/Core/syscalls.su ./Application/Core/sysmem.cyclo ./Application/Core/sysmem.d ./Application/Core/sysmem.o ./Application/Core/sysmem.su

.PHONY: clean-Application-2f-Core


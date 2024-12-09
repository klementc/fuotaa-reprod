################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/clementc/code/Drivers/STM32WLxx_HAL_Driver/Src/stm32wlxx_ll_utils.c 

OBJS += \
./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.o 

C_DEPS += \
./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.o: /home/clementc/code/Drivers/STM32WLxx_HAL_Driver/Src/stm32wlxx_ll_utils.c Drivers/STM32WLxx_LL_Driver/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DKMS_ENABLED -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../Core/Inc -I../../BFU/App -I../../BFU/Target -I../../../1_Image_SECoreBin/Inc -I../../../Linker_Common/STM32CubeIDE -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Core -I../../../../../../../Middlewares/ST/STM32_Secure_Engine/Interface -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/iKMS -Os -ffunction-sections -fdata-sections -Wall -Wno-format -Wno-strict-aliasing -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Drivers-2f-STM32WLxx_LL_Driver

clean-Drivers-2f-STM32WLxx_LL_Driver:
	-$(RM) ./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.cyclo ./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.d ./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.o ./Drivers/STM32WLxx_LL_Driver/stm32wlxx_ll_utils.su

.PHONY: clean-Drivers-2f-STM32WLxx_LL_Driver


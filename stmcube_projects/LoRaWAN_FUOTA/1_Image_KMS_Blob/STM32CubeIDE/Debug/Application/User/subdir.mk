################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Projects/NUCLEO-WL55JC/Applications/LoRaWAN_FUOTA/1_Image_KMS_Blob/Src/kms_blob_example_keys.c 

OBJS += \
./Application/User/kms_blob_example_keys.o 

C_DEPS += \
./Application/User/kms_blob_example_keys.d 


# Each subdirectory must supply rules for building sources it contributes
Application/User/kms_blob_example_keys.o: /home/clementc/Downloads/STM32Cube_FW_WL_V1.3.0/Projects/NUCLEO-WL55JC/Applications/LoRaWAN_FUOTA/1_Image_KMS_Blob/Src/kms_blob_example_keys.c Application/User/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32WL55xx -DCORE_CM4 -DDEBUG -c -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc -I../../../../../../../Drivers/STM32WLxx_HAL_Driver/Inc/Legacy -I../../../../../../../Drivers/CMSIS/Device/ST/STM32WLxx/Include -I../../../../../../../Drivers/CMSIS/Include -I../../../../../../../Drivers/BSP/STM32WLxx_Nucleo -I../../../../../../../Middlewares/ST/STM32_Key_Management_Services/Core -I../../../1_Image_SECoreBin/Inc -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Application-2f-User

clean-Application-2f-User:
	-$(RM) ./Application/User/kms_blob_example_keys.cyclo ./Application/User/kms_blob_example_keys.d ./Application/User/kms_blob_example_keys.o ./Application/User/kms_blob_example_keys.su

.PHONY: clean-Application-2f-User


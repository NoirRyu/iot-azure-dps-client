
echo .
echo "Using CMAKE to set up Azure projects"
echo .
cd deps\azure-iot-sdk-c
mkdir x86
mkdir arm
cd x86
cmake -G "Visual Studio 14 2015" .. -Ddps_auth_type=tpm
cd ..\arm
cmake -G "Visual Studio 14 2015 ARM" .. -Ddps_auth_type=tpm

echo .
echo "Building Azure SDK libraries"
echo .
cd ..\x86
msbuild c-utility\aziotsharedutil.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\dps_client.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\dps_http_transport.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\tools\tpm_device_provision\tpm_device_provision.vcxproj /p:TargetPlatformVersion=10.0.14393.0

cd ..\arm
msbuild c-utility\aziotsharedutil.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\dps_client.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\dps_http_transport.vcxproj /p:TargetPlatformVersion=10.0.14393.0
msbuild dps_client\tools\tpm_device_provision\tpm_device_provision.vcxproj /p:TargetPlatformVersion=10.0.14393.0

echo .
echo "Building IotDpsClient"
echo .
cd ..\..\..
msbuild src\IotDpsClient\IotDpsClient.vcxproj /p:Platform=Win32
msbuild src\IotDpsClient\IotDpsClient.vcxproj /p:Platform=ARM
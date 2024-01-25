@description('Specifies the location for resources.')
param location string = 'eastus'
param adminUsername string = 'azureuser'

param virtualMachines_contosovm1_name string = 'contosovm1'
param disks_contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Compute/disks/contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56'
param networkInterfaces_contosovm1402_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/networkInterfaces/contosovm1402'

resource virtualMachines_contosovm1_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_contosovm1_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition-hotpatch'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_contosovm1_name}_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_contosovm1_name
      adminUsername: adminUsername
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByPlatform'
          automaticByPlatformSettings: {
            rebootSetting: 'IfRequired'
            bypassPlatformSafetyChecksOnUserSchedule: false
          }
          assessmentMode: 'ImageDefault'
          enableHotpatching: true
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_contosovm1402_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Server'
  }
}

@description('Specifies the location for resources.')
param location string = 'southeastasia'
param adminUsername string = 'azureuser'
param adminPassword string =  'm@rkV!09'
param virtualMachines_ms365entvm1_name string = 'ms365entvm1'
//param disks_ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-bicep-rg/providers/Microsoft.Compute/disks/ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9'
param networkInterfaces_ms365entvm1478_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-bicep-rg/providers/Microsoft.Network/networkInterfaces/ms365entvm1478'

resource virtualMachines_ms365entvm1_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_ms365entvm1_name
  location: location
  tags: {
    vm1: 'ms365ent'
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
        name: '${virtualMachines_ms365entvm1_name}_OsDisk_1_b74a4fc838974739937149a2893c69c9'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          //id: disks_ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_ms365entvm1_name
      adminUsername: adminUsername
      adminPassword: adminPassword
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
      //requireGuestProvisionSignal: true
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
          id: networkInterfaces_ms365entvm1478_externalid
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
  }
}

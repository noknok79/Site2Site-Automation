@description('Specifies the location for resources.')
param location string = 'southeastasia'

param disks_ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9_name string = 'ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9'

resource disks_ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9_name_resource 'Microsoft.Compute/disks@2023-01-02' = {
  name: disks_ms365entvm1_OsDisk_1_b74a4fc838974739937149a2893c69c9_name
  location: location
  tags: {
    vm1: 'ms365ent'
  }
  sku: {
    name: 'Premium_LRS'
    tier: 'Premium'
  }
  properties: {
    osType: 'Windows'
    hyperVGeneration: 'V2'
    supportsHibernation: true
    supportedCapabilities: {
      diskControllerTypes: 'SCSI, NVMe'
      acceleratedNetwork: true
      architecture: 'x64'
    }
    creationData: {
      createOption: 'FromImage'
      imageReference: {
        id: '/Subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/Providers/Microsoft.Compute/Locations/southeastasia/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-datacenter-azure-edition-hotpatch/Versions/20348.2227.240104'
      }
    }
    diskSizeGB: 127
    diskIOPSReadWrite: 500
    diskMBpsReadWrite: 100
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    securityProfile: {
      securityType: 'TrustedLaunch'
    }
    publicNetworkAccess: 'Enabled'
    diskState: 'Attached'
    tier: 'P10'
  }
}

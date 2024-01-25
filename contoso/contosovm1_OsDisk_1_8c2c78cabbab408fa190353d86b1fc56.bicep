@description('Specifies the location for resources.')
param location string = 'eastus'

param disks_contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56_name string = 'contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56'

resource disks_contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56_name_resource 'Microsoft.Compute/disks@2023-01-02' = {
  name: disks_contosovm1_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  sku: {
    name: 'Premium_LRS'
    tier: 'Premium'
  }
  properties: {
    osType: 'Windows'
    hyperVGeneration: 'V2'
    //supportsHibernation: false
    supportedCapabilities: {
      diskControllerTypes: 'SCSI, NVMe'
      acceleratedNetwork: true
      architecture: 'x64'
    }
    creationData: {
      createOption: 'FromImage'
      imageReference: {
        id: '/Subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/Providers/Microsoft.Compute/Locations/eastus/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-datacenter-azure-edition-hotpatch/Versions/20348.2227.240104'
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
